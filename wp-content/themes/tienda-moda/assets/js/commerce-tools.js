(() => {
	'use strict';

	const config = window.tiendaModaTools;
	if (!config) return;

	const storageKey = 'tienda_moda_wishlist';
	const readGuestIds = () => {
		try {
			const value = JSON.parse(localStorage.getItem(storageKey) || '[]');
			return Array.isArray(value) ? value.map(Number).filter(Number.isInteger) : [];
		} catch (error) {
			return [];
		}
	};
	const writeGuestIds = (ids) => localStorage.setItem(storageKey, JSON.stringify(ids));
	let wishlistIds = config.isLoggedIn ? config.wishlistIds.map(Number) : readGuestIds();

	const post = async (action, values = {}) => {
		const body = new FormData();
		body.append('action', action);
		body.append('nonce', config.nonce);
		Object.entries(values).forEach(([key, value]) => {
			if (Array.isArray(value)) value.forEach((item) => body.append(key + '[]', item));
			else body.append(key, value);
		});
		const response = await fetch(config.ajaxUrl, { method: 'POST', credentials: 'same-origin', body });
		const payload = await response.json();
		if (!response.ok || !payload.success) throw new Error(payload.data?.message || config.errorMessage);
		return payload.data;
	};

	const updateWishlistUI = () => {
		document.querySelectorAll('[data-wishlist-toggle]').forEach((button) => {
			const active = wishlistIds.includes(Number(button.dataset.productId));
			button.classList.toggle('is-active', active);
			button.setAttribute('aria-pressed', String(active));
			const label = active ? 'Quitar de favoritos' : 'Agregar a favoritos';
			button.setAttribute('aria-label', label);
			const text = button.querySelector('.wishlist-button-label');
			if (text) text.textContent = label;
		});
		document.querySelectorAll('.wishlist-count').forEach((count) => {
			count.textContent = wishlistIds.length;
		});
	};

	const refreshGuestGrid = async () => {
		const grid = document.querySelector('[data-wishlist-grid]');
		const empty = document.querySelector('[data-wishlist-empty]');
		if (!grid || config.isLoggedIn) return;
		if (!wishlistIds.length) {
			grid.innerHTML = '';
			if (empty) empty.hidden = false;
			return;
		}
		try {
			const data = await post('tienda_moda_wishlist_products', { ids: wishlistIds });
			grid.innerHTML = data.html;
			if (empty) empty.hidden = Boolean(data.count);
			updateWishlistUI();
		} catch (error) {
			if (empty) {
				empty.hidden = false;
				empty.textContent = error.message;
			}
		}
	};

	document.addEventListener('click', async (event) => {
		const button = event.target.closest('[data-wishlist-toggle]');
		if (!button) return;
		const productId = Number(button.dataset.productId);
		if (!productId || button.disabled) return;
		button.disabled = true;
		try {
			if (config.isLoggedIn) {
				const data = await post('tienda_moda_toggle_wishlist', { product_id: productId });
				wishlistIds = data.ids.map(Number);
			} else {
				wishlistIds = wishlistIds.includes(productId)
					? wishlistIds.filter((id) => id !== productId)
					: [...wishlistIds, productId];
				writeGuestIds(wishlistIds);
			}
			updateWishlistUI();
			if (document.querySelector('[data-wishlist-page]')) {
				if (config.isLoggedIn && !wishlistIds.includes(productId)) {
					button.closest('.product-card')?.remove();
					const empty = document.querySelector('[data-wishlist-empty]');
					if (empty) empty.hidden = Boolean(wishlistIds.length);
				} else if (!config.isLoggedIn) {
					await refreshGuestGrid();
				}
			}
		} catch (error) {
			window.alert(error.message);
		} finally {
			button.disabled = false;
		}
	});

	updateWishlistUI();
	refreshGuestGrid();

	const dialog = document.querySelector('#product-search-dialog');
	const openButton = document.querySelector('[data-search-open]');
	const closeButton = dialog?.querySelector('[data-search-close]');
	const input = dialog?.querySelector('[data-product-search]');
	const results = dialog?.querySelector('[data-search-results]');
	const status = dialog?.querySelector('[data-search-status]');
	let timer;
	let controller;

	const closeSearch = () => {
		dialog.close();
		openButton?.setAttribute('aria-expanded', 'false');
		openButton?.focus();
	};

	openButton?.addEventListener('click', () => {
		dialog.showModal();
		openButton.setAttribute('aria-expanded', 'true');
		window.setTimeout(() => input.focus(), 0);
	});
	closeButton?.addEventListener('click', closeSearch);
	dialog?.addEventListener('click', (event) => {
		if (event.target === dialog) closeSearch();
	});

	input?.addEventListener('input', () => {
		window.clearTimeout(timer);
		controller?.abort();
		const query = input.value.trim();
		if (query.length < 2) {
			results.innerHTML = '';
			status.textContent = query ? 'Escribe al menos 2 caracteres.' : '';
			return;
		}
		status.textContent = 'Buscando…';
		timer = window.setTimeout(async () => {
			controller = new AbortController();
			try {
				const data = await post('tienda_moda_product_search', { query });
				results.innerHTML = data.html;
				status.textContent = data.count ? data.count + (data.count === 1 ? ' resultado' : ' resultados') : 'No encontramos productos.';
			} catch (error) {
				if (error.name !== 'AbortError') status.textContent = config.errorMessage;
			}
		}, 250);
	});
})();
