import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../routers/routers.dart';
import '../widgets/app_assets.dart';
import '../widgets/app_theme.dart';
import '../widgets/common_textfield.dart';
import '../widgets/custome_textfiled.dart';
class EditAccount extends StatefulWidget {
  const EditAccount({super.key});

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  @override
  Widget build(BuildContext context) {
     var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title:         Text("Edit Account",
        style: GoogleFonts.mulish(
        fontWeight: FontWeight.w700,

        fontSize: 18,
        color:Color(0xFF262626)
    ),),
    leading:Padding(
    padding: const EdgeInsets.all(14.0),
    child: SvgPicture.asset(AppAssets.arrowBack),
    )
    ),
    body: SingleChildScrollView(
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
                child: Image.asset(AppAssets.camera),
              ),



              SizedBox(height: 20,),
              Text("Full Name",
                style: GoogleFonts.mulish(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppTheme.onboardingColor
                ),),
              SizedBox(height: 12,),
              CommonTextfield(obSecure: false, hintText: "Enter your name"),
              SizedBox(height: 20,),
              Text("Email ID",
                style: GoogleFonts.mulish(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppTheme.onboardingColor
                ),),
              SizedBox(height: 12,),
              CommonTextfield(obSecure: false, hintText: "Enter your Email ID"),
              SizedBox(height: 20,),
              Text("Phone",
                style: GoogleFonts.mulish(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppTheme.onboardingColor
                ),),
              SizedBox(height: 12,),
              CommonTextfield(obSecure: false, hintText: "Enter your Phone"),
              SizedBox(height: 20,),
              Text("Address",
                style: GoogleFonts.mulish(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppTheme.onboardingColor
                ),),
              SizedBox(height: 12,),
              CommonTextfield(obSecure: false, hintText: "Enter your Address"),

              SizedBox(height: 26,),
              CommonButton(title: "Update Account",onPressed: (){
                Get.toNamed(MyRouters.postScreen);
              },)
            ],
          ),
        ),
      ),
   ] )));
  }
}
