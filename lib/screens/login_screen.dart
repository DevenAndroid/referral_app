import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:referral_app/routers/routers.dart';
import 'package:referral_app/widgets/app_text.dart';
import 'package:referral_app/widgets/app_theme.dart';
import 'package:referral_app/widgets/common_textfield.dart';

import '../widgets/custome_textfiled.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                Text("Login Your Account",
                  style: GoogleFonts.mulish(
                      fontWeight: FontWeight.w700,

                      fontSize: 18,
                      color:  Color(0xFF000000)
                  ),),
SizedBox(height: size.height*.07,),
                Text("Enter Phone Number",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,

                      fontSize: 13,
                      color: AppTheme.onboardingColor
                  ),),
SizedBox(height: 10,),
CommonTextfield(obSecure: false, hintText: "9549348495"),
                SizedBox(height: size.height*.07,),
                CommonButton(title: "SEND OTP",onPressed: (){
                  Get.toNamed(MyRouters.otpScreen);
                },),
                SizedBox(height: size.height*.1,),
                Center(
                  child: Text("We will send you a one time SMS massage",
                    style: GoogleFonts.mulish(
                        fontWeight: FontWeight.w400,
                        letterSpacing: 2,
                        fontSize: 14,
                        color:  AppTheme.onboardingColor
                    ),),
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
    );
  }
}
