import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/all_recommendation_model.dart';
import '../models/delete_recomm.dart';
import '../models/get_profile_model.dart';
import '../models/model_user_profile.dart';
import '../models/single_product_model.dart';
import '../repositories/all_recommendation_repo.dart';
import '../repositories/get_profile_repo.dart';
import '../repositories/get_user_profile.dart';
import '../repositories/single_produc_repo.dart';
import '../widgets/helper.dart';

class ProfileController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String code = 'US';
  RxString selectedValue = 'select friends'.obs;
  bool check = false;
  final categoriesController = TextEditingController();
  final idController = TextEditingController();
  var profileDrawer = 0;
  Rx<GetProfileModel> modal = GetProfileModel().obs;
  Rx<RxStatus> statusOfProfile = RxStatus.empty().obs;
  Rx<SingleProduct> single = SingleProduct().obs;
  Rx<RxStatus> statusOfSingle = RxStatus.empty().obs;
  Rx<ModelUserProfile> userProfile = ModelUserProfile().obs;
  Rx<RxStatus> statusOfUser = RxStatus.empty().obs;
  String? address = "";
  bool checkForUser = false;
  String idUserPro = '';
  String isComplete = '';
  getData() {
    getProfileRepo().then((value) async {
      modal.value = value;
      if (value.status == true) {
        emailController.text = modal.value.data!.user!.email.toString();
        mobileController.text = modal.value.data!.user!.phone.toString();
        address = modal.value.data!.user!.address.toString();
        nameController.text = modal.value.data!.user!.name.toString();
        code = modal.value.data!.user!.countryCode.toString();
        isComplete =  modal.value.data!.user!.isComplete.toString();
        print("got value.....    ${code}");
        print("got compelete.....    ${isComplete.toString()}");
        if(code == "null" || code == ""){
          code = 'US';
        }
        statusOfProfile.value = RxStatus.success();

        // holder();
      } else {
        statusOfProfile.value = RxStatus.error();
      }

      print(value.message.toString());
    });
  }

  RxInt refreshData = 0.obs;
  RxInt refreshData1 = 0.obs;
  RxInt refreshUserCat = 0.obs;
  String categoryId = '';
  String userId = '';

  UserProfile() {
    userProfileRepo(recommandation_id: idUserPro, type: "user").then((value) {
           userProfile.value = value;
      print("userId>>>>>>>>>>$idUserPro");
      if (value.status == true) {
        statusOfUser.value = RxStatus.success();
      } else {
        statusOfUser.value = RxStatus.error();
      }

      // showToast(value.message.toString());
    });
  }


  Future getMyCategory({categoryId, userId}) async {
    getSingleRepo(category_id: categoryId, userId: userId).then((value) {
      single.value = value;
      print("dfsdfsfsfsfdsf");
      refreshData1.value = DateTime.now().millisecond;
      if (value.status == true) {
        statusOfSingle.value = RxStatus.success();
        check = true;
      } else {
        statusOfSingle.value = RxStatus.error();
      }
    }).catchError((e){
      throw Exception(e);
    });
  }

  Future getSingleData({categoryId, userId}) async {
    getSingleRepoWithOut(category_id: categoryId, userId: userId).then((value) {
      single.value = value;
      refreshData1.value = DateTime.now().millisecond;
      if (value.status == true) {
        statusOfSingle.value = RxStatus.success();
        check = true;
      } else {
        statusOfSingle.value = RxStatus.error();
      }
    });
    //
  }

  Future getUserCategory({categoryId,userId}) async{
    getSingleRepo(
        category_id: categoryId,
        userId:  userId
    )
        .then((value) {
      single.value = value;
      refreshUserCat.value = DateTime.now().millisecond;
      if (value.status == true) {
        statusOfSingle.value = RxStatus.success();
        checkForUser = true;
      } else {
        statusOfSingle.value = RxStatus.error();
      }
    });
  }



  Rx<ModelDeleteRecomm> deleteRecommendation = ModelDeleteRecomm().obs;
  Rx<RxStatus> statusOfDelete = RxStatus.empty().obs;








  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
    selectedValue;
  }
}
