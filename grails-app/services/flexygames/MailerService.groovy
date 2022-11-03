package flexygames

import grails.gorm.transactions.Transactional
import grails.util.Environment

import org.springframework.context.i18n.LocaleContextHolder as LCH


@Transactional
class MailerService {

    def grailsApplication

    //def messageSource

    def mail(addresses, title, body) {
        def conf = grailsApplication.config.flexygames.mailing
        def htmlTitle = '' + conf.title.prefix + title + conf.title.suffix
        def bodyHeader = grailsApplication.getMainContext().getMessage("mail.body.header", [] as Object[], LCH.getLocale())
        def bodyFooter = grailsApplication.getMainContext().getMessage("mail.body.footer", [] as Object[], LCH.getLocale())
        def htmlBody = '' + conf.body.prefix + bodyHeader + body + '<br><br><hr><br>' + bodyFooter + conf.body.suffix
        println "Mail sent to $addresses : $htmlTitle {$body ...}"
        println "$htmlBody"
        // Send mails ONLY in Production environment
        if (Environment.currentEnvironment == Environment.PRODUCTION
                || (addresses.size() == 1 && addresses[0] == 'vincent.frison@gmail.com')) {
            sendMail {
                from conf.webmaster
                to conf.webmaster
                bcc addresses
                subject htmlTitle
                html htmlBody
            }
        } else {
            println "Environment is not in production mode, no mail is sent !"
        }
    }

    def mailForContact(email, title, body) {
        def conf = grailsApplication.config.flexygames.mailing
        def htmlTitle = '' + conf.title.prefix + ' [Contact] ' + title + conf.title.suffix
        def htmlBody = '' + conf.body.prefix + body + '<br><br><hr><br>' + conf.body.suffix
        println "Mail for contact sent by $email with body : $htmlTitle"
        // Send mails ONLY in Production environment
        if (Environment.currentEnvironment == Environment.PRODUCTION || email == 'vincent.frison@gmail.com') {
            sendMail {
                from email
                to conf.webmaster
                cc email
                subject htmlTitle
                html htmlBody
            }
        } else {
            println "Environment is not in production mode, no mail is sent !"
        }
    }

}
