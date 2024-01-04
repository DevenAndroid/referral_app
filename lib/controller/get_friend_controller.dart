import 'dart:developer';
import 'dart:ffi';

import 'package:get/get.dart';
import 'package:referral_app/models/home_page_model.dart';
import 'package:referral_app/repositories/home_pafe_repo.dart';

import '../models/friendlist_model.dart';
import '../models/get_comment_model.dart';
import '../repositories/get_comment_repo.dart';
import '../repositories/get_friend_list_repo.dart';

class GetFriendListController extends GetxController{
  RxBool isFriendLoad = false.obs;
  Rx<FriendListModel> getFriendListModel = FriendListModel().obs;

  List<int?> selectedFriendIds = [];
  List<String?> selectedFriend = [];


  getFriendList(){
    isFriendLoad.value = false;
    getFriendListRepo().then((value) {
      isFriendLoad.value = true;
      getFriendListModel.value = value;
    });
  }



  @override
  void onInit() {
    super.onInit();
    getFriendList();
    // getData();
  }
}