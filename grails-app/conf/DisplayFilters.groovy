class DisplayFilters {

    def displayService

    def filters = {
        all(controller:'*', action:'*') {
            before = {
                // If user forces flavour via the "flavour" request parameter, store it into the session
                def flavour = request.getParameter('flavour')
                if (flavour != null) {
                    request.session.flavour = flavour
                }
            }

            after = { Map model ->
                // Ignore calendar request which failed on some users
                // (Impossible de créer une session après que la réponse ait été envoyée)
                if (controllerName == 'player' && actionName == 'cal') {
                    return
                }
                // Set the display attribute (useful views)
                if (displayService.isMobileDevice(request)) {
                    request.display = 'mobile'
                } else {
                    request.display = 'desktop'
                }
                //println "Display is set to " + request.display
            }

            afterView = { Exception e ->

            }
        }
    }
}
