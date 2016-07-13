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

environments {
    development {
        log4j = {
            // Vincent: log SQL statements (see DataSource too)
            //debug 'org.hibernate.SQL'
            //trace 'org.hibernate.type.descriptor.sql.BasicBinder'
            //trace 'org.hibernate.type'
        }
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// FlexyGames configuration
///////////////////////////////////////////////////////////////////////////////////////////////////

// URL
environments {
	development {
		grails.serverURL="http://192.168.1.22:8080/flexygames"
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
            // Config for Orange SMTP
			mail {
                // It doesn't work..
				host = "smtp.orange.fr"
				port = 465
			}

            // Config for GMail SMTP
            mail {
                // It works but I need to activate a security parameter in Google account: "Allow application which are less secure"
                host = "smtp.gmail.com"
                port = 465
                username = "vincent.frison@gmail.com"
                password = "not_in_git"
                props = ["mail.smtp.auth":"true",
                         "mail.smtp.socketFactory.port":"465",
                         "mail.smtp.socketFactory.class":"javax.net.ssl.SSLSocketFactory",
                         "mail.smtp.socketFactory.fallback":"false",
                         "mail.smtp.starttls.enable": "true",
                         "mail.debug": "true"]
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

// Mailing
flexygames.mailing.webmaster="webmaster@flexygames.net"
flexygames.mailing.title.prefix='[FlexyGames] '
flexygames.mailing.title.suffix=''
flexygames.mailing.body.prefix='<html><head><meta content="text/html; charset=utf-8" http-equiv="Content-Type"></head><body>'
flexygames.mailing.body.suffix='</body></html>'

// File uploading
flexygames.fileUpload.userAvatar.maxSize = 1024 * 32
flexygames.fileUpload.userAvatar.allowedExtensions = ["jpg","jpeg","gif","png"]
flexygames.fileUpload.userAvatar.path = "E:\\Repositories\\flexygames\\web-app\\images\\user"
flexygames.fileUpload.teamLogo.maxSize = 1024 * 32
flexygames.fileUpload.teamLogo.allowedExtensions = ["jpg","jpeg","gif","png"]
flexygames.fileUpload.teamLogo.path = "E:\\Repositories\\flexygames\\web-app\\images\\team"
environments {
    production {
        flexygames.fileUpload.userAvatar.path = "/home/asas/webapps/flexygames/images/user/"
        flexygames.fileUpload.teamLogo.path = "/home/asas/webapps/flexygames/images/team/"
    }
}

ckeditor {
    config = "/js/myckconfig.js"
    skipAllowedItemsCheck = false
    defaultFileBrowser = "ofm"
    upload {
        basedir = "/uploads/"
        overwrite = false
        link {
            browser = true
            upload = false
            allowed = []
            denied = ['html', 'htm', 'php', 'php2', 'php3', 'php4', 'php5',
                      'phtml', 'pwml', 'inc', 'asp', 'aspx', 'ascx', 'jsp',
                      'cfm', 'cfc', 'pl', 'bat', 'exe', 'com', 'dll', 'vbs', 'js', 'reg',
                      'cgi', 'htaccess', 'asis', 'sh', 'shtml', 'shtm', 'phtm']
        }
        image {
            browser = true
            upload = true
            allowed = ['jpg', 'gif', 'jpeg', 'png']
            denied = []
        }
        flash {
            browser = false
            upload = false
            allowed = ['swf']
            denied = []
        }
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
