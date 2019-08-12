package flexygames

import org.apache.shiro.authc.AccountException
import org.apache.shiro.authc.IncorrectCredentialsException
import org.apache.shiro.authc.UnknownAccountException
import org.apache.shiro.authc.SimpleAuthenticationInfo
import org.apache.shiro.authc.credential.CredentialsMatcher
import org.apache.shiro.authc.UsernamePasswordToken
import org.apache.shiro.authc.AuthenticationInfo
import org.apache.shiro.authc.AuthenticationToken
import org.apache.shiro.authz.Permission
import org.apache.shiro.authz.permission.WildcardPermissionResolver
import org.apache.shiro.grails.GrailsShiroRealm
import org.apache.shiro.grails.SimplifiedRealm
import org.apache.shiro.grails.PrincipalHolder

class ShiroWildcardDbRealm implements GrailsShiroRealm, SimplifiedRealm {

    CredentialsMatcher credentialMatcher

    ShiroWildcardDbRealm() {
        setTokenClass(UsernamePasswordToken)
        setPermissionResolver(new WildcardPermissionResolver())
    }

    AuthenticationInfo authenticate(AuthenticationToken authToken) {
        if (authToken instanceof UsernamePasswordToken) {
            log.info "Attempting to authenticate ${authToken.username} in DB realm..."
            String username = authToken.username

            // Null username is invalid
            if (username == null) {
                throw new AccountException("Null usernames are not allowed by this realm ${getName()}.")
            }

            // turman: try to find user by username
            def user = User.findByUsername(username)
            if (!user) {
                throw new UnknownAccountException("No account found for user [${username}]")
            }

            log.info "Found user ${user.username} in DB"

            // Now check the user's password against the hashed value stored in the database.
            // First we create a SimpleAccount to hold our Prinicipal Object which in this case is utility PrincipalHolder
            // defined below
            SimpleAuthenticationInfo account = new SimpleAuthenticationInfo(new ShiroWildcardDbPrincipalHolder(user), user.passwordHash, "ShiroWildcardDbRealm")
            if (!credentialMatcher.doCredentialsMatch(authToken, account)) {
                log.info "Invalid password (ShiroWildcardDbRealm)"
                throw new IncorrectCredentialsException("Invalid password for user ${username}")
            }
            return account
        }
        throw new AccountException("${authToken.class.name} tokens are not accepted by this realm ${getName()}.")
    }

    // Implements SimpleRealm
    boolean hasRole(Object principal, String roleName) {
        if (principal instanceof ShiroWildcardDbPrincipalHolder) {
            ShiroWildcardDbPrincipalHolder ph = (ShiroWildcardDbPrincipalHolder) principal
            return ph.roles.find { it == roleName} != null
        }
        return false
    }

    // Implements SimpleRealm
    boolean hasAllRoles(Object principal, Collection<String> roles) {
        if (principal instanceof ShiroWildcardDbPrincipalHolder) {
            ShiroWildcardDbPrincipalHolder ph = (ShiroWildcardDbPrincipalHolder) principal
            return ph.roles.containsAll(roles)
        }
        return false
    }

    // Implements SimpleRealm
    boolean isPermitted(Object principal, Permission requiredPermission) {
        if (principal instanceof ShiroWildcardDbPrincipalHolder) {
            ShiroWildcardDbPrincipalHolder ph = (ShiroWildcardDbPrincipalHolder) principal
            return anyImplied(requiredPermission, ph.permissions)
        }
        return false
    }

    private boolean anyImplied(Permission requiredPermission, Collection<String> permStrings) {
        permStrings.find { String permString ->
            getPermissionResolver()
                    .resolvePermission(permString)
                    .implies(requiredPermission)
        } != null
    }
}

class ShiroWildcardDbPrincipalHolder implements Serializable, PrincipalHolder {

    Long id
    String userName

    ShiroWildcardDbPrincipalHolder(User user) {
        id = user.id
        userName = user.username
    }

    Set<String> getRoles() {
        User.get(id)?.roles?.collect { it.name } ?: []
    }

    Set<String> getPermissions() {
        User user = User.get(id)
        Set<String> permissions = []
        if (user) {
            permissions.addAll(user.permissions)
            user.roles.each {
                Role role ->
                permissions.addAll(role.permissions)
            }
            return permissions
        }
        return []
    }

    String toString() {
        return userName
    }
}