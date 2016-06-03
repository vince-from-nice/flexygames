package flexygames

class TaskType implements Comparable<TaskType> {

    String code

    static constraints = {
        code unique: true
    }

    @Override
    public String toString() {
        return code;
    }

    @Override
    int compareTo(TaskType o) {
        return code.compareTo(o.code)
    }

}
