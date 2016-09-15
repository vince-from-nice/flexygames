package flexygames

import grails.transaction.Transactional

@Transactional
class ForecastService {

    private static final String FORECAST_TOKEN_VAR = "_DAYS_"
    private static final String METEOCITY_BASE_URL = "http://widget.meteocity.com/js/"

    def computeForecastToken(Date sessionDate, Playground playground) {
        def forecastToken = playground.forecastToken
        if (forecastToken == null || forecastToken.indexOf(FORECAST_TOKEN_VAR) < 0) return null
        def now = new Date()
        if (sessionDate < now) return null
        def sessionCal = new GregorianCalendar()
        sessionCal.setTime(sessionDate)
        def diff = sessionCal.get(Calendar.DAY_OF_YEAR) - new GregorianCalendar().get(Calendar.DAY_OF_YEAR)
        if (playground.forecastType.equals("MeteoCity1")) {
            if (diff < 1) return forecastToken.replace(FORECAST_TOKEN_VAR, 'x')
            if (diff < 2) return forecastToken.replace(FORECAST_TOKEN_VAR, 'y')
            if (diff < 3) return forecastToken.replace(FORECAST_TOKEN_VAR, 'z')
            //if (diff < 4) return forecastToken.replace(TOKEN, '0')
            //if (diff < 5) return forecastToken.replace(TOKEN, '1')
        }
        if (playground.forecastType.equals("MeteoCity2")) {
            if (diff < 1) return forecastToken.replace(FORECAST_TOKEN_VAR, 'MX')
            if (diff < 2) return forecastToken.replace(FORECAST_TOKEN_VAR, 'Mn')
            if (diff < 3) return forecastToken.replace(FORECAST_TOKEN_VAR, 'M3')
            //if (diff < 4) return forecastToken.replace(FORECAST_TOKEN_VAR, 'NH')
        }
        return null
    }

    // Meteocity provide its widgets via HTTP only and browsers don't like mixed content (HTTP with HTTPS)
    // So we have to fetch the JavaScript content from Meteocity.com in order to inject it directly into the GSP
    def generateForecastScript(String token) {
        def url = METEOCITY_BASE_URL + token + "-"
        def content = new URL(url).text
        return content
    }
}
