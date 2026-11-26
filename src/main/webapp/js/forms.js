/*
 * Form helpers for the generated admin forms (fields plugin markup).
 *
 * - A multiple select (roles of a user, users of a role, teams of a session group...) becomes a list of
 *   checkboxes. The select stays in the form, hidden, and the checkboxes set its options, so the submitted
 *   values do not change. Long lists get a filter field.
 * - A range input shows its current value next to it.
 */
(function () {
	var FILTER_FROM = 8;

	function checkboxList(select) {
		var list = document.createElement('div');
		list.className = 'check-list';

		var filter = null;
		if (select.options.length >= FILTER_FROM) {
			filter = document.createElement('input');
			filter.type = 'search';
			filter.className = 'check-list-filter';
			var label = document.documentElement.lang === 'fr' ? 'Filtrer' : 'Filter';
			filter.setAttribute('aria-label', label);
			filter.placeholder = label + '…';
			list.appendChild(filter);
		}

		var items = document.createElement('div');
		items.className = 'check-list-items';
		list.appendChild(items);

		Array.prototype.forEach.call(select.options, function (option) {
			if (option.value === '' || option.value === 'null') {
				return;
			}
			var label = document.createElement('label');
			var box = document.createElement('input');
			box.type = 'checkbox';
			box.checked = option.selected;
			box.addEventListener('change', function () {
				option.selected = box.checked;
			});
			label.appendChild(box);
			label.appendChild(document.createTextNode(' ' + option.text));
			items.appendChild(label);
		});

		if (filter) {
			filter.addEventListener('input', function () {
				var term = filter.value.trim().toLowerCase();
				Array.prototype.forEach.call(items.children, function (label) {
					label.hidden = term !== '' && label.textContent.toLowerCase().indexOf(term) < 0;
				});
			});
		}

		select.hidden = true;
		// A hidden required control blocks the submit without a message; the server still checks the constraint.
		select.required = false;
		select.parentNode.insertBefore(list, select.nextSibling);
	}

	function rangeValue(input) {
		var output = document.createElement('output');
		output.className = 'range-value';
		output.value = input.value;
		input.addEventListener('input', function () {
			output.value = input.value;
		});
		input.parentNode.insertBefore(output, input.nextSibling);
	}

	document.addEventListener('DOMContentLoaded', function () {
		Array.prototype.forEach.call(document.querySelectorAll('fieldset.form select[multiple]'), checkboxList);
		Array.prototype.forEach.call(document.querySelectorAll('fieldset.form input[type="range"]'), rangeValue);
	});
})();
