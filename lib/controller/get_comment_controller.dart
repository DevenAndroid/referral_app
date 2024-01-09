
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:referral_app/models/home_page_model.dart';
import 'package:referral_app/repositories/home_pafe_repo.dart';

import '../controller/homeController.dart';
import '../models/get_comment_model.dart';
import '../repositories/get_comment_repo.dart';

class GetCommentController extends GetxController{
  Rx<RxStatus> statusOfGetComment = RxStatus.empty().obs;
  Rx<GetCommentModel> getCommentModel = GetCommentModel().obs;
  TextEditingController commentController = TextEditingController();
  final homeController = Get.put(HomeController());
  String type='';
  String id = '';
  getComment({id, type}){
    statusOfGetComment.value = RxStatus.empty();
    getCommentRepo(id: id,type: type).then((value) {
      statusOfGetComment.value = RxStatus.success();
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