import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:referral_app/screens/select_friends_screen.dart';

import '../controller/bottomNav_controller.dart';
import '../controller/get_friend_controller.dart';
import '../controller/profile_controller.dart';
import '../repositories/add_ask_recommendation_repo.dart';
import '../resourses/api_constant.dart';
import '../routers/routers.dart';
import '../widgets/app_assets.dart';
import '../widgets/app_theme.dart';
import '../widgets/common_textfield.dart';
import '../widgets/custome_textfiled.dart';
import '../widgets/helper.dart';
import '../widgets/recommendation_popup.dart';

class AskRecommendationScreen extends StatefulWidget {
  const AskRecommendationScreen({super.key});

  @override
  State<AskRecommendationScreen> createState() => _AskRecommendationScreenState();
}

class _AskRecommendationScreenState extends State<AskRecommendationScreen> {
  double start = 0.0;
  double end = 100.0;
  File categoryFile = File("");
  final bottomController = Get.put(BottomNavBarController());
  RxBool checkboxColor = false.obs;

  bool value = false;
  bool value2 = false;

  dynamic valueRange = 1;
  int value1 = 1;
  TextEditingController tittleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController maxController = TextEditingController();
  TextEditingController minController = TextEditingController();
  final getFriendListController = Get.put(GetFriendListController(),permanent: true);

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

  final profileController = Get.put(ProfileController());
  File image = File("");

  String? validateValue(String? value, int minValue, int maxValue) {
    if (value == null || value.isEmpty) {
      return 'Please enter a value';
    }
    int? enteredValue = int.tryParse(value);
    if (enteredValue == null || enteredValue < minValue || enteredValue > maxValue) {
      return '';
    }
    return null;
  }

