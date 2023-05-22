function apriBilling() {
	document.querySelector(".sfondo").style.display = "block";
	document.querySelector(".container").style.display = "block";
	document.querySelector(".image").style.display = "block";
}

function confermaPagamento() {
	document.querySelector(".modal").style.display = "block";
	document.querySelector(".sfondo").style.display = "block";
	document.querySelector(".modal-content").style.display = "block";
}

// Funzione Bottone chiudi
function annulla() {
	fetch(`https://${GetParentResourceName()}/annulla`, {
		method: "POST",
		headers: {
			"Content-Type": "application/json; charset=UTF-8",
		},
		body: JSON.stringify({
			importo: document.querySelector("#annullare").value,
		}),
	}).then((resp) => resp.json());

	document.querySelector("#annullare").value = "";
	document.querySelector(".sfondo").style.display = "none";
	document.querySelector(".container").style.display = "none";
}

// Funzione per inviare una fattura ad un Giocatore
function invia() {
	fetch(`https://${GetParentResourceName()}/invia`, {
		method: "POST",
		headers: {
			"Content-Type": "application/json; charset=UTF-8",
		},
		body: JSON.stringify({
			importo: document.querySelector("#trasfe2").value,
			destinatario: document.querySelector("#trasfe1").value,
			id: document.querySelector("#trasfe1").value,
		}),
	}).then((resp) => resp.json());

	document.querySelector("#trasfe1").value = "";
	document.querySelector("#trasfe2").value = "";

	document.querySelector(".sfondo").style.display = "none";
	document.querySelector(".container").style.display = "none";
	document.querySelector(".modal-content").style.display = "none";
	// document.querySelector(".modal").style.display = "none";
}

// Funzione per pagare la fattura
function effettuaPagamento() {
	const destinatario = document.querySelector("#trasfe1").value;
	const importo = document.querySelector("#trasfe2").value;

	fetch(`https://${GetParentResourceName()}/paga`, {
		method: "POST",
		headers: {
			"Content-Type": "application/json; charset=UTF-8",
		},
		body: JSON.stringify({
			importo: importo,
			destinatario: destinatario,
			id: destinatario,
		}),
	}).then((resp) => resp.json());

	document.querySelector("#trasfe1").value = "";
	document.querySelector("#trasfe2").value = "";

	document.querySelector(".sfondo").style.display = "none";
	document.querySelector(".container").style.display = "none";
	document.querySelector(".modal-content").style.display = "none";
	// document.querySelector(".modal").style.display = "none";
}

// Funzione non consentita per inviare la fattura a te stesso
function confermaPagamento() {
	const destinatario = document.querySelector("#trasfe1").value;
	const importo = document.querySelector("#trasfe2").value;

	// Verifica se il destinatario è uguale all'id del mittente
	if (destinatario === document.querySelector("#trasfe1").value) {
		// Il destinatario è lo stesso del mittente, mostra un messaggio di errore o gestisci il caso appropriatamente
		alert("Non puoi fare la fattura a te stesso.");
		throw new Error("Fatturazione a se stesso non consentita.");
	}

	document.querySelector(".modal").style.display = "block";
	document.querySelector(".sfondo").style.display = "block";
	document.querySelector(".modal-content").style.display = "block";
}


// Funzione di chiusura della Nui
document.onkeydown = function (evt) {
	evt = evt || window.event;
	var isEscape = false;
	if ("key" in evt) {
		isEscape = evt.key === "Escape" || evt.key === "Esc";
	} else {
		isEscape = evt.keyCode === 27;
	}
	if (isEscape) {
		fetch(`https://${GetParentResourceName()}/chiudi`, {
			method: "POST",
			headers: {
				"Content-Type": "application/json; charset=UTF-8",
			},
			body: JSON.stringify({}),
		}).then((resp) => resp.json());

		document.querySelector(".sfondo").style.display = "none";
		document.querySelector(".container").style.display = "none";
		document.querySelector(".modal-content").style.display = "none";
		// document.querySelector(".modal").style.display = "none";
	}
};

// Funzione di Apertura della Nui
window.addEventListener("message", function (event) {
	let data = event.data;
	if (data.type === "apriBilling") {
		apriBilling();
	} else if (data.type === "effettuaPagamento") {
		confermaPagamento();
	}
});
