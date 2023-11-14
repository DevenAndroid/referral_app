import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:referral_app/routers/routers.dart';


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
        child: Column(
          children: [
            SizedBox(
              height: size.height,
              child: Stack(
                  children:[ Container(
                    height: size.height*.4,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 90,),
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
                        padding: EdgeInsets.all(12),
                        width: size.width,
                        height: size.height,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft:  Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF5F5F5F).withOpacity(0.4),
                              offset: Offset(0.0, 0.5),
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
                                  color:  Color(0xFF000000)
                              ),),
                            SizedBox(height: size.height*.07,),

                            SizedBox(height: 10,),
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
                            SizedBox(height: 30,),
                            Center(
                              child: Text("Didn't you receive the OTP?",
                                style: GoogleFonts.mulish(
                                    fontWeight: FontWeight.w400,

                                    fontSize: 16,
                                    color:  Color(0xFF3D4260)
                                ),),
                            ),
                            SizedBox(height: 10,),
                            Center(
                              child: Text(" Resend OTP",
                                style: GoogleFonts.mulish(
                                    fontWeight: FontWeight.w700,

                                    fontSize: 16,
                                    color: AppTheme.primaryColor
                                ),),
                            ),
                            SizedBox(height: size.height*.07,),
                             CommonButton(title: "VERIFY OTP",onPressed: (){
                             Get.toNamed(MyRouters.createAccountScreen);
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
    );
  }
}
