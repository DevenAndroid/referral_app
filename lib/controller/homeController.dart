
import 'dart:developer';

import 'package:get/get.dart';
import 'package:referral_app/models/home_page_model.dart';
import 'package:referral_app/repositories/home_pafe_repo.dart';

class HomeController extends GetxController{
  //Rx<Discover> discoverList = Discover().obs;
  Rx<HomeModel> homeModel = HomeModel(data: Data(discover: [])).obs;
  Rx<Discover> homePaginationModel = Discover().obs;
  RxList<Discover> discoverList = <Discover>[].obs;
  RxBool isDataLoading = false.obs;
  RxBool isDataLoading2 = false.obs;
  RxInt pagination = 10.obs;
  RxInt page = 1.obs;
  RxBool loading = false.obs;
  RxInt refreshInt = 0.obs;
  bool moreDataAvailable = true;
  bool paginationWorking = false;

  Future getData() async{
    isDataLoading2.value = false;
   await homeRepo().then((value) {
      isDataLoading2.value = false;
      homeModel.value = value;
    });
  }


  @override
  void onInit() {
    super.onInit();
    getPaginate();
    getData();
  }


  updateUi() {
    refreshInt.value = DateTime.now().millisecondsSinceEpoch;
  }
  Future<HomeModel> getFeedBack() async {
    isDataLoading.value = false;
    HomeModel kk = await getHomeRepo(

      pagination: 10,
      page: 1,
    ).then((value) {
      isDataLoading.value = true;
      homeModel.value = value;
      return value;
    });
    return kk;
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
    await getHomeRepo(
      pagination: pagination.value,
      page: page.value,
    ).then((value) {
    // log(value.homePageData!.length.toString());
      if (resetPagination == true) {
        homeModel.value.data!.discover!.clear();
      }
      isDataLoading.value = true;
      paginationWorking = false;
      if (value.data!.discover!.isNotEmpty) {
        homeModel.value.data!.discover!.addAll(value.data!.discover!);
        page.value++;
      } else {
        moreDataAvailable = false;
      }
      updateUi();
    });
  }
  /*getData() async {
    if(loading.value == false){
      loading.value = true;
      getHomeRepo(pagination: pagination.value,page: page.value).then((value) {
        isDataLoading.value = true;
        //discoverList.value = value.data!.discover!;
        discoverList.value.addAll(value.data!.discover!);
        // page++;
        // discoverList.addAll(value.data!.discover!);
        // discoverList.value.clear();
        homeModel.value = value;
      });
    }
    //

  }*/


}