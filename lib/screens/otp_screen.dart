import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:referral_app/routers/routers.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../models/model_resend_otp.dart';
import '../models/verify_otp_model.dart';
import '../repositories/resend_otp_repo.dart';
import '../repositories/veryOtp_repo.dart';
import '../resourses/api_constant.dart';
import '../widgets/app_text.dart';
import '../widgets/app_theme.dart';
import '../widgets/common_textfield.dart';
import '../widgets/custome_textfiled.dart';
import '../widgets/dimenestion.dart';
class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  RxBool hasError1 = false.obs;
  final TextEditingController otpController = TextEditingController();
  FocusNode focusNode = FocusNode();
  Rx<RxStatus> statusOfOtpVerify = RxStatus.empty().obs;
  Rx<RxStatus> statusOfOtpResend= RxStatus.empty().obs;
  Rx<VerifyOtpModel> otpVerify = VerifyOtpModel().obs;
  Rx<ModelResendOtp> otpResend = ModelResendOtp().obs;
  final formKey6 = GlobalKey<FormState>();
  var email= Get.arguments[0];
  verify(context) async {
    if (formKey6.currentState!.validate()) {
      String? token = await FirebaseMessaging.instance.getToken();
      verifyOtpRepo(
          context: context,
          email:email,
          otp: otpController.text.trim(),
          token : token
      ).then((value) async {
        otpVerify.value = value;
        if (value.status == true) {

          SharedPreferences pref = await SharedPreferences.getInstance();
          if (pref.getBool('complete') == true) {
            Get.offAllNamed(MyRouters.bottomNavbar);
          }
          pref.setString('cookie', value.authToken.toString());
          Get.offAllNamed(MyRouters.createAccountScreen);
          // Get.offAllNamed(MyRouters.bottomNavbar);
          statusOfOtpVerify.value = RxStatus.success();
          showToast(value.message.toString());
        } else {
          statusOfOtpVerify.value = RxStatus.error();
          showToast(value.message.toString());


        }
      }

      );
    }
  }
  resend(context) {
    if (formKey6.currentState!.validate()) {

      resendOtpRepo(
        context: context,
        email:email,

      ).then((value) async {
        otpResend.value = value;
        if (value.status == true) {
          SharedPreferences pref = await SharedPreferences.getInstance();
          // pref.setString('cookie', value.authToken.toString());
          // Get.toNamed(MyRouters.createAccountScreen);
          // Get.offAllNamed(MyRouters.bottomNavbar);
          statusOfOtpResend.value = RxStatus.success();
          showToast(value.message.toString());
        } else {
          statusOfOtpResend.value = RxStatus.error();
          showToast(value.message.toString());


        }
      }

      );
    }
  }
  @override
  void dispose() {
    otpController.dispose();
    focusNode.dispose();
    super.dispose();
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
                child: Stack(
                    children:[ Container(
                      height: size.height*.4,
                      decoration: const BoxDecoration(
                        color: AppTheme.primaryColor,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 90,),
                          Center(
                            child: Text("Social Network",
                              style: GoogleFonts.monomaniacOne(
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 3,
                                  fontSize: 40,
                                  color:  Colors.white
                              ),),
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
                            borderRadius: const BorderRadius.only(topRight: Radius.circular(15),topLeft:  Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF5F5F5F).withOpacity(0.4),
                                offset: const Offset(0.0, 0.5),
                                blurRadius: 5,),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: size.height*.05,),
                              Text("Verification Code",
                                style: GoogleFonts.mulish(
                                    fontWeight: FontWeight.w700,

                                    fontSize: 18,
                                    color:  const Color(0xFF000000)
                                ),),
                              SizedBox(height: size.height*.07,),

                              const SizedBox(height: 10,),
                              PinCodeFields(
                                length: 4,
                                controller: otpController,
                                borderColor: Colors.black12,
                                borderWidth: 3,

                                keyboardType: TextInputType.number,
                                focusNode: focusNode,
                                onComplete: (result) {
                                  // Your logic with code
                                  print(result);
                                },
                              ),
                              const SizedBox(height: 30,),
                              Center(
                                child: Text("Didn't you receive the OTP?",
                                  style: GoogleFonts.mulish(
                                      fontWeight: FontWeight.w400,

                                      fontSize: 16,
                                      color:  const Color(0xFF3D4260)
                                  ),),
                              ),
                              const SizedBox(height: 10,),
                              Center(
                                child: GestureDetector(
                                  onTap: (){
                                    resend(context);
                                  },
                                  child: Text(" Resend OTP",
                                    style: GoogleFonts.mulish(
                                        fontWeight: FontWeight.w700,

                                        fontSize: 16,
                                        color: AppTheme.primaryColor
                                    ),),
                                ),
                              ),
                              SizedBox(height: size.height*.07,),
                              CommonButton(title: "VERIFY OTP",onPressed: (){
                                verify(context);
                                // Get.toNamed(MyRouters.createAccountScreen);
                              },),
                              SizedBox(height: size.height*.1,),

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
