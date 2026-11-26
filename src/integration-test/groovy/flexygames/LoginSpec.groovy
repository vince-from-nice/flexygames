package flexygames

import grails.gorm.transactions.Rollback
import grails.testing.mixin.integration.Integration
import org.apache.shiro.authc.AuthenticationException
import org.apache.shiro.authc.SimpleAuthenticationInfo
import org.apache.shiro.authc.UsernamePasswordToken
import org.apache.shiro.authc.credential.CredentialsMatcher
import org.apache.shiro.mgt.SecurityManager
import spock.lang.Specification

@Integration
@Rollback
class LoginSpec extends Specification {

    // SHA-512 of "gluar", hex encoded, as the user table stores it
    static final String STORED_HASH =
            '00f9f7cd5c187d69ac939b3b5740e9ef711721917e8d3ab05494ff7c2411829e01e0fd1bebaa3bb95d7415077569ff9c11abf425e85c270dbf42aa6ed3629650'

    CredentialsMatcher credentialMatcher
    SecurityManager shiroSecurityManager

    void "a password stored as an unsalted SHA-512 hex hash matches"() {
        given:
        def stored = new SimpleAuthenticationInfo('turman', STORED_HASH, 'test')

        expect:
        credentialMatcher.doCredentialsMatch(new UsernamePasswordToken('turman', 'gluar'), stored)
        !credentialMatcher.doCredentialsMatch(new UsernamePasswordToken('turman', 'wrong'), stored)
    }

    void "a seed user signs in through the database realm"() {
        when:
        def info = shiroSecurityManager.authenticate(new UsernamePasswordToken('turman', 'gluar'))

        then:
        info.principals.primaryPrincipal.toString() == 'turman'
    }

    void "a signed-in administrator has the roles and permissions of the database"() {
        when:
        def principals = shiroSecurityManager.authenticate(new UsernamePasswordToken('turman', 'gluar')).principals

        then:
        shiroSecurityManager.hasRole(principals, 'Administrator')
        shiroSecurityManager.hasRole(principals, 'Player')
        shiroSecurityManager.isPermitted(principals, 'myself:myAccount')
        shiroSecurityManager.isPermitted(principals, 'user:index')
    }

    void "a wrong password is refused"() {
        when:
        shiroSecurityManager.authenticate(new UsernamePasswordToken('turman', 'wrong'))

        then:
        thrown(AuthenticationException)
    }
}
