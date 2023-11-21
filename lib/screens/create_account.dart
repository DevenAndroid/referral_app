
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:referral_app/routers/routers.dart';
import 'package:referral_app/widgets/app_assets.dart';
import 'package:referral_app/widgets/custome_textfiled.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/profile_controller.dart';
import '../repositories/updateProfile_repo.dart';
import '../resourses/api_constant.dart';
import '../widgets/app_theme.dart';
import '../widgets/common_textfield.dart';
class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final formKeyUpdate = GlobalKey<FormState>();
  File image = File("");
  final profileController = Get.put(ProfileController());

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Field to pick img : $e');
    }
  }
  RxBool checkboxColor = false.obs;
  bool value = false;
  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title:         Text("Create Account",
          style: GoogleFonts.mulish(
              fontWeight: FontWeight.w700,

              fontSize: 18,
              color:Color(0xFF262626)
          ),),
        leading:InkWell(
          onTap: (){
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: SvgPicture.asset(AppAssets.arrowBack),
          ),
        )
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKeyUpdate,
          child: Column(
            children: [
              SizedBox(height: 12,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
            padding: EdgeInsets.all(12),
            width: size.width,
             height: size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft:  Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF5F5F5F).withOpacity(0.4),
                  offset: Offset(0.1, 0.1),
                  blurRadius: 1,),
              ],
            ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15,),
                  Text("Upload Profile Photo",
                    style: GoogleFonts.mulish(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: AppTheme.onboardingColor
                    ),),
                  SizedBox(height: 12,),
                  Container(
                    width: size.width,
                    height: size.height*.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xFFE4E4E4)),
                    ),
                    child: InkWell(
                      onTap: () => pickImage(),
                      child: image.path != ""
                          ? Image.file(
                            image,
                            width: 120,
                            height: 120,
                            fit: BoxFit.contain,
                          )
                          : Image.asset(AppAssets.camera),
                    ),




                  ),
                  SizedBox(height: 20,),
                  Text("Full Name",
                    style: GoogleFonts.mulish(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: AppTheme.onboardingColor
                    ),),
                  SizedBox(height: 12,),
                  CommonTextfield(
                      controller: profileController.nameController,
                      obSecure: false, hintText: "Enter your name"),
                  SizedBox(height: 20,),
                  Text("Mobile Number",
                    style: GoogleFonts.mulish(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: AppTheme.onboardingColor
                    ),),
                  SizedBox(height: 12,),
                  CommonTextfield(
                      controller: profileController.mobileController,
                      keyboardType: TextInputType.number,

                      obSecure: false, hintText: "Mobile Number"),
                  SizedBox(height: 20,),
                  Text("Email ID",
                    style: GoogleFonts.mulish(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: AppTheme.onboardingColor
                    ),),
                  SizedBox(height: 12,),
                  CommonTextfield(
                      controller: profileController.emailController,
                      obSecure: false, hintText: "Enter your Email ID"),
                  SizedBox(height: 20,),
                  Text("Address",
                    style: GoogleFonts.mulish(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: AppTheme.onboardingColor
                    ),),
                  SizedBox(height: 12,),
                  CommonTextfield(
                      controller: profileController.addressController,
                      obSecure: false, hintText: "Enter your Address"),
                  Row(
                    children: [
                      Transform.scale(
                        scale: 1.0,
                        child: Theme(
                          data: ThemeData(
                              checkboxTheme: CheckboxThemeData(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              unselectedWidgetColor: checkboxColor.value == false
                                  ? Color(0xFF64646F)
                                  : Color(0xFF64646F)
                          ),
                          child: Checkbox(
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              value: value,
                              activeColor: AppTheme.primaryColor,
                              onChanged: (newValue) {
                                setState(() {
                                  value = newValue!;
                                  checkboxColor.value = !newValue!;
                                });
                              }),
                        ),
                      ),
                      Text(
                          'Are you agree terms and conditions?',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: const Color(0xFF000000))),
                    ],
                  ),
                  SizedBox(height: 26,),
                  CommonButton(title: "Create Account",onPressed: (){
                    if (formKeyUpdate.currentState!.validate()) {
                      Map map = <String, String>{};
                      map['name'] = profileController.nameController.text.trim();
                      map['phone'] = profileController.mobileController.text.trim();
                      map['email'] = profileController.emailController.text.trim();
                      map['address'] = profileController.addressController.text.trim();

                      UpdateProfileRepo(
                        fieldName1: 'profile_image',
                        mapData: map,
                        context: context,
                        file1: image,
                      ).then((value) async {
                        if (value.status == true) {
                          if(value.data!.isComplete ==true) {
                            SharedPreferences pref = await SharedPreferences.getInstance();
                            pref.setBool('complete', true);
                            }
                          Get.toNamed(MyRouters.thankYouScreen);
                        }
                        showToast(value.message.toString());
                      });

                      // Get.toNamed(MyRouters.doctorNavbar);
                    }



                  },)
                ],
              ),
    ),
          ),

     ] ),
        ),
      ),
    );
  }
}
