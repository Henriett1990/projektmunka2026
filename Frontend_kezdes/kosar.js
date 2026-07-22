function getKosar() {
  const adat = localStorage.getItem("kosar");
  return adat ? JSON.parse(adat) : [];
}

function mentKosar(kosar) {
  localStorage.setItem("kosar", JSON.stringify(kosar));
}

function kosarhozAd(termek) {
  const kosar = getKosar();
  const meglevo = kosar.find(t => t.id === termek.id);

  if (meglevo) {
    meglevo.mennyiseg += 1;
  } else {
    kosar.push({
      id: termek.id,
      name: termek.name,
      price: termek.price,
      unit: termek.unit,
      mennyiseg: 1
    });
  }

  mentKosar(kosar);
  frissitKosarSzamlalo();
  mutasdToaster(`${termek.name} bekerült a kosárba!`);
}

function kosarbolTorol(id) {
  let kosar = getKosar();
  kosar = kosar.filter(t => t.id !== id);
  mentKosar(kosar);
}

function mennyisegModosit(id, ujMennyiseg) {
  const kosar = getKosar();
  const termek = kosar.find(t => t.id === id);
  if (termek) {
    termek.mennyiseg = Math.max(1, ujMennyiseg);
    mentKosar(kosar);
  }
}

function kosarOsszesen() {
  return getKosar().reduce((osszeg, t) => osszeg + t.price * t.mennyiseg, 0);
}

function frissitKosarSzamlalo() {
  const szamlaloElem = document.getElementById("kosar-szamlalo");
  if (!szamlaloElem) return;
  const kosar = getKosar();
  const darabszam = kosar.reduce((sum, t) => sum + t.mennyiseg, 0);
  szamlaloElem.textContent = darabszam;
}

document.addEventListener("DOMContentLoaded", frissitKosarSzamlalo);

function mutasdToaster(uzenet) {
  let toaster = document.getElementById("kosar-toaster");

  if (!toaster) {
    toaster = document.createElement("div");
    toaster.id = "kosar-toaster";
    toaster.style.position = "fixed";
    toaster.style.bottom = "20px";
    toaster.style.right = "20px";
    toaster.style.backgroundColor = "rgba(255, 255, 255, 0.9)";
    toaster.style.color = "#333";
    toaster.style.fontWeight = "bold";
    toaster.style.height = "24px";
    toaster.style.padding = "36px 20px";
    toaster.style.borderRadius = "6px";
    toaster.style.boxShadow = "0 6px 24px rgba(0,0,0,0.4)";
    toaster.style.zIndex = "9999";
    toaster.style.transition = "opacity 0.6s ease";
    document.body.appendChild(toaster);
  }

  toaster.textContent = uzenet;
  toaster.style.opacity = "1";
  toaster.style.display = "flex";
    toaster.style.alignItems = "center";
    toaster.style.justifyContent = "center";

  clearTimeout(window.toasterIdozito);
  window.toasterIdozito = setTimeout(() => {
    toaster.style.opacity = "0";
    setTimeout(() => { toaster.style.display = "none"; }, 600);
  }, 3000);
}