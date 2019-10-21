///////////////////////////////////////////////////////////////////////////////////////////////////
// Grails and plugins configuration
///////////////////////////////////////////////////////////////////////////////////////////////////

environments {
    development {
        grails.serverURL="http://192.168.1.11:8080"
        server.session.timeout = 600
    }
    production {
        grails.serverURL="https://www.flexygames.net"
        server.session.timeout = 600
    }
}

grails.mail.default.from="webmaster@flexygames.net"
environments {
    development {
        grails {
            // Config for SMTP of Orange
            mail {
                host = "smtp.orange.fr"
                port = 465
            }
            // Config for SMTP of Free
//            mail {
//                host = "smtp.free.fr"
//                port = 25
//            }
            // Config for GMail SMTP: It works but I need to activate a security parameter in Google account: "Allow application which are less secure"
//            mail {
//                host = "smtp.gmail.com"
//                port = 465
//                username = "vincent.frison@gmail.com"
//                password = "not_in_git"
//                props = ["mail.smtp.auth":"true",
//                         "mail.smtp.socketFactory.port":"465",
//                         "mail.smtp.socketFactory.class":"javax.net.ssl.SSLSocketFactory",
//                         "mail.smtp.socketFactory.fallback":"false",
//                         "mail.debug": "true"]
//            }
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

ckeditor {
    config = "/js/myckconfig.js"
    skipAllowedItemsCheck = false
    defaultFileBrowser = "ofm"
    upload {
        basedir = "/uploads/"
        overwrite = false
        link {
            browser = true
            //upload = false
            upload = true
            //allowed = []
            allowed = ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'pwt', 'pwtx', 'odt', 'ods', 'odp', 'odb', 'odg', 'odf']
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

// Obsolete with the grails 3.x plugin version ?
security.shiro.authc.required = false

// It should be outside Git
google.api.key = 'AIzaSyAoWBElMNGHdbLCdP-5WIY9rOJlEpdtgjE'

///////////////////////////////////////////////////////////////////////////////////////////////////
// FlexyGames specific configuration
///////////////////////////////////////////////////////////////////////////////////////////////////

// Miscellaneous
flexygames.amnestyDaysNbr = 10

// Mailing
flexygames.mailing.webmaster="webmaster@flexygames.net"
flexygames.mailing.title.prefix='[FlexyGames] '
flexygames.mailing.title.suffix=''
flexygames.mailing.body.prefix='<html><head><meta content="text/html; charset=utf-8" http-equiv="Content-Type"></head><body>'
flexygames.mailing.body.suffix='</body></html>'

// File uploading
flexygames.fileUpload.userAvatar.maxSize = 1024 * 64
flexygames.fileUpload.userAvatar.allowedExtensions = ["jpg","jpeg","gif","png"]
flexygames.fileUpload.teamLogo.maxSize = 1024 * 64
flexygames.fileUpload.teamLogo.allowedExtensions = ["jpg","jpeg","gif","png"]
environments {
    development {
        flexygames.fileUpload.userAvatar.path = "/home/turman/Repositories/flexygames/src/main/webapp/images/user/"
        flexygames.fileUpload.teamLogo.path = "/home/turman/Repositories/flexygames/src/main/webapp/images/team/"
    }
    production {
        flexygames.fileUpload.userAvatar.path = "/root/webapps/flexygames/deployed/images/user/"
        flexygames.fileUpload.teamLogo.path = "/root/webapps/flexygames/deployed/images/team/"
    }
}


