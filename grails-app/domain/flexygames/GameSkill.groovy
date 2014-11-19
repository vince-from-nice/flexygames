package flexygames

class GameSkill implements Comparable<User> {
    
    String code
    GameType type
    
    static belongsTo = [type: GameType]

    static fetchMode = [type: 'eager']
    
    static constraints = {
        type(nullable: false)
        code (blank: false)
    }
    
    String toString() {
        return "$type's $code"
    }
    
    public int compareTo (Object o) {
        if (o instanceof GameSkill) {
            return toString().compareTo(o.toString())
        }
        else return -1
    }
}
