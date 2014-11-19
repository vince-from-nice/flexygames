package flexygames

class FlexyTagLib {
	
	static namespace = "flexy"
	
	static returnObjectForTags = ['humanDate', 'humanTimeDiff']
	
	/**
	* Print a date in a human way.
	*
	* @attr date REQUIRED a date
	* @attr includeSeconds print seconds as well
	*/
	def humanDate = { attrs, body ->
		def now = System.currentTimeMillis()
		
		def date = 0
		if(attrs.date) date = attrs.date
		
		def includeSeconds = false
		if(includeSeconds) includeSeconds = attrs.includeSeconds
	
		def distance_in_mins = (int)Math.round(Math.abs(date - now)/60000.0)
		def distance_in_seconds = (int)Math.round(Math.abs(date/1000 - now/1000))
		
		String prefix = message(code:'date.past.prefix')
		if (now < date) {
			prefix = message(code:'date.futur.prefix')
		}
		
		String value = message(code:'date.unknown')
		switch (distance_in_mins) {
			case 0..1:
				if(distance_in_mins == 0) {
					value =  message(code:'date.lessThan1Minute')
				} else {
					if (includeSeconds == false) {
						value =  "${distance_in_mins} " + message(code:'minute'); break;
					}
				}
				switch (distance_in_seconds) {
					case 0..4: value =  message(code:'date.lessThanXSeconds', args: [5]); break
					case 5..9: value =  message(code:'date.lessThanXSeconds', args: [10]); break
					case 10..19: value =  message(code:'date.lessThanXSeconds', args: [20]); break
					case 20..29: value =  message(code:'date.lessThanXSeconds', args: [30]); break
					case 30..39: value =  message(code:'date.lessThanXSeconds', args: [40]); break
					case 40..49: value =  message(code:'date.lessThanXSeconds', args: [50]); break
					case 50..59: value =  message(code:'date.lessThan1Minute'); break
					default: value =  "1 " + message(code:'minute')
				}
				break
			case 2..44: value =  "${distance_in_mins} " + message(code:'minutes'); break
			case 45..89: value =  message(code:'date.aroundA') + message(code:'hour')
			case 90..1439: value =  "environ ${Math.round(distance_in_mins / 60.0)} " + message(code:'hours'); break
			case 1440..2879: value =  message(code:'date.aroundA') + message(code:'day'); break
			case 2880..43199: value =  "${Math.round(distance_in_mins / 1440)} " + message(code:'days'); break
			case 43200..86399: value =  message(code:'date.aroundA') + message(code:'month'); break
			case 86400..525599: value =  "${Math.round(distance_in_mins / 43200)} " + message(code:'months'); break
			case 525600..1051199: value =  message(code:'date.aroundA') + message(code:'year'); break
			default: value =  "plus de ${Math.round(distance_in_mins / 525600)} " + message(code:'years')
		}
		
		String suffix = message(code:'date.past.suffix')
		if (now < date) {
			suffix = message(code:'date.futur.suffix')
		}
		
		return prefix + '' + value + '' + suffix
	}
}
