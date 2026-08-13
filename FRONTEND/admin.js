const API_BASE = "https://localhost:7249";

async function checkAuthStatus() {
  try {
    const response = await fetch(`${API_BASE}/Auth/me`, {
      method: "GET",
      credentials: "include"
    });

    if (!response.ok) {
      showLoginPanel();
      return;
    }

    const data = await response.json();

    if (data.isAdmin) {
      showAdminPanel(data.userName);
    } else {
      showUserPanel(data.userName);
    }
  } catch (error) {
    console.error(error);
    showLoginPanel();
  }
}

async function handleLogin() {
  const email = document.getElementById("login-email").value;
  const password = document.getElementById("login-password").value;
  const hibaElem = document.getElementById("login-hiba");

  try {
    const response = await fetch(`${API_BASE}/Auth/login`, {
      method: "POST",
      credentials: "include",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ email, password })
    });

    if (!response.ok) {
      hibaElem.textContent = "Hibás email vagy jelszó.";
      return;
    }

    checkAuthStatus();
  } catch (error) {
    console.error(error);
    hibaElem.textContent = "Hiba történt a bejelentkezés során.";
  }
}

async function handleLogout() {
  await fetch(`${API_BASE}/Auth/logout`, {
    method: "POST",
    credentials: "include"
  });
  showLoginPanel();
}

function showLoginPanel(hibaSzoveg) {
  document.getElementById("login-panel").style.display = "block";
  document.getElementById("admin-panel").style.display = "none";
  document.getElementById("user-panel").style.display = "none";
  if (hibaSzoveg) {
    document.getElementById("login-hiba").textContent = hibaSzoveg;
  }
}

function showAdminPanel(userName) {
  document.getElementById("login-panel").style.display = "none";
  document.getElementById("admin-panel").style.display = "block";
  document.getElementById("user-panel").style.display = "none";
  document.getElementById("udvozles").textContent = `Bejelentkezve: ${userName}`;
  loadTermekekAdmin();
}

document.addEventListener("DOMContentLoaded", checkAuthStatus);

let termekekCache = [];

async function loadTermekekAdmin() {
  const response = await fetch(`${API_BASE}/Product`, { credentials: "include" });
  termekekCache = await response.json();
  renderTermekekTabla();
}

function renderTermekekTabla() {
  const tbody = document.getElementById("termekek-tabla");
  tbody.innerHTML = "";

  termekekCache.forEach(termek => {
    const tr = document.createElement("tr");
    tr.innerHTML = `
      <td>${termek.id}</td>
      <td>${termek.category}</td>
      <td>${termek.name}</td>
      <td>${termek.unit}</td>
      <td>${termek.price}</td>
      <td>${termek.stock}</td>
      <td>
        <button class="btn btn-sm btn-primary" onclick="fillFormForEdit(${termek.id})">Szerkeszt</button>
        <button class="btn btn-sm btn-danger" onclick="handleDeleteProduct(${termek.id})">Törlés</button>
      </td>
    `;
    tbody.appendChild(tr);
  });
}

function fillFormForEdit(id) {
  const termek = termekekCache.find(t => t.id === id);
  if (!termek) return;

  document.getElementById("termek-id").value = termek.id;
  document.getElementById("termek-category").value = termek.category;
  document.getElementById("termek-name").value = termek.name;
  document.getElementById("termek-unit").value = termek.unit;
  document.getElementById("termek-price").value = termek.price;
  document.getElementById("termek-description").value = termek.description;
  document.getElementById("termek-image").value = termek.image || "";
  document.getElementById("termek-stock").value = termek.stock;
}

function resetForm() {
  document.getElementById("termek-id").value = "";
  document.getElementById("termek-category").value = "";
  document.getElementById("termek-name").value = "";
  document.getElementById("termek-unit").value = "";
  document.getElementById("termek-price").value = "";
  document.getElementById("termek-description").value = "";
  document.getElementById("termek-image").value = "";
  document.getElementById("termek-stock").value = "";
  document.getElementById("termek-uzenet").textContent = "";
}

