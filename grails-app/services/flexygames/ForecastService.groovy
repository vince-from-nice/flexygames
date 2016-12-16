package flexygames

import grails.transaction.Transactional
import grails.plugins.rest.client.RestBuilder
import org.codehaus.groovy.grails.web.json.JSONObject
import groovy.json.JsonBuilder
import groovy.json.JsonSlurper

@Transactional
class ForecastService {

	private static final int MAX_DISPLAYED_DAYS = 4 // Number of days displayed

	def getWeatherData(Session session) {
		// First have a look on the session's date
		def now = new Date()
        def calendar = new GregorianCalendar()
        calendar.setTime(session.date)
        int daysBeforeSession = calendar.get(Calendar.DAY_OF_YEAR) - new GregorianCalendar().get(Calendar.DAY_OF_YEAR)
		
		// If session's date in too much in the future or in the past, return nothing
		if (daysBeforeSession < 0 || daysBeforeSession >= MAX_DISPLAYED_DAYS) {
			return null
		}
		
		// Fetch data from Yahoo Weather API
		long t1 = System.currentTimeMillis();
		def rest = new RestBuilder(connectTimeout:2000, readTimeout:2000)
		def query = "https://query.yahooapis.com/v1/public/yql?q=select * from weather.forecast where woeid in (select woeid from geo.places(1) where text='" + session.playground.city + "') and u='c'&format=json"
		def resp = null
		try {
			resp = rest.get(query)
		} catch (Exception e) {
			System.out.println("Unable to fetch weather data: " + e.getMessage())
			return null
		}
		//println "resp.json: " + resp.json
		def results = resp?.json?.query?.results
		if (results == null || results instanceof org.codehaus.groovy.grails.web.json.JSONObject.Null || !resp.json.query.results.has('channel')) {
			return null
		}
		def channel = resp.json.query.results.channel
		long t2 = System.currentTimeMillis();
		System.out.println("Weather data has been fetched from Yahoo in " + (t2 -t1) + " ms")
		//System.out.println("**************************************************************")
		//System.out.println("Fetched data as JSONObject:\n" + channel)
		
		// Init data structure
		JsonBuilder builder = new JsonBuilder()
		
		// If session's date is today, fill the "current" part of the structure only
		if (daysBeforeSession < 1) {
			builder {
				location channel.location.city
				date channel.item.pubDate
				current{
					condition {
						code channel.item.condition.code
						text channel.item.condition.text
					}
					image "http://l.yimg.com/a/i/us/we/52/" + channel.item.condition.code + ".gif"
					temperature {
						value channel.item.condition.temp
						unit channel.units.temperature
					}
					wind {
						speed {
							value channel.wind.speed
							unit channel.units.speed
						}
						direction channel.wind.direction
					}
				}
			}
		}
		// If session's date is between +1 and +10, fill the "forecast" part of the structure only
		else {
			def displayedDays = daysBeforeSession + 1
			if (displayedDays > MAX_DISPLAYED_DAYS) displayedDays = MAX_DISPLAYED_DAYS
			//System.out.println("daysBeforeSession=" + daysBeforeSession + " displayedDays=" + displayedDays)
			def filteredForecasts = channel.item.forecast.take(displayedDays) //.tail()
			//System.out.println("Filtered forecasts:\n" + filteredForecasts)
			builder {
				location channel.location.city
				date channel.item.pubDate
				forecast filteredForecasts.collect {
					[
						day: it.day,
						date: it.date,
						low: it.low,
						high: it.high,
						text: it.text,
						image: "http://l.yimg.com/a/i/us/we/52/" + it.code + ".gif"
					]
				}
			}	
		}
		
		def json = builder.toString()
		//System.out.println("Weather data in JSON:\n" + json)
		def jsonSlurper = new JsonSlurper()
		def result = jsonSlurper.parseText(json)
		return result
	}

	/* Obsolete methods (they ware useful for the Meteocity service) */
	
	/*
    private static final String FORECAST_TOKEN_VAR = "_DAYS_"
    private static final String METEOCITY_BASE_URL = "http://widget.meteocity.com/js/"

    def computeForecastToken(Date sessionDate, Playground playground) {
        def forecastToken = playground.forecastToken
        if (forecastToken == null || forecastToken.indexOf(FORECAST_TOKEN_VAR) < 0) return null
        def now = new Date()
        if (sessionDate < now) return null
        def sessionCal = new GregorianCalendar()
        sessionCal.setTime(sessionDate)
        def daysBeforeSession = sessionCal.get(Calendar.DAY_OF_YEAR) - new GregorianCalendar().get(Calendar.DAY_OF_YEAR)
        if (playground.forecastType.equals("MeteoCity1")) {
            if (daysBeforeSession < 1) return forecastToken.replace(FORECAST_TOKEN_VAR, 'x')
            if (daysBeforeSession < 2) return forecastToken.replace(FORECAST_TOKEN_VAR, 'y')
            if (daysBeforeSession < 3) return forecastToken.replace(FORECAST_TOKEN_VAR, 'z')
            //if (daysBeforeSession < 4) return forecastToken.replace(TOKEN, '0')
            //if (daysBeforeSession < 5) return forecastToken.replace(TOKEN, '1')
        }
        if (playground.forecastType.equals("MeteoCity2")) {
            if (daysBeforeSession < 1) return forecastToken.replace(FORECAST_TOKEN_VAR, 'MX')
            if (daysBeforeSession < 2) return forecastToken.replace(FORECAST_TOKEN_VAR, 'Mn')
            if (daysBeforeSession < 3) return forecastToken.replace(FORECAST_TOKEN_VAR, 'M3')
            //if (daysBeforeSession < 4) return forecastToken.replace(FORECAST_TOKEN_VAR, 'NH')
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
	*/
}
