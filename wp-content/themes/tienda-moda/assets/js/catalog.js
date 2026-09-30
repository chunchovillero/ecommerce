(() => {
	'use strict';
	const toggle = document.querySelector('.filter-toggle');
	const panel = document.querySelector('.catalog-filters');
	const overlay = document.querySelector('.filter-overlay');
	const closers = document.querySelectorAll('[data-filter-close]');
	if (!toggle || !panel || !overlay) return;
	const open = () => {
		panel.setAttribute('aria-hidden', 'false');
		toggle.setAttribute('aria-expanded', 'true');
		overlay.hidden = false;
		document.body.classList.add('filters-open');
		const first = panel.querySelector('button, select, input, a');
		if (first) first.focus();
	};
	const close = () => {
		panel.setAttribute('aria-hidden', 'true');
		toggle.setAttribute('aria-expanded', 'false');
		overlay.hidden = true;
		document.body.classList.remove('filters-open');
		toggle.focus();
	};
	toggle.addEventListener('click', open);
	closers.forEach((item) => item.addEventListener('click', close));
	document.addEventListener('keydown', (event) => {
		if (event.key === 'Escape' && panel.getAttribute('aria-hidden') === 'false') close();
	});
})();
