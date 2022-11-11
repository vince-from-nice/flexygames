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
	String windySpotId
	
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
		windySpotId(nullable: true)
    }

	static mapping = {
		sessions lazy: true, batchSize: 50
		sessionGroups lazy: true, batchSize: 50
	}

	// def forecastService
	
	///////////////////////////////////////////////////////////////////////////
	// Business methods
	///////////////////////////////////////////////////////////////////////////
	
	public String getPostalAddress() {
		return (street?street+", ":"") + (zip?zip+", ":"") + (city?city+", ":"") + (country?country:"France")
	}

	public int getSessionsNbr() {
		return sessions.size()
	}
	
	/* Obsolete methods (they ware useful for the Meteocity service) */
	
	/*
	public String computeForecastToken(Date sessionDate) {
		return forecastService.computeForecastToken(sessionDate, this)
	}

	public String generateForecastScript(String token) {
		return forecastService.generateForecastScript(token)
	}
	*/
	    
	///////////////////////////////////////////////////////////////////////////
	// System methods
	///////////////////////////////////////////////////////////////////////////
	
    public String toString() {
        return name
    }
	
	int compareTo(Playground o) {
		if (o instanceof Playground && o != null) {
			return this.getName().compareTo(o.getName())
		} else {
			return -1
		}
	}
}
