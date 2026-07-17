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
      <td><button class="btn btn-sm btn-danger" onclick="kosarbolTorol(${termek.id}); renderKosarTabla();">Törlés</button></td>
    `;
    tbody.appendChild(tr);
  });

  document.getElementById("kosar-vegosszeg").textContent = kosarOsszesen();
}

function rendelesLeadasa() {
  document.getElementById("rendeles-uzenet").textContent = "Ez a funkció hamarosan elérhető lesz (email küldés).";
}

document.addEventListener("DOMContentLoaded", renderKosarTabla);