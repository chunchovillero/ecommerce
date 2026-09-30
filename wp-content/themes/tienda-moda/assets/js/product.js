(() => {
	'use strict';
	const dialog = document.querySelector('#size-guide-dialog');
	const opener = document.querySelector('[data-size-guide-open]');
	const closer = document.querySelector('[data-size-guide-close]');
	if (!dialog || !opener || !closer) return;
	opener.addEventListener('click', () => dialog.showModal());
	closer.addEventListener('click', () => dialog.close());
	dialog.addEventListener('click', (event) => {
		const rect = dialog.getBoundingClientRect();
		const inside = event.clientX >= rect.left && event.clientX <= rect.right && event.clientY >= rect.top && event.clientY <= rect.bottom;
		if (!inside) dialog.close();
	});
})();
