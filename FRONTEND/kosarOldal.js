function renderKosarTabla() {
  const kosar = getKosar();
  const tbody = document.getElementById("kosar-tabla");
  tbody.innerHTML = "";

  kosar.forEach(termek => {
    const tr = document.createElement("tr");
    tr.innerHTML = `
      <td>${termek.name}</td>
      <td>${termek.price} Ft/${termek.unit}</td>
      <td>
        <input type="number" min="1" value="${termek.mennyiseg}" style="width: 60px;"
          onchange="mennyisegModosit(${termek.id}, parseInt(this.value)); renderKosarTabla();">
      </td>
      <td>${termek.price * termek.mennyiseg} Ft</td>
      <td><button class="kosar-torles-gomb" onclick="kosarbolTorol(${termek.id}); renderKosarTabla();">Törlés</button></td>
    `;
    tbody.appendChild(tr);
  });

  document.getElementById("kosar-vegosszeg").textContent = kosarOsszesen();
}


async function rendelesLeadasa() {
  const kosar = getKosar();
  const uzenet = document.getElementById("rendeles-uzenet");

  if (kosar.length === 0) {
    uzenet.textContent = "A kosarad üres.";
    return;
  }

  const items = kosar.map(t => ({
    id: t.id,
    name: t.name,
    price: t.price,
    quantity: t.mennyiseg
  }));

  try {
    const response = await fetch("https://localhost:7249/Order", {
      method: "POST",
      credentials: "include",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({ items })
    });

    if (response.ok) {
      localStorage.removeItem("kosar");
      uzenet.textContent = "Rendelésed sikeresen leadva! Köszönjük!";
      renderKosarTabla();
    } else if (response.status === 401) {
      uzenet.textContent = "A rendeléshez be kell jelentkezned.";
    } else {
      uzenet.textContent = "Hiba történt a rendelés leadásakor.";
    }
  } catch (err) {
    uzenet.textContent = "Nem sikerült kapcsolódni a szerverhez.";
  }
}


document.addEventListener("DOMContentLoaded", renderKosarTabla);