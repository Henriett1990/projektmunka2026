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
      frissitKosarSzamlalo();
      document.getElementById("kosar-tartalom").style.display = "none";
      document.getElementById("rendeles-sikeres").style.display = "block";
    } else if (response.status === 401) {
      uzenet.textContent = "A rendeléshez be kell jelentkezned.";
      document.getElementById("rendeles-gomb").style.display = "none";
      document.getElementById("bejelentkezes-gomb").style.display = "inline-block";
    } else {
      uzenet.textContent = "Hiba történt a rendelés leadásakor.";
    }
  } catch (err) {
    uzenet.textContent = "Nem sikerült kapcsolódni a szerverhez.";
  }
}

function mutasdKosarBejelentkezes() {
  document.getElementById("kosar-bejelentkezes").style.display = "block";
}

async function kosarBejelentkezes() {
  const email = document.getElementById("kosar-login-email").value;
  const password = document.getElementById("kosar-login-password").value;
  const hibaElem = document.getElementById("kosar-login-hiba");

  try {
    const response = await fetch("https://localhost:7249/Auth/login", {
      method: "POST",
      credentials: "include",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ email, password })
    });

    if (!response.ok) {
      hibaElem.textContent = "Hibás email vagy jelszó.";
      return;
    }

    document.getElementById("kosar-bejelentkezes").style.display = "none";
    document.getElementById("bejelentkezes-gomb").style.display = "none";
    document.getElementById("rendeles-gomb").style.display = "inline-block";
    document.getElementById("rendeles-uzenet").textContent = "Sikeres bejelentkezés! Most már leadhatod a rendelést.";
    frissitAuthNav();
  } catch (error) {
    console.error(error);
    hibaElem.textContent = "Hiba történt a bejelentkezés során.";
  }
}

document.addEventListener("DOMContentLoaded", renderKosarTabla);