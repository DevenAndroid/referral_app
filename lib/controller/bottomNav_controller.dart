import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:referral_app/screens/all_user_screen.dart';

import '../screens/home_screen.dart';

class BottomNavBarController extends GetxController {
  RxInt pageIndex = 0.obs;
  RxInt page1Index = 0.obs;
  List<Widget> page1List = [
     const HomeScreen(),
    const AllUserProfileScreen(),
  ];
  updateIndexValue(value) {
    pageIndex.value = value;
    if(page1Index.value == 1){
      page1Index.value = 0;
    }
  }
}
