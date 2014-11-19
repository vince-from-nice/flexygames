package flexygames

class GameType {

    String name
    String description
    
    static hasMany = [skills: GameSkill]
    
    static constraints = {
        name(blank: true)
        description(nullable: true, blank: true, maxSize:100)
        skills(nullable: true)
    }
    
    public String toString() {
        return name
    }
}
