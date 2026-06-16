// AppRouter — GoRouter configuration
// ref.watch(authStateProvider) drives redirect logic:
//   - unauthenticated → /auth/login
//   - ROLE_CUSTOMER → /customer/home
//   - ROLE_ORGANIZER → /organizer/dashboard
//   - ROLE_ADMIN → /admin/dashboard
// ShellRoute for bottom navigation per role
