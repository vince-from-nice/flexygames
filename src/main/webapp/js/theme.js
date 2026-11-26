/*
 * Light and dark theme. Loaded at the top of <head>, before the stylesheets, so the page never shows the wrong theme.
 *
 * The visitor's choice is "auto" (follow the device), "light" or "dark", kept in localStorage.
 * The <html> element gets data-theme="light|dark" for the stylesheet and data-theme-choice for the button icon.
 */
(function () {
	var STORAGE_KEY = 'flexygames-theme';
	var CHOICES = ['auto', 'light', 'dark'];
	var root = document.documentElement;
	var systemDark = window.matchMedia ? window.matchMedia('(prefers-color-scheme: dark)') : null;

	function readChoice() {
		try {
			var stored = window.localStorage.getItem(STORAGE_KEY);
			return CHOICES.indexOf(stored) > 0 ? stored : 'auto';
		} catch (e) {
			return 'auto';
		}
	}

	function saveChoice(choice) {
		try {
			if (choice === 'auto') {
				window.localStorage.removeItem(STORAGE_KEY);
			} else {
				window.localStorage.setItem(STORAGE_KEY, choice);
			}
		} catch (e) {
			// Storage can be blocked: the choice then lasts until the next page.
		}
	}

	function labelButton(choice) {
		var button = document.getElementById('themeToggle');
		if (button) {
			var label = button.getAttribute('data-label-' + choice);
			button.setAttribute('aria-label', label);
			button.setAttribute('title', label);
		}
	}

	function apply(choice) {
		var dark = choice === 'dark' || (choice === 'auto' && systemDark !== null && systemDark.matches);
		root.setAttribute('data-theme', dark ? 'dark' : 'light');
		root.setAttribute('data-theme-choice', choice);
		labelButton(choice);
	}

	apply(readChoice());

	if (systemDark !== null && systemDark.addEventListener) {
		systemDark.addEventListener('change', function () {
			if (readChoice() === 'auto') {
				apply('auto');
			}
		});
	}

	document.addEventListener('DOMContentLoaded', function () {
		var button = document.getElementById('themeToggle');
		if (!button) {
			return;
		}
		labelButton(root.getAttribute('data-theme-choice'));
		button.addEventListener('click', function () {
			var current = root.getAttribute('data-theme-choice');
			var next = CHOICES[(CHOICES.indexOf(current) + 1) % CHOICES.length];
			saveChoice(next);
			apply(next);
		});
	});
})();
