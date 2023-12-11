import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:referral_app/routers/routers.dart';
import 'package:referral_app/widgets/app_text.dart';
import 'package:referral_app/widgets/app_theme.dart';
import 'package:referral_app/widgets/common_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/profile_controller.dart';
import '../models/login_model.dart';
import '../repositories/login_repo.dart';
import '../resourses/api_constant.dart';
import '../widgets/custome_textfiled.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Rx<RxStatus> statusOflogin = RxStatus.empty().obs;
  Rx<LoginModel> login = LoginModel().obs;
  final profileController = Get.put(ProfileController());
  final formKey6 = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  loginApi(context) {
    if (formKey6.currentState!.validate()) {
      loginRepo(
        context: context,
        email: profileController.emailController.text.trim(),
      ).then((value) async {
        login.value = value;
        if (value.status == true) {
          SharedPreferences pref = await SharedPreferences.getInstance();
          // pref.setString('cookie', value.authToken.toString());
          Get.toNamed(MyRouters.otpScreen,
              arguments: [profileController.emailController.text.trim()]);
          // Get.offAllNamed(MyRouters.bottomNavbar);
          statusOflogin.value = RxStatus.success();
          showToast(value.message.toString());
        } else {
          statusOflogin.value = RxStatus.error();
          showToast(value.message.toString());
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey6,
          child: Column(
            children: [
              SizedBox(
                height: size.height,
                child: Stack(children: [
                  Container(
                    height: size.height * .4,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 90,
                        ),
                        Center(
                        child: Image(image: AssetImage('assets/icons/oginsignuplogo.png'),height: size.height*.08,)
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 220,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      width: size.width,
                      height: size.height,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF5F5F5F).withOpacity(0.4),
                            offset: Offset(0.0, 0.5),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.height * .05,
                          ),
                          Text(
                            "Login Your Account",
                            style: GoogleFonts.mulish(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Color(0xFF000000)),
                          ),
                          SizedBox(
                            height: size.height * .07,
                          ),
                          Text(
                            "Enter Your Email ID",
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                color: AppTheme.onboardingColor),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CommonTextfield(
                              controller: profileController.emailController,
                              validator: (value) {
                                if (profileController
                                    .emailController.text.isEmpty) {
                                  return "Please enter your email";
                                } else if (profileController
                                        .emailController.text
                                        .contains('+') ||
                                    profileController.emailController.text
                                        .contains(' ')) {
                                  return "Email is invalid";
                                } else if (RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(profileController
                                        .emailController.text)) {
                                  return null;
                                } else {
                                  return 'Please type a valid email address';
                                }
                              },
                              obSecure: false,
                              hintText: "info@gmail.com"),
                          SizedBox(
                            height: size.height * .07,
                          ),
                          CommonButton(
                            title: "SEND OTP",
                            onPressed: () {
                              loginApi(context);

                              // Get.toNamed(MyRouters.otpScreen);
                            },
                          ),
                          SizedBox(
                            height: size.height * .1,
                          ),
                          Center(
                            child: Text(
                              "We will send you a one time SMS massage",
                              style: GoogleFonts.mulish(
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 2,
                                  fontSize: 14,
                                  color: AppTheme.onboardingColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
