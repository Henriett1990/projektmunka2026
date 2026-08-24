const API_BASE = "https://localhost:7249";

async function loadTermekek() {
  try {
    const response = await fetch(`${API_BASE}/Product`, {
      method: "GET",
      credentials: "include"
    });

    if (!response.ok) {
      throw new Error("Nem sikerült betölteni a termékeket.");
    }

    const termekek = await response.json();
    renderTermekek(termekek);

    const urlParameterek = new URLSearchParams(window.location.search);
    const kivalasztottId = urlParameterek.get("termek");
    if (kivalasztottId) {
      termekReszletMutat(parseInt(kivalasztottId));
    }
  } catch (error) {
    console.error(error);
    document.getElementById("termekek-lista").innerHTML =
      "<p class='kozepre'>Nem sikerült betölteni a termékeket. Próbáld újra később.</p>";
  }
}

let termekekCacheFrontend = [];

function rovidLeiras(szoveg, maxHossz) {
  if (szoveg.length <= maxHossz) return szoveg;
  return szoveg.substring(0, maxHossz).trim() + "...";
}

function renderTermekek(termekek) {
  termekekCacheFrontend = termekek;
  const container = document.getElementById("termekek-lista");
  container.className = "termek-kartyak";
  container.innerHTML = "";

  termekek.forEach(termek => {
    const kepUrl = termek.image ? encodeURI(termek.image) : "";
    const kep = termek.image
      ? `<div class="termek-kep-wrapper" style="background-image: url('${kepUrl}');">
           <img src="${kepUrl}" alt="${termek.name}">
         </div>`
      : "";

    const kartya = document.createElement("div");
    kartya.className = "termek-kartya";
    kartya.style.cursor = "pointer";
    kartya.onclick = () => termekReszletMutat(termek.id);
    kartya.innerHTML = `
      ${kep}
      <div class="termek-kartya-tartalom">
        <h3>${termek.name}</h3>
        <p class="termek-kartya-leiras">${rovidLeiras(termek.description, 150)}</p>
        <p class="termek-kartya-ar">${termek.price} Ft/${termek.unit}</p>
        <button class="btn-kosarba" onclick="event.stopPropagation(); kosarhozAd(termekekCacheFrontend.find(t => t.id === ${termek.id}))">Kosárba</button>
      </div>
    `;

    container.appendChild(kartya);
  });
}

function termekReszletMutat(id) {
  const termek = termekekCacheFrontend.find(t => t.id === id);
  if (!termek) return;

  const box = document.getElementById("termek-reszletek");
  const kepUrl = termek.image ? encodeURI(termek.image) : "";
  const kep = termek.image ? `<img src="${kepUrl}" alt="${termek.name}">` : "";

  box.innerHTML = `
  ${kep}
  <div class="termek-reszletek-tartalom">
    <div class="termek-reszletek-header">
      <h2>${termek.name}</h2>
      <button class="termek-reszletek-bezar" onclick="termekReszletBezar()">&times;</button>
    </div>
    <p class="termek-reszletek-leiras">${termek.description}</p>
    <p class="termek-reszletek-ar">Ár: ${termek.price} Ft</p>
    <p class="termek-reszletek-kiszereles">Kiszerelés: ${termek.unit}</p>
    <button class="btn-kosarba" onclick="kosarhozAd(termekekCacheFrontend.find(t => t.id === ${termek.id}))">Kosárba</button>
  </div>
`;

  box.style.display = "flex";
  box.scrollIntoView({ behavior: "smooth", block: "start" });
}

function termekReszletBezar() {
  document.getElementById("termek-reszletek").style.display = "none";
}

document.addEventListener("DOMContentLoaded", loadTermekek);