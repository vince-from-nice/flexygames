<%@ page import="java.time.ZoneId" %>
<%@ page import="java.text.SimpleDateFormat" %>
<g:if test="${sessionInstance.date > new Date() && sessionInstance.date < new Date() + 7}">
<div
        data-windywidget="windy-weather"
        data-thememode="light"
        data-appid="b64b8607564eb29ec8ebf342e1575dcf"
        data-spotid="${sessionInstance.playground.windySpotId}"
        data-dayofweek="${sessionInstance.date.toInstant().atZone(java.time.ZoneId.systemDefault()).toLocalDate().getDayOfWeek().value}"
        data-starthour="<g:formatDate format="H" date="${sessionInstance.date}"/>"
        data-windunit="kmh"
        data-tempunit="C"
        data-mode="compact">
</div>
<script async="true" data-cfasync="false" type="text/javascript" src="https://windy.app/widgets-code/forecast/windy_weather_async.js?v13"></script>
</g:if>
<g:else>
    <g:message code="informationNotAvailable" />
</g:else>
