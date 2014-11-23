// locations to search for config files that get merged into the main config
// config files can either be Java properties files or ConfigSlurper scripts

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if (System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }


grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [ html: ['text/html','application/xhtml+xml'],
                      xml: ['text/xml', 'application/xml'],
                      text: 'text/plain',
                      js: 'text/javascript',
                      rss: 'application/rss+xml',
                      atom: 'application/atom+xml',
                      css: 'text/css',
                      csv: 'text/csv',
                      all: '*/*',
                      json: ['application/json','text/json'],
                      form: 'application/x-www-form-urlencoded',
                      multipartForm: 'multipart/form-data'
                    ]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// What URL patterns should be processed by the resources plugin
grails.resources.adhoc.patterns = ['/images/*', '/css/*', '/js/*', '/plugins/*']


// The default codec used to encode data with ${}
grails.views.default.codec = "none" // none, html, base64
grails.views.gsp.encoding = "UTF-8"
grails.converters.encoding = "UTF-8"
// enable Sitemesh preprocessing of GSP pages
grails.views.gsp.sitemesh.preprocess = true
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
// whether to disable processing of multi part requests
grails.web.disable.multipart=false

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password']

// enable query caching by default
grails.hibernate.cache.queries = true

// set per-environment serverURL stem for creating absolute links
environments {
    development {
        grails.logging.jul.usebridge = true
    }
    production {
        grails.logging.jul.usebridge = false
        // TODO: grails.serverURL = "http://www.changeme.com"
    }
}

// log4j configuration
log4j = {
    // Example of changing the log pattern for the default console
    // appender:
    //
    //appenders {
    //    console name:'stdout', layout:pattern(conversionPattern: '%c{2} %m%n')
    //}

    error  'org.codehaus.groovy.grails.web.servlet',  //  controllers
           'org.codehaus.groovy.grails.web.pages', //  GSP
           'org.codehaus.groovy.grails.web.sitemesh', //  layouts
           'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
           'org.codehaus.groovy.grails.web.mapping', // URL mapping
           'org.codehaus.groovy.grails.commons', // core / classloading
           'org.codehaus.groovy.grails.plugins', // plugins
           'org.codehaus.groovy.grails.orm.hibernate', // hibernate integration
           'org.springframework',
           'org.hibernate',
           'net.sf.ehcache.hibernate'
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// FlexyGames configuration
///////////////////////////////////////////////////////////////////////////////////////////////////

// URL
environments {
	development {
		grails.serverURL="http://localhost:8080/flexygames"
	}
	production {
		//grails.serverURL="http://www.onlacherien.org/games"
		grails.serverURL="http://www.flexygames.net"
	}
}

// pour la feature "remember me"
security.shiro.authc.required = false

// Google API Key
google.api.key = 'AIzaSyAoWBElMNGHdbLCdP-5WIY9rOJlEpdtgjE'

// mail config
grails.mail.default.from="webmaster@flexygames.net"
environments {
	development {
		grails {
			mail {
				//host = "localhost"
				//host = "smtp.free.fr"
				host = "smtp.orange.fr"
				port = 465
				//port = 25
			}
		}
	}
	production {
		grails {
			mail {
				host = "localhost"
				port = 25
			}
		}
	}
}
flexygames.mailing.webmaster="webmaster@flexygames.net"
flexygames.mailing.title.prefix='[FlexyGames] '
flexygames.mailing.title.suffix=''
flexygames.mailing.body.prefix='<html><head><meta content="text/html; charset=utf-8" http-equiv="Content-Type"></head><body>'
flexygames.mailing.body.suffix='</body></html>'

// file upload config
fileuploader {
	avatar {
		maxSize = 1024 * 32
		allowedExtensions = ["jpg","jpeg","gif","png", "JPG", "JPEG", "GIF", "PNG"]
		//path = "/home/turman/Workspace/GGTS/FlexyGames/upload/avatar/"
		path = "E:\\Repositories\\flexygames\\upload\\avatar" 
	}
	logo {
		maxSize = 1024 * 32
		allowedExtensions = ["jpg","jpeg","gif","png", "JPG", "JPEG", "GIF", "PNG"]
		//path = "/home/turman/Workspace/GGTS/FlexyGames/upload/logo/"
		path   = "E:\\Repositories\\flexygames\\upload\\logo"
	}
}
environments {
	production {
		//fileuploader.avatar.path = "/home/asas/upload/flexygames/avatar/"
		//fileuploader.logo.path = "/home/asas/upload/flexygames/logo/" 
	}
}



// Uncomment and edit the following lines to start using Grails encoding & escaping improvements

/* remove this line 
// GSP settings
grails {
    views {
        gsp {
            encoding = 'UTF-8'
            htmlcodec = 'xml' // use xml escaping instead of HTML4 escaping
            codecs {
                expression = 'html' // escapes values inside null
                scriptlet = 'none' // escapes output from scriptlets in GSPs
                taglib = 'none' // escapes output from taglibs
                staticparts = 'none' // escapes output from static template parts
            }
        }
        // escapes all not-encoded output at final stage of outputting
        filteringCodecForContentType {
            //'text/html' = 'html'
        }
    }
}
remove this line */