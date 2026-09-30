(() => {
	'use strict';
	const rut = document.querySelector('#billing_rut');
	if (!rut) return;
	const format = (value) => {
		const clean = value.toUpperCase().replace(/[^0-9K]/g, '').slice(0, 9);
		if (clean.length < 2) return clean;
		const body = clean.slice(0, -1).replace(/\B(?=(\d{3})+(?!\d))/g, '.');
		return body + '-' + clean.slice(-1);
	};
	rut.addEventListener('input', () => {
		const cursorAtEnd = rut.selectionStart === rut.value.length;
		rut.value = format(rut.value);
		if (cursorAtEnd) rut.setSelectionRange(rut.value.length, rut.value.length);
	});
})();
