import org.apache.shiro.authc.credential.Sha512CredentialsMatcher

// Place your Spring DSL code here
beans = {
	credentialMatcher(Sha512CredentialsMatcher) { storedCredentialsHexEncoded = true }
}
