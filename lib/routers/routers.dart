import 'package:get/get.dart';
import '../screens/add_recommadtion_screen.dart';
import '../screens/add_recommendation_2.dart';
import '../screens/all_single_user_screen.dart';
import '../screens/all_user_screen.dart';
import '../screens/ask_recommendation_screen.dart';
import '../screens/bottom_nav_bar.dart';
import '../screens/categories.dart';
import '../screens/create_account.dart';
import '../screens/edit_account_screen.dart';
import '../screens/following_screen.dart';
import '../screens/home_screen.dart';
import '../screens/image.dart';
import '../screens/login_screen.dart';
import '../screens/otp_screen.dart';
import '../screens/post_screen.dart';
import '../screens/profile_post_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/recommendation_single_page.dart';
import '../screens/search_screen.dart';
import '../screens/single_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/thank_you.dart';
import '../screens/user_profile_screen.dart';

class MyRouters {
  static var splashScreen = "/splashScreen";

  static var loginScreen = "/loginScreen";
  static var otpScreen = "/otpScreen";
  static var createAccountScreen = "/createAccountScreen";
  static var thankYouScreen = "/thankYouScreen";

  static var homeScreen = "/homeScreen";
  static var askRecommendationScreen = "/askRecommendationScreen";
  static var bottomNavbar = "/bottomNavbar";
  static var profileScreen = "/profileScreen";
  static var addRecommendationScreen = "/addRecommendationScreen";
  static var editAccount = "/editAccount";
  static var followingScreen = "/followingScreen";
  static var postScreen = "/postScreen";
  static var recommendationSingleScreen = "/recommendationSingleScreen";
  static var categoriesScreen = "/categoriesScreen";

  static var userProfileScreen = "/userProfileScreen";

  static var searchScreen = "/searchScreen";
  static var allUserProfileScreen = "/allUserProfileScreen";
  static var profilePostScreen = "/profilePostScreen";
  static var singleScreen = "/singleScreen";
  static var singlePostScreen = "/singlePostScreen";
  static var addRecommendationScreen1 = "/addRecommendationScreen1";


  static var route = [
      // GetPage(name: '/', page: () =>  Imagescreen()),
     GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(name: '/loginScreen', page: () => const LoginScreen()),
    GetPage(name: '/singleScreen', page: () => const SingleScreen()),
    GetPage(name: '/otpScreen', page: () => const OtpScreen()),
    GetPage(
        name: '/createAccountScreen', page: () => const CreateAccountScreen()),
    GetPage(name: '/thankYouScreen', page: () => const ThankYouScreen()),
    GetPage(name: '/allUserProfileScreen', page: () => const AllUserProfileScreen()),
    GetPage(name: '/bottomNavbar', page: () => const BottomNavbar()),
    GetPage(name: '/homeScreen', page: () => const HomeScreen()),
    GetPage(
        name: '/askRecommendationScreen',
        page: () => const AskRecommendationScreen()),
    GetPage(name: '/profileScreen', page: () => const ProfileScreen()),
    GetPage(name: '/searchScreen', page: () => const SearchScreen()),
    GetPage(name: '/addRecommendationScreen1', page: () => const AddRecommendationScreen1()),
    GetPage(
        name: '/addRecommendationScreen',
        page: () => const AddRecommendationScreen()),
    GetPage(name: '/editAccount', page: () => const EditAccount()),
    GetPage(name: '/followingScreen', page: () => const FollowingScreen()),
    GetPage(name: '/postScreen', page: () => const PostScreen()),
    GetPage(
        name: '/recommendationSingleScreen',
        page: () => const RecommendationSingleScreen()),
    GetPage(name: '/categoriesScreen', page: () => const CategoriesScreen()),
    GetPage(name: '/userProfileScreen', page: () => const UserProfileScreen()),
    GetPage(name: '/profilePostScreen', page: () => const ProfilePost()),
    GetPage(name: '/singlePostScreen', page: () => const SingleProfilePost()),
  ];
}
