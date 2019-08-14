package flexygames.admin

import flexygames.BlogComment
import grails.gorm.services.Service

@Service(BlogComment)
interface BlogCommentService {

    BlogComment get(Serializable id)

    List<BlogComment> list(Map args)

    Long count()

    void delete(Serializable id)

    BlogComment save(BlogComment blogComment)

}