import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../controller/profile_controller.dart';
import '../repositories/add_recommendation_repo.dart';
import '../resourses/api_constant.dart';
import '../routers/routers.dart';
import '../widgets/app_assets.dart';
import '../widgets/app_theme.dart';
import '../widgets/common_textfield.dart';
import '../widgets/custome_textfiled.dart';
import '../widgets/helper.dart';

class AddRecommendationScreen extends StatefulWidget {
  const AddRecommendationScreen({super.key});

  @override
  State<AddRecommendationScreen> createState() =>
      _AddRecommendationScreenState();
}

class _AddRecommendationScreenState extends State<AddRecommendationScreen> {
  TextEditingController recommendationController = TextEditingController();
  TextEditingController reviewController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  File categoryFile = File("");


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
              SizedBox(
                height: 25,
              ),
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
                  GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Icon(Icons.clear))
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Recommendation",
                style: GoogleFonts.mulish(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppTheme.onboardingColor),
              ),
              SizedBox(
                height: 12,
              ),
              CommonTextfield(
                  controller: recommendationController,
                  obSecure: false,
                  hintText: "best color for furniture"),
              SizedBox(
                height: 15,
              ),
              Text(
                "Review",
                style: GoogleFonts.mulish(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppTheme.onboardingColor),
              ),
              SizedBox(
                height: 12,
              ),
              CommonTextfield(
                  isMulti: true,
                  controller: reviewController,
                  obSecure: false,
                  hintText:
                      "Lorem Ipsum is simply dummy text of the printing and "),
              SizedBox(
                height: 15,
              ),
              Text(
                "Product Online link",
                style: GoogleFonts.mulish(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppTheme.onboardingColor),
              ),
              SizedBox(
                height: 12,
              ),
              CommonTextfield(
                  controller: linkController,
                  obSecure: false,
                  hintText: "Link"),
              SizedBox(
                height: 15,
              ),
              Text(
                "Category",
                style: GoogleFonts.mulish(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppTheme.onboardingColor),
              ),
              SizedBox(
                height: 12,
              ),
              CommonTextfield(
                  onTap: () {
                    Get.toNamed(MyRouters.categoriesScreen);
                  },
                  controller: profileController.categoriesController,
                  obSecure: false,
                  hintText: "Furniture"),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  _showActionSheet(context);
                },
                child: categoryFile.path != ""
                    ? Container(
                  padding: EdgeInsets.all(10),
                  decoration:
                  BoxDecoration(
                    borderRadius:
                    BorderRadius
                        .circular(10),
                    border: Border.all(color: Colors.black12),
                    color: Colors.white,

                  ),
                  margin: const EdgeInsets
                      .symmetric(
                      vertical: 10,
                      horizontal: 10),
                  width: double.maxFinite,
                  height: 180,
                  alignment:
                  Alignment.center,
                  child: Image.file(
                      categoryFile,
                      errorBuilder: (_, __, ___) =>
                          Image.network(
                              categoryFile
                                  .path,
                              errorBuilder: (_,
                                  __,
                                  ___) =>
                              const SizedBox())),
                )
                    : Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.black12),color: Colors.white),
                  padding:
                  const EdgeInsets.only(
                      top: 8),


                  width: double.maxFinite,
                  height: 130,

                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .center,
                    children: [
                      Image.asset(
                        AppAssets.camera,
                        height: 60,
                        width: 50,
                      ),
                      const SizedBox(
                        height: 5,
                      ),

                      const SizedBox(
                        height: 11,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 22,
              ),
              CommonButton(
                title: "Next",
                onPressed: () {
                  Map map = <String, String>{};
                  map['title'] = recommendationController.text.trim();
                  map['review'] = reviewController.text.trim();
                  map['link'] = linkController.text.trim();
                  map['status'] = "publish";
                  map['category_id'] =
                      profileController.idController.text.trim();

                  addRecommendationRepo(
                    fieldName1: 'image',
                    mapData: map,
                    context: context,
                    file1: categoryFile,
                  ).then((value) async {
                    if (value.status == true) {
                      Get.back();
                      // Get.toNamed(MyRouters.followingScreen);
                      showToast(value.message.toString());
                    } else {
                      showToast(value.message.toString());
                    }
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text(
          'Select Picture from',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              Helper.addImagePicker(
                  imageSource: ImageSource.camera, imageQuality: 75)
                  .then((value) async {
                CroppedFile? croppedFile = await ImageCropper().cropImage(
                  sourcePath: value.path,
                  aspectRatioPresets: [
                    CropAspectRatioPreset.square,
                    CropAspectRatioPreset.ratio3x2,
                    CropAspectRatioPreset.original,
                    CropAspectRatioPreset.ratio4x3,
                    CropAspectRatioPreset.ratio16x9
                  ],
                  uiSettings: [
                    AndroidUiSettings(
                        toolbarTitle: 'Cropper',
                        toolbarColor: Colors.deepOrange,
                        toolbarWidgetColor: Colors.white,
                        initAspectRatio: CropAspectRatioPreset.original,
                        lockAspectRatio: false),
                    IOSUiSettings(
                      title: 'Cropper',
                    ),
                    WebUiSettings(
                      context: context,
                    ),
                  ],
                );
                if (croppedFile != null) {
                  categoryFile = File(croppedFile.path);
                  setState(() {});
                }

                Get.back();
              });
            },
            child: const Text("Camera"),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Helper.addImagePicker(
                  imageSource: ImageSource.gallery, imageQuality: 75)
                  .then((value) async {
                CroppedFile? croppedFile = await ImageCropper().cropImage(
                  sourcePath: value.path,
                  aspectRatioPresets: [
                    CropAspectRatioPreset.square,
                    CropAspectRatioPreset.ratio3x2,
                    CropAspectRatioPreset.original,
                    CropAspectRatioPreset.ratio4x3,
                    CropAspectRatioPreset.ratio16x9
                  ],
                  uiSettings: [
                    AndroidUiSettings(
                        toolbarTitle: 'Cropper',
                        toolbarColor: Colors.deepOrange,
                        toolbarWidgetColor: Colors.white,
                        initAspectRatio: CropAspectRatioPreset.original,
                        lockAspectRatio: false),
                    IOSUiSettings(
                      title: 'Cropper',
                    ),
                    WebUiSettings(
                      context: context,
                    ),
                  ],
                );
                if (croppedFile != null) {
                  categoryFile = File(croppedFile.path);
                  setState(() {});
                }

                Get.back();
              });
            },
            child: const Text('Gallery'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Get.back();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
