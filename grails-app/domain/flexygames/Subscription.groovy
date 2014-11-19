package flexygames

class Subscription {
	
	Membership membership
	Date date
	BigDecimal amount
	Currency currency
	
	static belongsTo = [membership: Membership]

    static constraints = {
		membership(nullable: false)
		date(nullable: false)
		amount(nullable: false)
		currency(nullable: false)
    }
	
	public int compareTo (Object o) {
		if (o instanceof Subscription) {
			if (membership.equals(o.membership)) {
				return date.compareTo(o.date) 
			} else {
				return -1
			} 
		}
		else return -1
	}
}