async function handleSaveProduct() {
  const id = document.getElementById("termek-id").value;
  const uzenetElem = document.getElementById("termek-uzenet");

  const termekAdat = {
    category: document.getElementById("termek-category").value,
    name: document.getElementById("termek-name").value,
    unit: document.getElementById("termek-unit").value,
    price: parseInt(document.getElementById("termek-price").value),
    description: document.getElementById("termek-description").value,
    image: document.getElementById("termek-image").value || null,
    stock: parseInt(document.getElementById("termek-stock").value)
  };

  const url = id ? `${API_BASE}/Product/${id}` : `${API_BASE}/Product`;
  const method = id ? "PUT" : "POST";

  try {
    const response = await fetch(url, {
      method: method,
      credentials: "include",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(termekAdat)
    });

    if (!response.ok) {
      uzenetElem.style.color = "red";
      uzenetElem.textContent = "Hiba történt a mentés során.";
      return;
    }

    uzenetElem.style.color = "green";
    uzenetElem.textContent = id ? "Termék sikeresen módosítva!" : "Termék sikeresen hozzáadva!";
    resetForm();
    loadTermekekAdmin();
  } catch (error) {
    console.error(error);
    uzenetElem.style.color = "red";
    uzenetElem.textContent = "Hiba történt a mentés során.";
  }
}

async function handleDeleteProduct(id) {
  if (!confirm("Biztosan törlöd ezt a terméket?")) return;

  try {
    const response = await fetch(`${API_BASE}/Product/${id}`, {
      method: "DELETE",
      credentials: "include"
    });

    if (!response.ok) {
      alert("Hiba történt a törlés során.");
      return;
    }

    loadTermekekAdmin();
  } catch (error) {
    console.error(error);
    alert("Hiba történt a törlés során.");
  }
}

function showUserPanel(userName) {
  document.getElementById("login-panel").style.display = "none";
  document.getElementById("admin-panel").style.display = "none";
  document.getElementById("user-panel").style.display = "block";
  document.getElementById("user-udvozles").textContent = `Bejelentkezve: ${userName}`;
}

let regisztracioMod = false;

function toggleFormMode() {
  regisztracioMod = !regisztracioMod;

  document.getElementById("register-fields").style.display = regisztracioMod ? "block" : "none";
  document.getElementById("login-gomb").style.display = regisztracioMod ? "none" : "inline-block";
  document.getElementById("register-gomb").style.display = regisztracioMod ? "inline-block" : "none";
  document.getElementById("form-cim").textContent = regisztracioMod ? "Regisztráció" : "Bejelentkezés";
  document.getElementById("mod-valto-link").textContent = regisztracioMod
    ? "Van már fiókod? Jelentkezz be!"
    : "Nincs még fiókod? Regisztrálj!";
  document.getElementById("login-hiba").textContent = "";
  document.getElementById("login-siker").textContent = "";
}

async function handleRegister() {
  const userName = document.getElementById("register-username").value;
  const email = document.getElementById("login-email").value;
  const password = document.getElementById("login-password").value;
  const hibaElem = document.getElementById("login-hiba");
  const sikerElem = document.getElementById("login-siker");

  hibaElem.textContent = "";
  sikerElem.textContent = "";

  try {
    const response = await fetch(`${API_BASE}/Auth/register`, {
      method: "POST",
      credentials: "include",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ userName, email, password })
    });

    if (!response.ok) {
      const hibaAdat = await response.json();
      hibaElem.textContent = hibaAdat.message || "Hiba történt a regisztráció során.";
      return;
    }

    sikerElem.textContent = "Sikeres regisztráció! Most már bejelentkezhetsz.";
    toggleFormMode();
  } catch (error) {
    console.error(error);
    hibaElem.textContent = "Hiba történt a regisztráció során.";
  }
}