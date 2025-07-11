class UserAuthSchema {
  // Using the existing 'login' mutation name from schema.graphql
  static const String loginMutation = r'''
    mutation login($credentials: JSON!, $origin: String, $isDevMode: Boolean) {
      login(credentials: $credentials, origin: $origin, isDevMode: $isDevMode) {
        accessToken
        refreshToken
        user {
          id
          name
          type {
            name
            status
          }
          referenceId
          contactNumber
          emailId
          status
          employeeId
          userName
          displayName
          domain
        }
      }
    }
  ''';

  // Using the existing 'logout' mutation name from schema.graphql
  static const String logoutMutation = """
    mutation Logout {
      logout
    }
  """;

  // Using the existing 'refresh' query name from schema.graphql
  static const String refreshQuery = """
    query Refresh(\$refreshToken: String!) {
      refresh(refreshToken: \$refreshToken)
    }
  """;
} 