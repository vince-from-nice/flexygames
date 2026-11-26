<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/common/layout" />
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/ckeditor5@49.1.0/dist/browser/ckeditor5.css" />
	<script src="https://cdn.jsdelivr.net/npm/ckeditor5@49.1.0/dist/browser/ckeditor5.umd.js"></script>
</head>
<body>
	<div class="card form-card form-wide">
		<h1><g:message code="management.blogEntry.title" /> <g:link controller="teams" action="show" id="${team.id}">${team}</g:link></h1>
		<g:if test="${flash.message}">
			<div class="message">${flash.message}</div>
		</g:if>
		<g:form controller="manager" method="post">
			<g:hiddenField name="id" value="${blogEntry?.id}" />
			<g:hiddenField name="teamId" value="${team.id}" />
			<div class="field">
				<label for="title"><g:message code="title" /></label>
				<g:textField name="title" value="${blogEntry?.title}" />
			</div>
			<div class="field">
				<textarea id="body" name="body" rows="20">${blogEntry?.body?.encodeAsHTML()}</textarea>
			</div>
			<script>
				const { ClassicEditor, Essentials, Paragraph, Heading, Bold, Italic, Underline, Link, AutoLink, List,
					BlockQuote, Alignment, Image, ImageInsertViaUrl, AutoImage, Table, TableToolbar, GeneralHtmlSupport } = CKEDITOR;
				ClassicEditor.create(document.querySelector('#body'), {
					licenseKey: 'GPL',
					plugins: [Essentials, Paragraph, Heading, Bold, Italic, Underline, Link, AutoLink, List, BlockQuote,
						Alignment, Image, ImageInsertViaUrl, AutoImage, Table, TableToolbar, GeneralHtmlSupport],
					toolbar: ['undo', 'redo', '|', 'heading', '|', 'bold', 'italic', 'underline', '|', 'link', 'insertImage',
						'insertTable', 'blockQuote', '|', 'bulletedList', 'numberedList', 'alignment'],
					// Keeps any markup of existing blog entries.
					htmlSupport: { allow: [{ name: /.*/, attributes: true, classes: true, styles: true }] }
				});
			</script>
			<label class="check-row"><g:checkBox name="sticky" value="${blogEntry?.sticky}" /> <g:message code="management.blogEntry.sticky" /></label>
			<g:if test="${blogEntry}">
				<div class="form-actions">
					<g:actionSubmit class="create" action="saveBlogEntry" value="${message(code:'update')}" />
				</div>
			</g:if>
			<g:else>
				<label class="check-row"><g:checkBox name="mailAllMembers" checked="false" /> <g:message code="management.blogEntry.mailAllMembers" /></label>
				<div class="form-actions">
					<g:actionSubmit class="create" action="saveBlogEntry" value="${message(code:'create')}" />
				</div>
			</g:else>
		</g:form>
	</div>
</body>
</html>
