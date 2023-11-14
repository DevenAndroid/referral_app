




import 'package:get/get.dart';

import '../screens/create_account.dart';
import '../screens/login_screen.dart';
import '../screens/otp_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/thank_you.dart';

class MyRouters {
  static var splashScreen = "/splashScreen";

  static var loginScreen = "/loginScreen";
  static var otpScreen = "/otpScreen";
  static var createAccountScreen = "/createAccountScreen";
  static var thankYouScreen = "/thankYouScreen";


  static var route = [
    GetPage(name: '/', page: () =>  const SplashScreen()),
    GetPage(name: '/loginScreen', page: () =>  const LoginScreen()),
 GetPage(name: '/otpScreen', page: () =>  const OtpScreen()),
 GetPage(name: '/createAccountScreen', page: () =>  const CreateAccountScreen()),
 GetPage(name: '/thankYouScreen', page: () =>  const ThankYouScreen()),




  ];
}