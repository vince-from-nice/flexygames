/* Remove UFile dependencies from User and Team domain class.
 In fact the Grails File Uploader is not designed at all for the needs of FlexyGames:
 - no need to keep updated counter
 - need to NOT have SQL queries on each image display
*/

import groovy.sql.Sql

import java.nio.file.Files
import java.nio.file.Paths
import java.nio.file.StandardCopyOption

def newBasePathForUserAvatars = "/home/asas/webapps/flexygames/images/user/"
def newBasePathForTeamLogos = "/home/asas/webapps/flexygames/images/team/"
//    def newBasePathForUserAvatars = "E:\\Repositories\\flexygames\\web-app\\images\\user\\"
//    def newBasePathForTeamLogos = "E:\\Repositories\\flexygames\\\\web-app\\images\\team\\"

sql = Sql.newInstance('jdbc:postgresql://localhost/asas_flexygames', 'postgres', '', 'org.postgresql.Driver')

// Update avatar path on all users
sql.eachRow('select * from uzer') { user ->
    println "User#" + user.id + " (" + user.username + ") has UFile#" + user.avatar_id
    def newName
    if (user.avatar_id != null) {
        def ufile = sql.firstRow("select * from ufile where id = ${user.avatar_id}")
        String path = ufile.path
        def ext = path.substring(path.lastIndexOf('.') + 1).toLowerCase()
        newName = 'user-' + user.id + '.' + ext
        def newPath = newBasePathForUserAvatars + newName
        println "\t=> copy ${ufile.path} to ${newPath}}"
        Files.copy(Paths.get(path), Paths.get(newPath), StandardCopyOption.REPLACE_EXISTING)
    } else {
        newName = 'no-avatar.jpg'
        println "\t=> set the default avatar"
    }
    sql.execute("update uzer set avatar_name = ${newName} where uzer.id = ${user.id}")
}

// Update team logo on all teams
sql.eachRow('select * from team') { team ->
    println "Team#${team.id} has UFile#${team.logo_id}"
    def newName
    if (team.logo_id != null) {
        def ufile = sql.firstRow("select * from ufile where id = ${team.logo_id}")
        String path = ufile.path
        def ext = path.substring(path.lastIndexOf('.') + 1).toLowerCase()
        newName = 'team-' + team.id + '.' + ext
        def newPath = newBasePathForTeamLogos + newName
        println "\t=> copy ${ufile.path} to ${newPath}}"
        Files.copy(Paths.get(path), Paths.get(newPath), StandardCopyOption.REPLACE_EXISTING)
    } else {
        newName = 'no-logo.png'
        println "\t=> set the default logo"
    }
    sql.execute("update team set logo_name = ${newName} where team.id = ${team.id}")
}


