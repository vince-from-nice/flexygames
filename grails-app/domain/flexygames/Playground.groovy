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

	def forecastService
	
	///////////////////////////////////////////////////////////////////////////
	// Business methods
	///////////////////////////////////////////////////////////////////////////
	
	public String getPostalAddress() {
		return (street?street+", ":"") + (zip?zip+", ":"") + (city?city+", ":"") + (country?country:"France")
	}
	
	public String computeForecastToken(Date sessionDate) {
		return forecastService.computeForecastToken(sessionDate, this)
	}

	public String generateForecastScript(String token) {
		return forecastService.generateForecastScript(token)
	}

	    
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
