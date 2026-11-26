package flexygames

class Role implements Comparable<Role> {
    String name

    static hasMany = [ users: User, permissions: String ]
    static belongsTo = User

    static constraints = {
        name(nullable: false, blank: false, unique: true)
    }
    
    String toString() {
        return name
    }
	
	public int compareTo (Role o) {
		return name <=> o?.name
	}
}
