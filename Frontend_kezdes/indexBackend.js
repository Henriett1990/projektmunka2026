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
  } catch (error) {
    console.error(error);
    document.getElementById("termekek-lista").innerHTML =
      "<p class='kozepre'>Nem sikerült betölteni a termékeket. Próbáld újra később.</p>";
  }
}

let termekekCacheFrontend = [];

function renderTermekek(termekek) {
  termekekCacheFrontend = termekek;
  const container = document.getElementById("termekek-lista");
  container.innerHTML = "";

  termekek.forEach((termek, index) => {
    const kep = termek.image
      ? `<img class="responsive img-thumbnail kicsinyites kozepre" src="${encodeURI(termek.image)}" alt="${termek.name}">`
      : "";

    const row = document.createElement("div");
    row.className = "row";
    row.innerHTML = `
      <div class="col-lg-4 col-sm-12">
        ${kep}
      </div>
      <div class="col-lg-8 col-sm-12">
        <p class="felkover nagyobbbetu">${index + 1}. ${termek.name}</p>
        <br>
        <p>${termek.description}</p>
        <p><span class="felkover">Ára: ${termek.price} Ft/${termek.unit}</span> (Az ár az ÁFÁ-t tartalmazza.)</p>
        <button class="btn btn-warning" onclick="kosarhozAd(termekekCacheFrontend.find(t => t.id === ${termek.id}))">Kosárba</button>
        <br><br><br>
      </div>
    `;

    container.appendChild(row);
  });
}


document.addEventListener("DOMContentLoaded", loadTermekek);