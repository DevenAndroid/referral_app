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


  Future getFriendListUpdate() async{
    isFriendLoad.value = false;
    getFriendListRepo().then((value) {
      isFriendLoad.value = true;
      getFriendListModel.value = value;
      for(var i in  tagId){
        getFriendListModel.value.data!.firstWhere((element) => element.id == i ).checkBoxValue = true;
        selectedFriendIds.add(i);
        print("Loppp hitted");
        print("Loppp hitted${i.toString()}");
      }
    });
  }
  Future getFriendList() async{
    isFriendLoad.value = false;
    getFriendListRepo().then((value) {
      isFriendLoad.value = true;
      getFriendListModel.value = value;
    });
  }
  List<int> tagId = <int>[];


  @override
  void onInit() {
    super.onInit();
    getFriendList();
    // getData();
  }
}