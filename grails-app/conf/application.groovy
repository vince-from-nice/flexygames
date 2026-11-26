///////////////////////////////////////////////////////////////////////////////////////////////////
// Grails and plugins configuration
///////////////////////////////////////////////////////////////////////////////////////////////////

environments {
    development {
        grails.serverURL="http://localhost:8080"
        server.servlet.session.timeout = "600s"
    }
    production {
        grails.serverURL="https://www.flexygames.net"
        server.servlet.session.timeout = "600s"
    }
}

grails.mail.default.from="webmaster@flexygames.net"
environments {
    development {
        grails {
            // Config for SMTP of Orange
//            mail {
//                host = "smtp.orange.fr"
//                port = 465
//            }
            // Config for SMTP of Free
//            mail {
//                host = "smtp.free.fr"
//                port = 25
//            }
            // Config for GMail SMTP: It works but I need to activate a security parameter in Google account: "Allow application which are less secure"
            mail {
                host = "smtp.gmail.com"
                port = 465
                username = "vincent.frison@gmail.com"
                password = "not_in_git"
                props = ["mail.smtp.auth":"true",
                         "mail.smtp.socketFactory.port":"465",
                         "mail.smtp.socketFactory.class":"javax.net.ssl.SSLSocketFactory",
                         "mail.smtp.socketFactory.fallback":"false",
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

// Obsolete with the grails 3.x plugin version ?
security.shiro.authc.required = false

// It should be outside Git
google.api.key = 'notAnymoreInGit'

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


