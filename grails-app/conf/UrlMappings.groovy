class UrlMappings {

	static mappings = {
        
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		// commented in order to use a static index.html
		//"/"(controller:"site", action:"home")
        
		"/"(controller:"site", action:"home")
		
        "/home"(controller:"site", action:"home")
        
        "/about"(controller:"site", action:"about")

		"500"(view:'/error')
		
		// turman : move all administration controller to the "admin" subdirectory
		
//		"/admin"(controller:"admin/admin")
//		
//		"/comment"(controller:"admin/comment")
//		
//		"/gameAction"(controller:"admin/gameAction")
//		
//		"/gameSkill"(controller:"admin/gameSkill")
//		
//		"/gameType"(controller:"admin/gameType")
//		
//		"/membership"(controller:"admin/membership")
//		
//		"/participation"(controller:"admin/participation")
//		
//		"/playground"(controller:"admin/playground")
//		
//		"/reminder"(controller:"admin/reminder")
//		
//		"/role"(controller:"admin/role")
//		
//		"/session"(controller:"admin/session")
//		
//		"/sessionGroup"(controller:"admin/sessionGroup")
//		
//		"/sessionRound"(controller:"admin/sessionRound")
//		
//		"/subscription"(controller:"admin/subscription")
//		
//		"/team"(controller:"admin/team")
//		
//		"/user"(controller:"admin/user")
//		
//		"/vote"(controller:"admin/vote")
	}
}
