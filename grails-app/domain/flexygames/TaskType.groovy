package flexygames

class TaskType {

    String code

    static constraints = {
        code unique: true
    }
}
