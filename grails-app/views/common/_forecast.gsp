<div style='font-size: small'>
	<g:if test="${weatherData}">
		<div style='font-weight: bold'>${weatherData.location}:</div>
		<g:if test="${weatherData.current}">
			<img src='${weatherData.current.image}' /><br>
			${weatherData.current.temperature.value} °${weatherData.current.temperature.unit}, ${weatherData.current.condition.text}
			<br>
			<g:message code="wind" />: ${weatherData.current.wind.speed.value} ${weatherData.current.wind.speed.unit} (${weatherData.current.wind.direction}°)
		</g:if>
		<g:else>
			<g:if test="${weatherData.forecast}">
				<table>
					<tr style="margin: 0px; padding: 0px; border: solid #dfdfdf 1px; text-align: center;">
						<g:each var="forecast" in="${weatherData.forecast}">
							<td style="margin: 0px; padding: 0px; border: solid green 0px; text-align: center;">
								${forecast.day}:<br>
								<img src='${forecast.image}' /><br>
								min:${forecast.low}° max:${forecast.high}°<br>
							</td>
						</g:each>
					<tr>
				</table>
			</g:if>
			<g:else>
				<g:message code="informationNotAvailable" />
			</g:else>
		</g:else>
	</g:if>
	<g:else>
		<g:message code="informationNotAvailable" />
	</g:else>
</div>