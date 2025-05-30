import '../views/account_screen.dart';
import '../views/booking_screen.dart';
import '../views/category_screen.dart';
import '../views/dashboard_screen.dart';
import '../views/forget_screen.dart';
import '../views/home_screen.dart';
import '../views/login_screen.dart';
import '../views/order_complete_screen.dart';
import '../views/resetpassword_screen.dart';
import '../views/signup_screen.dart';
import '../views/splash_screen.dart';

class AppRoutes {
  static const home = '/home';
  static const category = '/category';
  static const login = '/login';
  static const signup = '/signup';
  static const forgotPassword = '/forgot_password';
  static const resetPassword = '/reset-password';
  static const account = '/account';
  static const dashboard = '/dashboard';
  static const splash = '/splash';

  static final routes = {
    home: (context) => HomeScreen(),
    category: (context) => CategoryScreen(),
    login: (context) => LoginScreen(),
    signup: (context) => SignupScreen(),
    forgotPassword: (context) => ForgotPasswordScreen(),
    resetPassword: (context) => ResetPasswordScreen(),
    account: (context) => AccountScreen(),
    dashboard: (context) => DashboardScreen(),
    splash: (context) => SplashScreen(),
  };
}
