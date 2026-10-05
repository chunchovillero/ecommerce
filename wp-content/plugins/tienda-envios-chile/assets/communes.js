(() => {
	'use strict';
	const config = window.tiendaEnviosChile || { communes: {}, placeholder: 'Selecciona una comuna' };
	const populate = (type, reset = false) => {
		const region = document.querySelector(`#${type}_state`);
		const commune = document.querySelector(`#${type}_city`);
		if (!region || !commune || commune.tagName !== 'SELECT') return;
		const previous = reset ? '' : commune.value;
		const choices = config.communes[region.value] || [];
		commune.replaceChildren(new Option(config.placeholder, ''));
		choices.forEach((name) => commune.add(new Option(name, name)));
		commune.value = choices.includes(previous) ? previous : '';
		commune.disabled = choices.length === 0;
		if (window.jQuery && window.jQuery.fn.select2) window.jQuery(commune).trigger('change.select2');
	};
	const initialize = () => { populate('billing'); populate('shipping'); };
	document.addEventListener('change', (event) => {
		if (event.target.matches('#billing_state')) populate('billing', true);
		if (event.target.matches('#shipping_state')) populate('shipping', true);
	});
	initialize();
	document.addEventListener('DOMContentLoaded', initialize);
	if (window.jQuery) {
		const $body = window.jQuery(document.body);
		$body.on('updated_checkout', initialize);
		$body.on('change', '#billing_state', () => populate('billing', true));
		$body.on('change', '#shipping_state', () => populate('shipping', true));
		const updatePickup = () => {
			const selected = document.querySelector('input[name^="shipping_method"]:checked');
			const field = document.querySelector('#tienda_envios_chile_pickup_location_field');
			if (field) field.hidden = !selected || !selected.value.includes('pickup');
		};
		$body.on('updated_checkout change', 'input[name^="shipping_method"]', updatePickup);
		$body.on('updated_checkout', updatePickup);
		updatePickup();
		const updateConditionalFields = () => {
			const invoice = document.querySelector('#billing_document_type')?.value === 'factura';
			document.querySelectorAll('.tienda-envios-chile-invoice').forEach((field) => { field.hidden = !invoice; });
			const shipping = document.querySelector('input[name^="shipping_method"]:checked')?.value || '';
			const acceptance = document.querySelector('.tienda-envios-chile-collect-accept');
			if (acceptance) acceptance.hidden = !shipping.includes('collect');
		};
		$body.on('updated_checkout change', '#billing_document_type,input[name^="shipping_method"]', updateConditionalFields);
		$body.on('updated_checkout', updateConditionalFields);
		updateConditionalFields();
	}

	const rut = document.querySelector('#billing_rut');
	if (rut) {
		const formatRut = (value) => {
			const clean = value.toUpperCase().replace(/[^0-9K]/g, '').slice(0, 9);
			if (clean.length < 2) return clean;
			const body = clean.slice(0, -1).replace(/\B(?=(\d{3})+(?!\d))/g, '.');
			return body + '-' + clean.slice(-1);
		};
		rut.addEventListener('input', () => {
			const cursorAtEnd = rut.selectionStart === rut.value.length;
			rut.value = formatRut(rut.value);
			if (cursorAtEnd) rut.setSelectionRange(rut.value.length, rut.value.length);
		});
	}
	const phone = document.querySelector('#billing_phone');
	if (phone) phone.addEventListener('blur', () => { const digits = phone.value.replace(/\D/g, '').replace(/^56/, '').slice(0, 9); if (digits.length === 9) phone.value = `+56 ${digits[0]} ${digits.slice(1, 5)} ${digits.slice(5)}`; });
})();
