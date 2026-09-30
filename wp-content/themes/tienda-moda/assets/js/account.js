(() => {
	'use strict';
	const rut = document.querySelector('#account_rut');
	if (!rut) return;
	rut.addEventListener('input', () => {
		const clean = rut.value.toUpperCase().replace(/[^0-9K]/g, '').slice(0, 9);
		if (clean.length < 2) {
			rut.value = clean;
			return;
		}
		const body = clean.slice(0, -1).replace(/\B(?=(\d{3})+(?!\d))/g, '.');
		rut.value = body + '-' + clean.slice(-1);
	});
})();
