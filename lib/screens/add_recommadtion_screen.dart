import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../controller/profile_controller.dart';
import '../repositories/add_recommendation_repo.dart';
import '../resourses/api_constant.dart';
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
  TextEditingController recommendationController = TextEditingController();
  TextEditingController reviewController = TextEditingController();
  TextEditingController linkController = TextEditingController();

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

  File image = File("");
  final profileController = Get.put(ProfileController());

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
              CommonTextfield(
                  controller: recommendationController,
                  obSecure: false, hintText: "best color for furniture"),
              SizedBox(height: 15,),
              Text("Review",
                style: GoogleFonts.mulish(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppTheme.onboardingColor
                ),),
              SizedBox(height: 12,),
              CommonTextfield(
                  controller: reviewController,
                  obSecure: false, hintText: "Lorem Ipsum is simply dummy text of the printing and "),
              SizedBox(height: 15,),
              Text("Product Online link",
                style: GoogleFonts.mulish(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppTheme.onboardingColor
                ),),
              SizedBox(height: 12,),
              CommonTextfield(
                  controller: linkController,
                  obSecure: false, hintText: "Link"),
              SizedBox(height: 15,),
              Text("Category",
                style: GoogleFonts.mulish(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppTheme.onboardingColor
                ),),
              SizedBox(height: 12,),
              CommonTextfield(
                onTap: (){
                  Get.toNamed(MyRouters.categoriesScreen);
                },
                  controller: profileController.categoriesController,
                  obSecure: false, hintText: "Furniture"),
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
                ),
        ),
    ),
              SizedBox(height: 22,),
              CommonButton(title: "Next",onPressed: (){

                Map map = <String, String>{};
                map['title'] =recommendationController.text.trim();
                map['review'] =reviewController.text.trim();
                map['link'] = linkController.text.trim();
                map['status'] = "publish";
                map['category_id'] = profileController.idController.text.trim();

                addRecommendationRepo(
                  fieldName1: 'image',
                  mapData: map,
                  context: context,
                  file1: image,
                ).then((value) async {
                  if (value.status == true) {
                    Get.toNamed(MyRouters.followingScreen);
                    showToast(value.message.toString());
                  }
                  else{
                    showToast(value.message.toString());
                  }
                });


              },)
            ],
          ),
        ),
      ),
    );
  }
}
