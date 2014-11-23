/**
 * Generated by the Shiro plugin. This filters class protects all URLs
 * via access control by convention.
 */
class ShiroSecurityFilters {
    def filters = {
        all(uri: "/**") {
            before = {
                
                // Ignore direct views (e.g. the default main index page).
                if (!controllerName) return true

                // turman : no access control for some controllers.
                if (controllerName in ['player', 'playgrounds', 'site', 'stats', 'teams', 'assets']) return true

                // turman : no access control for some controllers AND actions.
                if ( 
                    (controllerName == 'sessions' && actionName == 'list') ||
                    (controllerName == 'sessions' && actionName == 'show') ||
					(controllerName == 'fileUploader' && actionName == 'show')
                ) return true
                
				// turman: restrict access to team manager for some controllers
				// TOO DIFFICULT because access control are too much specific to action (so it's done in each action)
				//if (controllerName in ['manager']) { }
				
				// turman: admin controllers are restricted to users with the "Administrator" role
				// USELESS because Administrator role has already all permissions !
				//if (! controllerName in ['admin', 'stats', 'player', 'teams', 'playgrounds', 'sessions', 'fileUploader']) { }
			
                // Access control by convention.
                accessControl()
            }
        }
    }
}