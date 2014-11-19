package flexygames

import org.springframework.transaction.annotation.Transactional;

@Transactional
class UserService {

    def update(userId, params) {
		def user = User.get(userId)
		user.properties = params
		user.save(flush: true)
		println "Ok user has been updated"
    }
}
