import '../views/about_app_screen.dart';
import '../views/account_details_screen.dart';
import '../views/account_screen.dart';
import '../views/dashboard_screen.dart';
import '../views/forget_screen.dart';
import '../views/home_screen.dart';
import '../views/login_screen.dart';
import '../views/privacy_policy_screen.dart';
import '../views/resetpassword_screen.dart';
import '../views/signup_screen.dart';
import '../views/splash_screen.dart';
import '../views/support_screen.dart';

class AppRoutes {
  static const home = '/home';
  static const login = '/login';
  static const signup = '/signup';
  static const forgotPassword = '/forgot_password';
  static const resetPassword = '/reset-password';
  static const account = '/account';
  static const dashboard = '/dashboard';
  static const splash = '/splash';
  static const accountdetails = '/accountdetails';
  static const support = '/support';
  static const privacy = '/privacy';
  static const about = '/about';

  static final routes = {
    home: (context) => HomeScreen(),
    login: (context) => LoginScreen(),
    signup: (context) => SignupScreen(),
    forgotPassword: (context) => ForgotPasswordScreen(),
    resetPassword: (context) => ResetPasswordScreen(),
    account: (context) => AccountScreen(),
    dashboard: (context) => DashboardScreen(),
    splash: (context) => SplashScreen(),
    accountdetails: (context) => AccountDetailsScreen(),
    support: (context) => SupportScreen(),
    privacy: (context) => PrivacyPolicyScreen(),
    about: (context) => AboutAppScreen(),
  };
}
