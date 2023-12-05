
import 'package:get/get.dart';
import 'package:referral_app/models/all_recommendation_model.dart';

import '../repositories/all_recommendation_repo.dart';

/*
class AllRecommendationController extends GetxController{
  RxBool isDataLoading = false.obs;
  RxInt pagination = 10.obs;
  RxInt page = 1.obs;
  RxBool loading = false.obs;
  RxInt refreshInt = 0.obs;
  bool moreDataAvailable = true;
  bool paginationWorking = false;
  Rx<AllRecommendationModel> allRecommendationModel = AllRecommendationModel(data: []).obs;

  updateUi() {
    refreshInt.value = DateTime.now().millisecondsSinceEpoch;
  }
  Future getPaginate({bool? resetPagination = false}) async {
    if (resetPagination == true) {
      moreDataAvailable = true;
      paginationWorking = false;
      page.value = 1;
    }
    if (!moreDataAvailable) {
      return;
    }
    if (paginationWorking) {
      return;
    }
    paginationWorking = true;
    updateUi();
    await getAllRepo(
      pagination: pagination.value,
      page: page.value,
    ).then((value) {
      print('apiiiiiii----  ${value.data}');
      // log(value.homePageData!.length.toString());
      if (resetPagination == true) {
        allRecommendationModel.value.data!.clear();
      }

      isDataLoading.value = true;
      paginationWorking = false;
      if (value.data!.isNotEmpty) {
        allRecommendationModel.value.data!.addAll(value.data!);
        page.value++;
      } else {
        moreDataAvailable = false;
      }
      updateUi();
    });
  }


  @override
  void onInit() {
    super.onInit();
    getPaginate();
  }
}*/
