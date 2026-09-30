(() => {
	'use strict';

	const toggle = document.querySelector('.menu-toggle');
	const drawer = document.querySelector('.mobile-drawer');
	const overlay = document.querySelector('.drawer-overlay');
	const closeButtons = document.querySelectorAll('[data-drawer-close]');

	if (!toggle || !drawer || !overlay) {
		return;
	}

	let lastFocused = null;

	const focusableElements = () => drawer.querySelectorAll(
		'a[href], button:not([disabled]), input:not([disabled]), select:not([disabled]), textarea:not([disabled]), [tabindex]:not([tabindex="-1"])'
	);

	const openDrawer = () => {
		lastFocused = document.activeElement;
		drawer.setAttribute('aria-hidden', 'false');
		toggle.setAttribute('aria-expanded', 'true');
		overlay.hidden = false;
		document.body.classList.add('drawer-open');
		const focusable = focusableElements();
		if (focusable.length) {
			focusable[0].focus();
		}
	};

	const closeDrawer = () => {
		drawer.setAttribute('aria-hidden', 'true');
		toggle.setAttribute('aria-expanded', 'false');
		overlay.hidden = true;
		document.body.classList.remove('drawer-open');
		if (lastFocused) {
			lastFocused.focus();
		}
	};

	toggle.addEventListener('click', openDrawer);
	closeButtons.forEach((button) => button.addEventListener('click', closeDrawer));

	document.addEventListener('keydown', (event) => {
		if (event.key === 'Escape' && drawer.getAttribute('aria-hidden') === 'false') {
			closeDrawer();
		}

		if (event.key !== 'Tab' || drawer.getAttribute('aria-hidden') === 'true') {
			return;
		}

		const focusable = [...focusableElements()];
		if (!focusable.length) {
			return;
		}

		const first = focusable[0];
		const last = focusable[focusable.length - 1];

		if (event.shiftKey && document.activeElement === first) {
			event.preventDefault();
			last.focus();
		} else if (!event.shiftKey && document.activeElement === last) {
			event.preventDefault();
			first.focus();
		}
	});
})();
