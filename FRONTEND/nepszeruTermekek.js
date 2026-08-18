const API_BASE = "https://localhost:7249";
const NEPSZERU_ID_LISTA = [1, 2, 3, 10, 11, 19, 13];
let nepszeruCache = [];

async function loadNepszeruTermekek() {
  try {
    const response = await fetch(`${API_BASE}/Product`, {
      method: "GET",
      credentials: "include"
    });

    if (!response.ok) {
      throw new Error("Nem sikerült betölteni a népszerű termékeket.");
    }

    const osszesTermek = await response.json();
    nepszeruCache = NEPSZERU_ID_LISTA
      .map(id => osszesTermek.find(t => t.id === id))
      .filter(t => t !== undefined);

    renderNepszeruTermekek();
  } catch (error) {
    console.error(error);
    document.getElementById("nepszeru-lista").innerHTML =
      "<p class='kozepre'>Nem sikerült betölteni a népszerű termékeket.</p>";
  }
}

function renderNepszeruTermekek() {
  const container = document.getElementById("nepszeru-lista");
  container.innerHTML = "";

  nepszeruCache.forEach(termek => {
    const kepUrl = termek.image ? encodeURI(termek.image) : "";
    const kep = termek.image
      ? `<div class="termek-kep-wrapper" style="background-image: url('${kepUrl}');">
           <img src="${kepUrl}" alt="${termek.name}">
         </div>`
      : "";

    const kartya = document.createElement("div");
    kartya.className = "termek-kartya";
    kartya.style.cursor = "pointer";
    kartya.onclick = () => window.location.href = `Termekek.html?termek=${termek.id}`;
    kartya.innerHTML = `
      ${kep}
      <div class="termek-kartya-tartalom">
        <h3>${termek.name}</h3>
        <p class="termek-kartya-ar">${termek.price} Ft/${termek.unit}</p>
        <button class="btn-kosarba" onclick="event.stopPropagation(); kosarhozAd(nepszeruCache.find(t => t.id === ${termek.id}))">Kosárba</button>
      </div>
    `;

    container.appendChild(kartya);
  });
}

document.addEventListener("DOMContentLoaded", loadNepszeruTermekek);