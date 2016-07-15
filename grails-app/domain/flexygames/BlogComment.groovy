package flexygames

class BlogComment implements Comparable<BlogComment> {
    
    Date date
    String text
    
    static belongsTo = [user: User, blogEntry: BlogEntry]
    
    static constraints = {
        user(nullable: false)
        blogEntry(nullable: false)
        date(nullable: false)
        text(blank:false, maxSize:10000)
    }

    @Override
    int compareTo(BlogComment o) {
        return - date.compareTo(o.date)
    }
}
