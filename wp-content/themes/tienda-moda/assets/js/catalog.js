(() => {
	'use strict';
	const toggle = document.querySelector('.filter-toggle');
	const panel = document.querySelector('.catalog-filters');
	const overlay = document.querySelector('.filter-overlay');
	const closers = document.querySelectorAll('[data-filter-close]');
	if (!toggle || !panel || !overlay) return;

	let lastFocused = null;
	const focusables = () => panel.querySelectorAll('a[href], button:not([disabled]), input:not([disabled]), select:not([disabled]), [tabindex]:not([tabindex="-1"])');

	const open = () => {
		lastFocused = document.activeElement;
		panel.setAttribute('aria-hidden', 'false');
		panel.removeAttribute('inert');
		toggle.setAttribute('aria-expanded', 'true');
		overlay.hidden = false;
		document.body.classList.add('filters-open');
		const items = focusables();
		if (items.length) items[0].focus();
	};
	const close = () => {
		panel.setAttribute('aria-hidden', 'true');
		panel.setAttribute('inert', '');
		toggle.setAttribute('aria-expanded', 'false');
		overlay.hidden = true;
		document.body.classList.remove('filters-open');
		if (lastFocused) lastFocused.focus();
	};

	const breakpoint = window.matchMedia('(max-width: 900px)');
	const syncPanel = () => {
		if (breakpoint.matches) {
			if (panel.getAttribute('aria-hidden') !== 'false') {
				panel.setAttribute('aria-hidden', 'true');
				panel.setAttribute('inert', '');
			}
		} else {
			panel.removeAttribute('inert');
			panel.removeAttribute('aria-hidden');
			overlay.hidden = true;
			document.body.classList.remove('filters-open');
		}
	};
	syncPanel();
	breakpoint.addEventListener('change', syncPanel);
	toggle.addEventListener('click', open);
	closers.forEach((item) => item.addEventListener('click', close));
	document.addEventListener('keydown', (event) => {
		if (event.key === 'Escape' && panel.getAttribute('aria-hidden') === 'false') close();
		if (event.key !== 'Tab' || panel.getAttribute('aria-hidden') !== 'false') return;
		const items = [...focusables()];
		if (!items.length) return;
		const first = items[0];
		const last = items[items.length - 1];
		if (event.shiftKey && document.activeElement === first) {
			event.preventDefault();
			last.focus();
		} else if (!event.shiftKey && document.activeElement === last) {
			event.preventDefault();
			first.focus();
		}
	});
})();
