import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  RxString selectedValue = 'friends'.obs;
  final categoriesController = TextEditingController();
  final idController = TextEditingController();

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    selectedValue;
  }
}