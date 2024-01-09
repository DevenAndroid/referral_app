
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:referral_app/models/home_page_model.dart';
import 'package:referral_app/repositories/home_pafe_repo.dart';

import '../controller/homeController.dart';
import '../models/get_comment_model.dart';
import '../models/model_review_list.dart';
import '../repositories/get_comment_repo.dart';
import '../repositories/repo_review_list.dart';
import '../screens/recco_comment_ui.dart';

class GetRecommendationController extends GetxController{

  Rx<RxStatus> statusOfGetReco = RxStatus.empty().obs;
  Rx<ModelReviewList> modelReviewList = ModelReviewList().obs;
  TextEditingController commentController = TextEditingController();
  final homeController = Get.put(HomeController());
  Rx<RxStatus> statusOfRemove = RxStatus.empty().obs;
  Rx<RxStatus> statusOfGetComment = RxStatus.empty().obs;
  Rx<GetCommentModel> getCommentModel = GetCommentModel().obs;
  String postId = '';
  String type='';
  String idForReco = '';

  getRecommendation({idForReco}){
    statusOfGetReco.value = RxStatus.empty();
    print('iddd isssssssss${idForReco}');
    getReviewListRepo(id: idForReco).then((value) async {
      modelReviewList.value = value;
        statusOfGetReco.value = RxStatus.success();
        modelReviewList.value = value;
        await homeController.getData();
    });
  }

  getComments(id,context) {
    print('id isss...${id.toString()}');
    statusOfGetComment.value = RxStatus.empty();
    getCommentRepo(id: id, type: 'recommandation').then((value) {
      getCommentModel.value = value;
        statusOfGetComment.value = RxStatus.success();
    });
  }

  @override
  void onInit() {
    super.onInit();
    getRecommendation();
  }

  void commentBottomSheetReco(context) {
    var height = MediaQuery.of(context).size.height;
    showModalBottomSheet(
        enableDrag: true,
        isDismissible: true,
        constraints: BoxConstraints(
          maxHeight: height * .7,
        ),
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.white,
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
        ),
        builder: (BuildContext context) {
          return const ReccoCommentScreen();
        });
  }

}