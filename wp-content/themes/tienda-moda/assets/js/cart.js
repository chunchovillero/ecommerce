(() => {
	'use strict';
	const drawer = document.querySelector('.mini-cart-drawer');
	const overlay = document.querySelector('.mini-cart-overlay');
	const cartLink = document.querySelector('.header-cart');
	const closers = document.querySelectorAll('[data-mini-cart-close]');
	if (!drawer || !overlay || !cartLink) return;
	let lastFocused = null;
	const focusables = () => drawer.querySelectorAll('a[href], button:not([disabled]), input:not([disabled]), [tabindex]:not([tabindex="-1"])');
	const open = (message = '') => {
		lastFocused = document.activeElement;
		drawer.setAttribute('aria-hidden', 'false');
		overlay.hidden = false;
		document.body.classList.add('mini-cart-open');
		const notice = drawer.querySelector('.mini-cart-notice');
		if (notice) notice.textContent = message;
		const items = focusables();
		if (items.length) items[0].focus();
	};
	const close = () => {
		drawer.setAttribute('aria-hidden', 'true');
		overlay.hidden = true;
		document.body.classList.remove('mini-cart-open');
		if (lastFocused) lastFocused.focus();
	};
	cartLink.addEventListener('click', (event) => {
		if (event.metaKey || event.ctrlKey || event.shiftKey || event.altKey) return;
		event.preventDefault();
		open();
	});
	closers.forEach((element) => element.addEventListener('click', close));
	document.addEventListener('keydown', (event) => {
		if (event.key === 'Escape' && drawer.getAttribute('aria-hidden') === 'false') close();
		if (event.key !== 'Tab' || drawer.getAttribute('aria-hidden') !== 'false') return;
		const items = [...focusables()];
		if (!items.length) return;
		if (event.shiftKey && document.activeElement === items[0]) {
			event.preventDefault();
			items[items.length - 1].focus();
		} else if (!event.shiftKey && document.activeElement === items[items.length - 1]) {
			event.preventDefault();
			items[0].focus();
		}
	});
	if (window.jQuery) {
		window.jQuery(document.body).on('added_to_cart', () => open('Producto agregado al carrito.'));
	}
})();