  final int minValue = 0;
  final int maxValue = 100000;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFriendListController.selectedFriendIds;
    getFriendListController.getFriendList();
    getFriendListController.selectedFriendIds.clear();
    //value2 = false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              // physics: AlwaysScrollableScrollPhysics(),
                    child: Form(
            key: formKey,
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(() {
                        return profileController.statusOfProfile.value.isSuccess
                            ? GestureDetector(
                                onTap: () {
                                  bottomController.updateIndexValue(2);
                                },
                                child: SizedBox(
                                  height: 35,
                                  width: 35,
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      imageUrl: profileController.modal.value.data!.user!.profileImage.toString(),
                                      errorWidget: (context, url, error) => Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration:
                                              BoxDecoration(border: Border.all(color: Colors.black), shape: BoxShape.circle),
                                          child: SvgPicture.asset('assets/icons/profile.svg')),
                                    ),
                                  ),
                                ),
                              )
                            : profileController.statusOfProfile.value.isError
                                ? Image.asset(AppAssets.man)
                                : const Center(child: CircularProgressIndicator());
                      }),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        style: GoogleFonts.mulish(fontWeight: FontWeight.w700, fontSize: 18, color: Colors.black),
                        controller: tittleController,
                        decoration: InputDecoration(
                          hintText: "I'm looking for...",
                          hintStyle: GoogleFonts.mulish(fontWeight: FontWeight.w700, fontSize: 18, color: Colors.black54),
                          // Remove the underline and border
                          disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: AppTheme.shadowColor, width: 1.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: AppTheme.shadowColor, width: 1.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: AppTheme.shadowColor, width: 1.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(color: AppTheme.secondaryColor, width: 1.5),
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
            
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        style: GoogleFonts.mulish(   color: Colors.black87,),
                        controller: descriptionController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: AppTheme.shadowColor, width: 1.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: AppTheme.shadowColor, width: 1.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: AppTheme.shadowColor, width: 1.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(color: AppTheme.secondaryColor, width: 1.5),
                              borderRadius: BorderRadius.circular(8)),
                          hintText: 'I\'m looking for a water bottle that fits in my car cupholder and is at least 30 oz',
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,

                            color: AppTheme.textColor,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: (){
                          print('Selected Friend IDs: ${getFriendListController.selectedFriendIds.join(',')}');
                        },
                        child: Text(
                          "Photo Inspiration/Direction",
                          style: GoogleFonts.mulish(
                              fontWeight: FontWeight.w700, fontSize: 15, color: AppTheme.onboardingColor),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
            
                      GestureDetector(
                        onTap: () {
                          _showActionSheet(context);
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        child: Stack(
                          children: [
                            categoryFile.path != ""
                                ? Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.black12),
                                      color: Colors.white,
                                    ),
                                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                    width: double.maxFinite,
                                    height: 180,
                                    alignment: Alignment.center,
                                    child: Image.file(categoryFile,
                                        errorBuilder: (_, __, ___) =>
                                            Image.network(categoryFile.path, errorBuilder: (_, __, ___) => const SizedBox())),
                                  )
                                : Container(
                                    decoration: BoxDecoration(border: Border.all(color: Colors.black12), color: Colors.white),
                                    padding: const EdgeInsets.only(top: 8),
                                    width: double.maxFinite,
                                    height: 130,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
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
                            Positioned(
                              top: 5,
                              right: 5,
                              child: GestureDetector(
                                onTap: () {
                                  _showActionSheet(context);
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: AppTheme.secondaryColor,
                                    shape: BoxShape.circle
                                  ),
                                  padding: EdgeInsets.all(5),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white, // You can change the color
                                    size: 18, // You can change the size
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Tag Your Friends",
                        style: GoogleFonts.mulish(
                            fontWeight: FontWeight.w700, fontSize: 15, color: AppTheme.onboardingColor),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CommonTextfield(
                          onTap: () {
                            Get.toNamed(MyRouters.selectFriendsScreen);
                          },
                          readOnly: true,
                          obSecure: false,
                          hintText: "Tag Friends"),
                      const SizedBox(
                        height: 25,
                      ),
                      value2 == false
                          ?
                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Min Price",
                                            style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          CommonTextfield(
                                            enabled: !value,
                                            keyboardType: TextInputType.number,
                                            controller: minController,
                                            obSecure: false,
                                            hintText: "\$\$\$",
                                            validator: (value) {
                                              return validateValue(value, minValue, maxValue);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 18,),
                                    Expanded(
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Max Price",
                                            style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          CommonTextfield(
                                            enabled: !value,
                                            keyboardType: TextInputType.number,
                                            controller: maxController,
                                            obSecure: false,
                                            hintText: "\$\$\$",
                                            validator: (value) {
                                              return validateValue(value, minValue, maxValue);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
            
                                  ],
                                )
            
                          : const SizedBox(),
            
                      // SliderTheme(
                      //   data: SliderTheme.of(context).copyWith(
                      //     showValueIndicator: ShowValueIndicator.onlyForDiscrete,
                      //     trackHeight: 8,
                      //     trackShape: const RoundedRectSliderTrackShape(),
                      //     activeTrackColor: const Color(0xff3797EF),
                      //     inactiveTrackColor: const Color(0xFF3797EF).withOpacity(
                      //         0.12),
                      //     // thumbShape: const RoundSliderThumbShape(
                      //     //   enabledThumbRadius: 7.0,
                      //     //   pressedElevation: 8.0,
                      //     // ),
                      //     thumbColor: Colors.white,
                      //
                      //     overlayColor: const Color(0xFF3797EF).withOpacity(0.12),
                      //     // overlayShape: const RoundSliderOverlayShape(overlayRadius: 2.0),
                      //     // tickMarkShape: const RoundSliderTickMarkShape(),
                      //
                      //     activeTickMarkColor: const Color(0xff3797EF),
                      //     inactiveTickMarkColor: Colors.transparent,
                      //     // valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                      //     valueIndicatorColor: Colors.white10,
                      //     valueIndicatorTextStyle: const TextStyle(
                      //       color: Colors.black,
                      //       fontSize: 20.0,
                      //     ),
                      //   ),
                      //   child: RangeSlider(
                      //     values: RangeValues(start, end),
                      //     labels: RangeLabels(
                      //         start.round().toString(), end.round().toString()),
                      //     divisions: 10,
                      //     onChanged: (value) {
                      //       setState(() {
                      //         start = value.start;
                      //         end = value.end;
                      //       });
                      //     },
                      //     min: 0.0,
                      //     max: 100.0,
                      //   ),
                      // ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Transform.scale(
                            scale:1.0,
            
            
                            child: Theme(
                              data: ThemeData(
            
            
                                  checkboxTheme: CheckboxThemeData(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                  unselectedWidgetColor:
                                      checkboxColor.value == false ?  Colors.blue :  Colors.blue),
                              child: Checkbox(
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  value: value2,
                                  activeColor: Colors.black,
                                  side: BorderSide(color: Color(0xffC1C1C1)),
                                  visualDensity: VisualDensity.standard,
                                  onChanged: (newValue) {
                                    setState(() {
                                      value2 = newValue!;
                                      checkboxColor.value = !newValue;
                                    });
                                  }),
                            ),
                          ),
                          Text(
                            "No Budget",
                            style: GoogleFonts.mulish(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CommonButton(
                        title: "Post",
                        onPressed: () {
                          /* if (minController.text.length >= maxController.text.length) {
                                  showToast('Min value cannot be grater than Max value');
                                }
                                else{
            
                                }*/
                          if (formKey.currentState!.validate()) {
                            print(getFriendListController.selectedFriendIds);
                            print( getFriendListController.selectedFriendIds.isEmpty ?  'public' : profileController.selectedValue.value);
                            if (minController.text.isNotEmpty && maxController.text.isNotEmpty) {
                              int valueA = int.parse(minController.text);
                              int valueB = int.parse(maxController.text);
                              if (valueA > valueB) {
                                showToast('Min value cannot be grater than Max value');
                              } else {
                                Map map = <String, String>{};
                                map['title'] = tittleController.text.trim();
                                map['description'] = descriptionController.text.trim();
                                map['min_price'] = minController.text.toString();
                                map['max_price'] = maxController.text.toString();
                                map['post_viewers_type'] = getFriendListController.selectedFriendIds.isEmpty ?  'public' : profileController.selectedValue.value;
                                map['tag_id'] =  getFriendListController.selectedFriendIds.join(',');
                                map['no_budget'] = value2 == true ? '1' : '0';
            
                                askRecommendationRepo(
                                  fieldName1: 'image',
                                  mapData: map,
                                  context: context,
                                  file1: categoryFile,
                                ).then((value) async {
                                  if (value.status == true) {
                                    bottomController.updateIndexValue(0);
                                    showToast(value.message.toString());
                                  } else {
                                    // bottomController.updateIndexValue(0);
                                    showToast(value.message.toString());
                                  }
                                });
                              }
                            } else {
                              Map map = <String, String>{};
                              map['title'] = tittleController.text.trim();
                              map['description'] = descriptionController.text.trim();
                              map['min_price'] = minController.text.toString();
                              map['max_price'] = maxController.text.toString();
                              map['post_viewers_type'] = getFriendListController.selectedFriendIds.isEmpty ?  'public' : profileController.selectedValue.value;
                              map['no_budget'] = value2 == true ? '1' : '0';
                              map['tag_id'] =  getFriendListController.selectedFriendIds.join(',');
            
                              askRecommendationRepo(
                                fieldName1: 'image',
                                mapData: map,
                                context: context,
                                file1: categoryFile,
                              ).then((value) async {
                                if (value.status == true) {
                                  bottomController.updateIndexValue(0);
                                  showToast(value.message.toString());
                                } else {
                                  // bottomController.updateIndexValue(0);
                                  showToast(value.message.toString());
                                }
                              });
                            }
                          }
                        },
                      ),
              SizedBox(
              height: 80,
            ),
                      /*             Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Best color for furniture",
                                        style: GoogleFonts.mulish(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                            color: Color(0xFF000000)),
                                      ),
            
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    "Lorem Ipsum is simply dummy text of the \nprinting and typesetting industry. ",
                                    style: GoogleFonts.mulish(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12,
                                        color: Color(0xFF162224)),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    "https://www.amazon.in/Seiko-Analog-Blue-Dial-Watch/dp/B0759VDQHL/ref=sr_1_1? ",
                                    style: GoogleFonts.mulish(
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.underline,
                                        fontSize: 12,
                                        color: AppTheme.secondaryColor),
                                  ),
            
                                  SizedBox(height: 15,),
                                  Image.asset(AppAssets.sofa)*/
                    ])),
                    ),
                  ),
          )),
    );
  }

  showDialogue15(context) {
    showDialog(
        context: context,
        builder: (context) {
          Size size = MediaQuery.of(context).size;
          double doubleVar;
          return RecommendationPopup();
        });
  }

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text(
          'Select Picture from',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              Helper.addImagePicker(imageSource: ImageSource.camera, imageQuality: 75).then((value) async {
                CroppedFile? croppedFile = await ImageCropper().cropImage(
                  sourcePath: value.path,
                  aspectRatioPresets: [
                    CropAspectRatioPreset.ratio4x3,
                  ],
                  aspectRatio: const CropAspectRatio(ratioX: 4, ratioY: 3),
                  uiSettings: [
                    AndroidUiSettings(
                        toolbarTitle: 'Cropper',
                        toolbarColor: Colors.deepOrange,
                        toolbarWidgetColor: Colors.white,
                        initAspectRatio:  CropAspectRatioPreset.ratio4x3,
                        lockAspectRatio: true),
                    IOSUiSettings(
                      title: 'Cropper',
                        aspectRatioLockEnabled: true,
                        rectX: 4,
                        rectY: 3
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
              Helper.addImagePicker(imageSource: ImageSource.gallery, imageQuality: 75).then((value) async {
                CroppedFile? croppedFile = await ImageCropper().cropImage(
                  sourcePath: value.path,
                  aspectRatioPresets: [
                    CropAspectRatioPreset.ratio4x3,
                  ],
                  aspectRatio: const CropAspectRatio(ratioX: 4, ratioY: 3),
                  uiSettings: [
                    AndroidUiSettings(
                        toolbarTitle: 'Cropper',
                        toolbarColor: Colors.deepOrange,
                        toolbarWidgetColor: Colors.white,
                        initAspectRatio: CropAspectRatioPreset.ratio4x3,
                        lockAspectRatio: true),
                    IOSUiSettings(
                      title: 'Cropper',
                        aspectRatioLockEnabled: true,
                        rectX: 4,
                        rectY: 3
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
