import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/all_recommendation_model.dart';
import '../models/get_profile_model.dart';
import '../models/single_product_model.dart';
import '../repositories/all_recommendation_repo.dart';
import '../repositories/get_profile_repo.dart';
import '../repositories/single_produc_repo.dart';
import '../widgets/helper.dart';

class ProfileController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  RxString selectedValue = 'Public'.obs;
  bool check = false;
  final categoriesController = TextEditingController();
  final idController = TextEditingController();
  var profileDrawer = 0;
  Rx<GetProfileModel> modal = GetProfileModel().obs;
  Rx<RxStatus> statusOfProfile = RxStatus.empty().obs;
  Rx<SingleProduct> single = SingleProduct().obs;
  Rx<RxStatus> statusOfSingle = RxStatus.empty().obs;
  String? address = "";
  Rx<RxStatus> statusOfAllRecommendation = RxStatus.empty().obs;
  Rx<AllRecommendationModel> allRecommendation = AllRecommendationModel().obs;

  getData() {
    getProfileRepo().then((value) async {
      modal.value = value;
      if (value.status == true) {
        emailController.text = modal.value.data!.user!.email.toString();
        mobileController.text = modal.value.data!.user!.phone.toString();
        address = modal.value.data!.user!.address.toString();
        nameController.text = modal.value.data!.user!.name.toString();

        statusOfProfile.value = RxStatus.success();

        // holder();
      } else {
        statusOfProfile.value = RxStatus.error();
      }

      print(value.message.toString());
    });
  }

  RxInt refreshData = 0.obs;
  String categoryId = '';
  String userId = '';
  Future getSingleData({categoryId,userId}) async {
      getSingleRepoWithOut(
          category_id: categoryId,
          userId: userId
      ).then((value) {
        single.value = value;
        refreshData.value = DateTime.now().millisecond;
        if (value.status == true) {
          statusOfSingle.value = RxStatus.success();
          check = true;
        } else {
          statusOfSingle.value = RxStatus.error();
        }
      });
    //

  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
    selectedValue;
  }
}
