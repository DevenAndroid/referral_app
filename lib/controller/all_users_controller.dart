
import 'package:get/get.dart';
import 'package:referral_app/models/all_recommendation_model.dart';

import '../models/all_user_model.dart';
import '../repositories/all_useer_repo.dart';

/*
class AllUsersController extends GetxController{
  RxBool isDataLoading = false.obs;
  RxInt pagination = 10.obs;
  RxInt page = 1.obs;
  RxBool loading = false.obs;
  RxInt refreshInt = 0.obs;
  bool moreDataAvailable = true;
  bool paginationWorking = false;
  Rx<AllUserModel> allUsersModel = AllUserModel(data: []).obs;
  //RxList<UserList> userList = <UserList>[].obs;
  //Rx<Discover> homePaginationModel = Discover().obs;
  //RxList<Discover> discoverList = <Discover>[].obs;

  updateUi() {
    refreshInt.value = DateTime.now().millisecondsSinceEpoch;
  }
*/
/*Future<AllUserModel> getFeedBack() async {
    isDataLoading.value = false;
    AllUserModel kk = await getUserRepo(
      pagination: 10,
      page: 1,
    ).then((value) {
      isDataLoading.value = true;
      allUsersModel.value = value;
      return value;
    });
    return kk;
  }*//*


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
    await getUserRepo(
      pagination: pagination.value,
      page: page.value,
    ).then((value) {
      print('apiiiiiii----  ${value.data}');
      // log(value.homePageData!.length.toString());
      if (resetPagination == true) {
        allUsersModel.value.data!.clear();
      }

      isDataLoading.value = true;
      paginationWorking = false;
      if (value.data!.isNotEmpty) {
        allUsersModel.value.data!.addAll(value.data!);
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

}
*/
