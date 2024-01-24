import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/app_theme.dart';




class ApiUrls {
  static const String apiBaseUrl = 'https://referral-app.eoxyslive.com/api/';
  // static const String apiBaseUrl = 'http://3.131.10.217/api/';
  static const String login = "${apiBaseUrl}login";
  static const String verifyOtp = "${apiBaseUrl}verify-otp";
  static const String updateProfile = "${apiBaseUrl}update-profile";
  static const String resendOtp = "${apiBaseUrl}resend-otp";
  static const String addAskRecommandation = "${apiBaseUrl}add-ask-recommandation";
  static const String addRecommandation = "${apiBaseUrl}add-recommandation";
  static const String categories = "${apiBaseUrl}categories";
  static const String home = "${apiBaseUrl}home";
  static const String userProfile = "${apiBaseUrl}user-profile";
  static const String allRecommendation = "${apiBaseUrl}all-recommandation";
  static const String logout = "${apiBaseUrl}logout";
  static const String deleteUser = "${apiBaseUrl}delete-user";
  static const String following = "${apiBaseUrl}following-list?user_id=";
  static const String followers = "${apiBaseUrl}followers-list?user_id=";
  static const String unfollow = "${apiBaseUrl}add-remove-follower";
  static const String pages = "${apiBaseUrl}pages?slug=";
  static const String singleCategories = "${apiBaseUrl}single-category?category_id=";
  static const String userData = "${apiBaseUrl}single-user?recommandation_id=";
  static const String addRemoveBookmark = "${apiBaseUrl}add-remove-bookmark";
  static const String allUsers = "${apiBaseUrl}all-users";
  static const String addRemoveFollower = "${apiBaseUrl}add-remove-follower";
  static const String reviewList = "${apiBaseUrl}review-list";
  static const String getComment = "${apiBaseUrl}get-commetns";
  static const String getFriendList = "${apiBaseUrl}friends-list";
  static const String deleteRecommand = "${apiBaseUrl}delete-recommandation";
  static const String deleteMyRequest = "${apiBaseUrl}delete-ask-recommandation";
  static const String addRemoveLike = "${apiBaseUrl}add-remove-like";
  static const String addComment = "${apiBaseUrl}add-comment";
  static const String getNotification = "${apiBaseUrl}notification-list";

}

Future getAuthHeader() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  // pref.getString("cookie")!.toString().replaceAll('\"', '');
  var gg ={
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',

    // HttpHeaders.authorizationHeader:"FLWSECK_TEST-SANDBOXDEMOKEY-X"
    if(pref.getString("cookie") != null)
      HttpHeaders.authorizationHeader: 'Bearer ${pref.getString("cookie")!.toString().replaceAll('\"', '')}',
  };
  print(gg);
  return gg;
}
Future getAuthHeaderApi() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  // pref.getString("cookie")!.toString().replaceAll('\"', '');
  var gg ={
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    // FLWSECK_TEST-2e4497e1d44affec2b5bb40148e43193-X
    HttpHeaders.authorizationHeader:"FLWSECK_TEST-SANDBOXDEMOKEY-X"
    // if(pref.getString("cookie") != null)
    //   HttpHeaders.authorizationHeader: 'Bearer ${pref.getString("cookie")!.toString().replaceAll('\"', '')}',
  };
  print(gg);
  return gg;
}


// HttpHeaders.contentTypeHeader: 'application/json',
// HttpHeaders.acceptHeader: 'application/json',
//     HttpHeaders.authorizationHeader: 'Bearer ${pref.getString("cookie")!.toString().replaceAll('\"', '')}',

showToast(message) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppTheme.secondaryColor,
      textColor: Color(0xffffffff),
      fontSize: 14);
}

showToastError(message) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Color(0xffffffff),
      fontSize: 14);
}

showToastBlack(message) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blue,
      textColor: Color(0xffffffff),
      fontSize: 14);
}