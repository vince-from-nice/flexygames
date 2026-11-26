<section class="card chart-card">
	<h2>${title}</h2>
	<g:if test="${items}">
		<g:set var="maxValue" value="${Math.max(items*.value.max() as int, 1)}" />
		<ol class="bar-chart">
			<g:each in="${items}" var="item">
				<li>
					<span class="bar-label"><g:link controller="${item.link.controller}" action="${item.link.action}" id="${item.link.id}" params="${item.link.params}" title="${item.label}">${item.label}</g:link></span>
					<span class="bar-track"><span class="bar-fill" style="width: ${Math.round(item.value * 100 / maxValue)}%"></span></span>
					<span class="bar-value">${item.value}</span>
				</li>
			</g:each>
		</ol>
	</g:if>
	<g:else>
		<p class="muted"><g:message code="statistics.noData" /></p>
	</g:else>
</section>
