import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../controller/bottomNav_controller.dart';
import '../controller/get_friend_controller.dart';
import '../controller/profile_controller.dart';
import '../models/get_profile_model.dart';
import '../models/get_single_request_model.dart';
import '../repositories/add_ask_recommendation_repo.dart';
import '../repositories/get_profile_repo.dart';
import '../repositories/get_single_request_repo.dart';
import '../resourses/api_constant.dart';
import '../routers/routers.dart';
import '../widgets/app_assets.dart';
import '../widgets/app_theme.dart';
import '../widgets/common_textfield.dart';
import '../widgets/custome_textfiled.dart';
import '../widgets/helper.dart';
import '../widgets/recommendation_popup.dart';

class UpdateMyRequestScreen extends StatefulWidget {
  const UpdateMyRequestScreen({super.key});

  @override
  State<UpdateMyRequestScreen> createState() => _UpdateMyRequestScreenState();
}

class _UpdateMyRequestScreenState extends State<UpdateMyRequestScreen> {
  double start = 0.0;
  double end = 100.0;
  File categoryFile = File("");
  final bottomController = Get.put(BottomNavBarController());
  RxBool checkboxColor = false.obs;

  bool value = false;
  bool value2 = false;
  var id = Get.arguments[0];
  dynamic valueRange = 1;
  int value1 = 1;
  TextEditingController tittleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController maxController = TextEditingController();
  TextEditingController minController = TextEditingController();

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
  final getFriendListController = Get.put(GetFriendListController());
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
  Rx<GetSingleRequestModel> getMyRequestModel = GetSingleRequestModel().obs;
  Rx<RxStatus> statusOfGetRequest = RxStatus.empty().obs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('asdsdasdasdasdasdas${id.toString()}');
    profileController.getData();
    getFriendListController.selectedFriendIds;
    getFriendListController.getFriendList();
    UserProfile();
    //value2 = false;
  }

  UserProfile() {
    getMyRequestEditRepo(recommandationId: id.toString()).then((value) {
      getMyRequestModel.value = value;
      if (value.status == true) {
        for(var element in getMyRequestModel.value.data!.tagFriends!){
           getFriendListController.tagId.add(element.userId
           );
           print("Tag ids >${ getFriendListController.tagId}");
      }
        statusOfGetRequest.value = RxStatus.success();
        tittleController.text = getMyRequestModel.value.data!.askRecommandation!.title.toString();
        descriptionController.text = getMyRequestModel.value.data!.askRecommandation!.description.toString();
        maxController.text = getMyRequestModel.value.data!.askRecommandation!.maxPrice.toString();
        minController.text = getMyRequestModel.value.data!.askRecommandation!.minPrice.toString();
        if(getMyRequestModel.value.data!.askRecommandation!.maxPrice!.isEmpty && getMyRequestModel.value.data!.askRecommandation!.minPrice!.isEmpty){
            value2 = true;
            print('object${value2.toString()}');
        }
       else if(value2 == true){
          print('object${value2.toString()}');
          maxController.text = '';
          minController.text = '';
        }
      } else {
        statusOfGetRequest.value = RxStatus.error();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
          body: SafeArea(
            child: Obx(() {
              return statusOfGetRequest.value.isSuccess ?
                SingleChildScrollView(
                // physics: AlwaysScrollableScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: const Icon(Icons.arrow_back)),
                            const SizedBox(
                              height: 20,
                            ),
                            Obx(() {
                              return profileController.statusOfProfile.value.isSuccess
                                  ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    height: 30,
                                    width: 30,
                                    fit: BoxFit.fill,
                                    imageUrl: profileController.modal.value.data!.user!.profileImage.toString(),
                                    placeholder: (context, url) =>
                                        Padding(
                                          padding: const EdgeInsets.only(left: 12.0),
                                          child: Image.asset(AppAssets.man),
                                        ),
                                    errorWidget: (context, url, error) =>
                                        Padding(
                                          padding: const EdgeInsets.only(left: 12.0),
                                          child: Image.asset(AppAssets.man),
                                        ),
                                  ),
                                ),
                              )
                                  : profileController.statusOfProfile.value.isError
                                  ? Image.asset(AppAssets.man)
                                  : const Center(child: CircularProgressIndicator());
                            }),

                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              style: GoogleFonts.mulish(fontWeight: FontWeight.w700, fontSize: 18, color: Colors.black),
                              controller: tittleController,
                              decoration: InputDecoration(
                                hintText: "I'm looking for...",
                                hintStyle: GoogleFonts.mulish(
                                    fontWeight: FontWeight.w700, fontSize: 18, color: Colors.black),
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
                              style: GoogleFonts.mulish(
                                  fontWeight: FontWeight.w300, fontSize: 12, color: const Color(0xFF162224)),
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
                                hintText: 'I m looking for a water bottle that fits in my car cupholder and is at least 30 oz',
                                hintStyle: GoogleFonts.mulish(
                                    fontWeight: FontWeight.w300, fontSize: 12, color: Color(0xFF162224)),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Photo Inspiration/Direction",
                              style:
                              GoogleFonts.mulish(fontWeight: FontWeight.w700, fontSize: 15, color: AppTheme.onboardingColor),
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
                                  categoryFile.path == ""
                                      ? Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.black12),
                                      color: Colors.white,
                                    ),
                                    // margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                    width: double.maxFinite,
                                    height: 180,
                                    alignment: Alignment.center,
                                    child: CachedNetworkImage(
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                      imageUrl: getMyRequestModel.value.data!.askRecommandation!.image.toString(),
                                      placeholder: (context, url) => const SizedBox(),
                                      errorWidget: (context, url, error) => Image.asset(
                                        AppAssets.camera,
                                        height: 60,
                                        width: 50,
                                      ),
                                    ),
                                    // Image.file(categoryFile,
                                    //     errorBuilder: (_, __, ___) =>
                                    //         Image.network(categoryFile.path, errorBuilder: (_, __, ___) => const SizedBox())),
                                  )
                                      : Container(
                                    decoration: BoxDecoration(border: Border.all(color: Colors.black12), color: Colors.white),
                                    padding: const EdgeInsets.only(top: 8),
                                    width: double.maxFinite,
                                    // height: 130,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                          categoryFile.path == "" ? Image.asset(
                                            AppAssets.camera,
                                            height: 60,
                                            width: 50,
                                          ) : Image.file(categoryFile,
                                          // width: 120,
                                          height: 120,
                                          fit: BoxFit.cover,
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
                                  Get.toNamed(MyRouters.selectFriendsScreen,);
                                },
                                readOnly: true,
                                obSecure: false,
                                hintText: "Tag Friends"),
                            const SizedBox(
                              height: 30,
                            ),
                            value2 == false
                                ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                SizedBox(
                                  width: 18,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 1.0,
                                  child: Theme(
                                    data: ThemeData(
                                        checkboxTheme: CheckboxThemeData(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(3),
                                          ),
                                        ),
                                        unselectedWidgetColor: checkboxColor.value == false ? Colors.blue : Colors.blue),
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
                                            print('valrtret${value2}');
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
                            const SizedBox(
                              height: 30,
                            ),
                            CommonButton(
                              title: "Update",
                              onPressed: () {
                                print('idd......${id.toString()}');
                                if (formKey.currentState!.validate()) {
                                  if(value2 == true){
                                    minController.text = '';
                                    maxController.text = '';
                                  }
                                  if (minController.text.isNotEmpty && maxController.text.isNotEmpty) {
                                    int valueA = int.parse(minController.text);
                                    int valueB = int.parse(maxController.text);
                                    if (valueA > valueB) {
                                      showToast('Min value cannot be grater than Max value');
                                    }
                                    else {
                                      Map map = <String, String>{};
                                      map['title'] = tittleController.text.trim();
                                      map['description'] = descriptionController.text.trim();
                                      map['min_price'] = minController.text.toString();
                                      map['max_price'] = maxController.text.toString();
                                      map['post_viewers_type'] = getFriendListController.selectedFriendIds.isEmpty ?  'public' : profileController.selectedValue.value;
                                      map['tag_id'] =  getFriendListController.selectedFriendIds.join(',');
                                      map['no_budget'] = value2 == true ? '1' : '0';
                                      map['id'] = id.toString();

                                      askRecommendationRepo(
                                        fieldName1: 'image',
                                        mapData: map,
                                        context: context,
                                        file1: categoryFile,
                                      ).then((value) async {
                                        if (value.status == true) {
                                          UserProfile();
                                           profileController.getData();
                                           getFriendListController.getFriendList();
                                           Get.back();
                                          showToast(value.message.toString());
                                        } else {
                                          showToast(value.message.toString());
                                        }
                                      });
                                    }
                                  }
                                  else {
                                    Map map = <String, String>{};
                                    map['title'] = tittleController.text.trim();
                                    map['description'] = descriptionController.text.trim();
                                    map['min_price'] = minController.text.toString();
                                    map['max_price'] = maxController.text.toString();
                                    map['post_viewers_type'] = getFriendListController.selectedFriendIds.isEmpty ?  'public' : profileController.selectedValue.value;
                                    map['tag_id'] =  getFriendListController.selectedFriendIds.join(',');
                                    map['no_budget'] = value2 == true ? '1' : '0';
                                    map['id'] = id.toString();

                                    askRecommendationRepo(
                                      fieldName1: 'image',
                                      mapData: map,
                                      context: context,
                                      file1: categoryFile,
                                    ).then((value) async {
                                      if (value.status == true) {
                                        UserProfile();
                                        profileController.getData();
                                        getFriendListController.getFriendList();
                                        Get.back();
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
                            const SizedBox(
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
              ) : const Center(child: CircularProgressIndicator());
            }),
          )),
    );
  }

  showDialogue15(context) {
    showDialog(
        context: context,
        builder: (context) {
          Size size = MediaQuery
              .of(context)
              .size;
          double doubleVar;
          return RecommendationPopup();
        });
  }

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) =>
          CupertinoActionSheet(
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
