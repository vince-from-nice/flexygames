package flexygames

class Playground implements Comparable<Playground> {

    String name
    String description
    String street
    String zip
    String city
    String country
	Float latitude
	Float longitude
	String phoneNumber
    String websiteUrl
    String gmapsUrl
	String flexymapUrl
	String forecastType
	String forecastToken
	
	private static final String FORECAST_TOKEN_VAR = "_DAYS_"
    
	///////////////////////////////////////////////////////////////////////////
	// Grails stuff
	///////////////////////////////////////////////////////////////////////////
	
	static hasMany = [sessionGroups: SessionGroup, sessions: Session]
		
    static constraints = {
        name(blank: false)
        description(nullable: true, blank: true, maxSize:100)
        street(nullable: true, blank: true)
        zip(nullable: true, blank: true)
        city(nullable: true, blank: true)
        country(nullable: true, blank: true)
		latitude(nullable: true)
		longitude(nullable: true)
		phoneNumber(nullable: true, blank: true)
        websiteUrl(nullable: true, url:true)
        gmapsUrl(nullable: true, url:true)
		flexymapUrl(nullable: true, url:true)
		forecastType(nullable: true)
		forecastToken(nullable: true)
    }
	
	///////////////////////////////////////////////////////////////////////////
	// Business methods
	///////////////////////////////////////////////////////////////////////////
	
	public String getPostalAddress() {
		return (street?street+", ":"") + (zip?zip+", ":"") + (city?city+", ":"") + (country?country:"France")
	}
	
	public String computeForecastToken(Date sessionDate) {
		if (forecastToken == null || forecastToken.indexOf(FORECAST_TOKEN_VAR) < 0) return null
		def now = new Date()
		if (sessionDate < now) return null
		def sessionCal = new GregorianCalendar()
		sessionCal.setTime(sessionDate)
		def diff = sessionCal.get(Calendar.DAY_OF_YEAR) - new GregorianCalendar().get(Calendar.DAY_OF_YEAR)
		if (forecastType.equals("MeteoCity1")) {
			if (diff < 1) return forecastToken.replace(FORECAST_TOKEN_VAR, 'x')
			if (diff < 2) return forecastToken.replace(FORECAST_TOKEN_VAR, 'y')
			if (diff < 3) return forecastToken.replace(FORECAST_TOKEN_VAR, 'z')
			//if (diff < 4) return forecastToken.replace(TOKEN, '0')
			//if (diff < 5) return forecastToken.replace(TOKEN, '1')
		}
		if (forecastType.equals("MeteoCity2")) {
			if (diff < 1) return forecastToken.replace(FORECAST_TOKEN_VAR, 'MX')
			if (diff < 2) return forecastToken.replace(FORECAST_TOKEN_VAR, 'Mn')
			if (diff < 3) return forecastToken.replace(FORECAST_TOKEN_VAR, 'M3')
			//if (diff < 4) return forecastToken.replace(FORECAST_TOKEN_VAR, 'NH')
		}
		return null 
	}
	    
	///////////////////////////////////////////////////////////////////////////
	// System methods
	///////////////////////////////////////////////////////////////////////////
	
    public String toString() {
        return name
    }
	
	int compareTo(Object o) {
		if (o instanceof Playground && o != null) {
			return this.getName().compareTo(o.getName())
		} else {
			return -1
		}
	}
}
