
import 'dart:developer';

import 'package:get/get.dart';
import 'package:referral_app/models/home_page_model.dart';
import 'package:referral_app/repositories/home_pafe_repo.dart';

import '../models/get_comment_model.dart';
import '../repositories/get_comment_repo.dart';

class GetCommentController extends GetxController{
  RxBool isDataLoading3 = false.obs;
  Rx<GetCommentModel> getCommentModel = GetCommentModel().obs;
  getComment(){
    isDataLoading3.value = false;
    getCommentRepo().then((value) {
      isDataLoading3.value = false;
      getCommentModel.value = value;
    });
  }



  @override
  void onInit() {
    super.onInit();
    getComment();
    // getData();
  }
}