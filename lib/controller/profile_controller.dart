import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/get_profile_model.dart';
import '../repositories/get_profile_repo.dart';

class ProfileController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  RxString selectedValue = 'Public'.obs;
  final categoriesController = TextEditingController();
  final idController = TextEditingController();
  var profileDrawer = 0;

  Rx<GetProfileModel> modal = GetProfileModel().obs;
  Rx<RxStatus> statusOfProfile = RxStatus.empty().obs;
  String? address = "";

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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
    selectedValue;
  }
}
