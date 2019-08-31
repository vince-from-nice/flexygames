package flexygames

import grails.gorm.transactions.Transactional

/**
 * Inspired from the controller of the Grails File Uploader plugin.
 */
@Transactional
class FileUploadController {

    def defaultAction = "process"

    def process = {

        def uploadType = params.uploadType
        def config = grailsApplication.config.flexygames.fileUpload[params.uploadType]
        def file = request.getFile("file")

        /**************************
         Check if file exists
         **************************/
        if (file.size == 0) {
            def msg = "No file content"
            log.debug msg
            flash.message = msg
            return redirect(controller: params.errorController, action: params.errorAction, id: params.id)
        }

        /***********************
         Check extensions
         ************************/
        def fileExtension = file.originalFilename.substring(file.originalFilename.lastIndexOf('.') + 1).toLowerCase()
        if (!config.allowedExtensions[0].equals("*")) {
            if (!config.allowedExtensions.contains(fileExtension)) {
                def msg = "Invalid file extension"
                log.debug msg
                flash.message = msg
                return redirect(controller: params.errorController, action: params.errorAction, id: params.id)
            }
        }

        /*********************
         Check file size
         **********************/
        if (config.maxSize) { //if maxSize config exists
            def maxSizeInKb = ((int) (config.maxSize/1024))
            if (file.size > config.maxSize) { //if filesize is bigger than allowed
                def mesg = "The uploaded file is bigger than ${maxSizeInKb} kilobytes"
                log.debug mesg
                flash.message = mesg
                return redirect(controller: params.errorController, action: params.errorAction, id: params.id)
            }
        }

        /**************************************************************
         Compute file path/name and associated it to the related entity
         **************************************************************/
        def basePath = config.path
        if (!basePath.endsWith(File.separator))
            basePath = basePath + File.separator
        def fileName
        if ("userAvatar" == uploadType) {
            def user = User.get(params.id)
            if (user == null) {
                flash.message = "Unable to find user with id=" + params.id
                return redirect(controller: params.errorController, action: params.errorAction, id: params.id)
            }
            fileName =  "user-" + user.id + "." + fileExtension
            user.avatarName = fileName
            if (!user.save()) {
                flash.message = "Unable to save user with id=" + params.id
                return redirect(controller: params.errorController, action: params.errorAction, id: params.id)
            }
        } else if ("teamLogo" == uploadType) {
            def team = Team.get(params.id)
            if (team == null) {
                flash.message = "Unable to find team with id=" + params.id
                return redirect(controller: params.errorController, action: params.errorAction, id: params.id)
            }
            fileName =  "team-" + team.id + "." + fileExtension
            team.logoName = fileName
            if (!team.save()) {
                flash.message = "Unable to save team with id=" + params.id
                return redirect(controller: params.errorController, action: params.errorAction, id: params.id)
            }
        }

        /*******************************
         Copy the file to the good place
         *******************************/
        def filePath = basePath + fileName
        log.debug "Receiving an uploaded file of ${file.size} bytes, moving it to ${filePath}"
        File f = new File(filePath)
        file.transferTo(f)

        redirect controller: params.successController, action: params.successAction, params:[id: params.id]
    }

}
