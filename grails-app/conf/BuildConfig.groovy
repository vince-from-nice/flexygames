// turman : hmm depuis Grails 2.3 il vaut mieux passer Ã  Maven / Aether au lieu d'Ivy ?
// see http://grails.org/doc/2.3.x/guide/upgradingFromPreviousVersionsOfGrails.html
//grails.project.dependency.resolver = "maven"

grails.servlet.version = "2.5" // Change depending on target container compliance (2.5 or 3.0)
grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
grails.project.target.level = 1.6
grails.project.source.level = 1.6
//grails.project.war.file = "target/${appName}-${appVersion}.war"

grails.project.dependency.resolution = {
    // inherit Grails' default dependencies
    inherits("global") {
        // uncomment to disable ehcache
        // excludes 'ehcache'
    }
    log "error" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    checksums true // Whether to verify checksums on resolve

    repositories {
        inherits true // Whether to inherit repository definitions from plugins
        grailsPlugins()
        grailsHome()
        grailsCentral()
        mavenCentral()
		
		// Vinz : https://groups.google.com/forum/#!topic/grails-dev-discuss/LI0coUwaFgk
		//mavenRepo "http://repo.grails.org/grails/plugins/"

        // uncomment these to enable remote dependency resolution from public Maven repositories
        //mavenCentral()
        //mavenLocal()
        //mavenRepo "http://snapshots.repository.codehaus.org"
        //mavenRepo "http://repository.codehaus.org"
        //mavenRepo "http://download.java.net/maven/2/"
        //mavenRepo "http://repository.jboss.com/maven2/"
    }
    dependencies {
        // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes eg.

        // runtime 'mysql:mysql-connector-java:5.1.16'
    }

    plugins {
		// plugins for the build system only
		build ":tomcat:7.0.55"

		// plugins for the compile step
		compile ":scaffolding:2.1.2"
		compile ':cache:1.1.8'
		compile ":asset-pipeline:1.9.9"

		// plugins needed at runtime but not for compilation
		runtime ":hibernate4:4.3.6.1" // or ":hibernate:3.6.10.18"
		runtime ":database-migration:1.4.0"
		runtime ":jquery:1.11.1"
		
		// turman : putain depuis grails 2.3 on ne peut plus utiliser le plugin manager et il faut rajouter toutes les dépendances à  la main ???
		compile ":mail:1.0.7"
		compile (":shiro:1.2.1") {
            excludes([name: 'quartz', group: 'org.opensymphony.quartz'])
		}
		compile ":quartz:1.0.2"
		compile ":file-uploader:1.2.1"
		compile ":ic-alendar:0.4.1"
    }
}
