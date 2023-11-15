import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../routers/routers.dart';
import '../widgets/app_assets.dart';
import '../widgets/app_theme.dart';
import '../widgets/common_textfield.dart';
import '../widgets/custome_textfiled.dart';
class AddRecommendationScreen extends StatefulWidget {
  const AddRecommendationScreen({super.key});

  @override
  State<AddRecommendationScreen> createState() => _AddRecommendationScreenState();
}

class _AddRecommendationScreenState extends State<AddRecommendationScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add Your Recommendation",
                    style: GoogleFonts.mulish(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Color(0xFF3797EF)),
                  ), 
                Icon(Icons.clear)
                ],
              ),
              SizedBox(height: 30,),



              Text("Recommendation",
                style: GoogleFonts.mulish(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppTheme.onboardingColor
                ),),
              SizedBox(height: 12,),
              CommonTextfield(obSecure: false, hintText: "best color for furniture"),
              SizedBox(height: 15,),
              Text("Review",
                style: GoogleFonts.mulish(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppTheme.onboardingColor
                ),),
              SizedBox(height: 12,),
              CommonTextfield(obSecure: false, hintText: "Lorem Ipsum is simply dummy text of the printing and "),
              SizedBox(height: 15,),
              Text("Product Online link",
                style: GoogleFonts.mulish(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppTheme.onboardingColor
                ),),
              SizedBox(height: 12,),
              CommonTextfield(obSecure: false, hintText: "Link"),
              SizedBox(height: 15,),
              Text("Category",
                style: GoogleFonts.mulish(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppTheme.onboardingColor
                ),),
              SizedBox(height: 12,),
              CommonTextfield(obSecure: false, hintText: "Furniture"),
              SizedBox(height: 15,),
    Center(
        child: DottedBorder(
color: AppTheme.secondaryColor,
        borderType: BorderType.RRect,
        radius: Radius.circular(12),
        padding: EdgeInsets.all(6),
        child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: Container(
                    width: size.width*.3,
                    height: size.height*.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),

                    ),
                    child: Image.asset(AppAssets.camera),
                  ),
                ),
        ),
    ),
              SizedBox(height: 22,),
              CommonButton(title: "Next",onPressed: (){
                Get.toNamed(MyRouters.followingScreen);
              },)
            ],
          ),
        ),
      ),
    );
  }
}
