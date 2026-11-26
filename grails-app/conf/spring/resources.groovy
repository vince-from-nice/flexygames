import org.apache.shiro.authc.credential.HashedCredentialsMatcher

// Passwords are stored as unsalted SHA-512 hashes, hex encoded.
beans = {
	credentialMatcher(HashedCredentialsMatcher) {
		hashAlgorithmName = 'SHA-512'
		storedCredentialsHexEncoded = true
	}
}
