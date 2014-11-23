/**
 * The file-upload plugin is not very smart because it stores absolute pathes into DB. 
 * Need that script to convert them for the development environment.
 * 
 * TODO use pathes from the Grails config
 */
import groovy.sql.Sql
sql = Sql.newInstance( 'jdbc:postgresql://localhost/flexygames', 'postgres', '', 'org.postgresql.Driver' )
sql.eachRow( 'select * from ufile' ) {ufile ->
	// Logos
	def newPath = null
	def badPath = '/home/asas/upload/flexygames/logo/'
	def goodPath = 'E:\Workspace\GGTS\FlexyGames\upload\logo\'
	if (ufile.path.indexOf('') != -1) {
		newPath = ufile.path.replace(badPath, goodPath)
	}
	// Avatars
	badPath = '/home/asas/upload/flexygames/avatar/'
	goodPath = 'E:\Workspace\GGTS\FlexyGames\upload\avatar\'
	if (ufile.path.indexOf(badPath) != -1) {
		newPath = ufile.path.replace(badPath, goodPath)
	}
	// Common
	if (newPath) {
		println "Ufile $ufile.id : changing ${ufile.path} to $newPath"
		if (newPath.indexOf("/") != -1) {
			newPath = newPath.replace("/", "\\")
		}
		sql.execute("update ufile set path = $newPath where id = ${ufile.id}")
	}
}
