import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../controller/get_recommendation_controller.dart';
import '../controller/homeController.dart';
import '../controller/profile_controller.dart';
import '../models/model_single_user.dart';
import '../models/single_user_repo.dart';
import '../repositories/add_recommendation_repo.dart';
import '../resourses/api_constant.dart';
import '../routers/routers.dart';
import '../widgets/app_assets.dart';
import '../widgets/app_theme.dart';
import '../widgets/common_textfield.dart';
import '../widgets/custome_textfiled.dart';
import '../widgets/helper.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;

class AddRecommendationScreen1 extends StatefulWidget {
  const AddRecommendationScreen1({super.key});

  @override
  State<AddRecommendationScreen1> createState() => _AddRecommendationScreen1State();
}

class _AddRecommendationScreen1State extends State<AddRecommendationScreen1> {
  TextEditingController recommendationController = TextEditingController();
  TextEditingController reviewController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController categoriesController = TextEditingController();
  final getRecommendationController = Get.put(GetRecommendationController());
  Rx<RxStatus> statusOfHome = RxStatus
      .empty()
      .obs;

  Future<http.Response>? _imageResponse;
  String _imageUrl = '';

  void _fetchImage(String url) async {
    if (url.isNotEmpty) {
      // Fetch HTML content of the webpage
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Parse HTML content to extract image URL
        final document = htmlParser.parse(response.body);
        final images = document.getElementsByTagName('img');

        if (images.isNotEmpty) {
          final imageUrl = images[8].attributes['src'];
          setState(() {
            _imageUrl = imageUrl!;
          });
        } else {
          setState(() {
            _imageUrl = "No image found on the webpage";
          });
        }
      } else {
        setState(() {
          _imageUrl = "Failed to fetch webpage content";
        });
      }
    }
  }

  File categoryFile = File("");
  var id = Get.arguments[0];
  var idForask;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserProfile();

    //
    // recommendationController
    // reviewController
    // linkController
    //
  }

  File image = File("");
  final profileController = Get.put(ProfileController());

  final homeController = Get.put(HomeController());
  Rx<ModelSingleUser> single = ModelSingleUser().obs;
  Rx<RxStatus> statusOfUser = RxStatus
      .empty()
      .obs;

  UserProfile() {
    singleUserRepo(recommandation_id: id.toString()).then((value) {
      single.value = value;
      print(id);
      if (value.status == true) {
        recommendationController.text = single.value.data!.recommandation!.title.toString();
        reviewController.text = single.value.data!.recommandation!.review.toString();
        categoryFile = File(single.value.data!.recommandation!.image.toString());
        if( single.value.data!.category!= null) {
          categoriesController.text = single.value.data!.category!.name.toString();
        }
        linkController.text = _imageUrl;
        statusOfUser.value = RxStatus.success();
      } else {
        statusOfUser.value = RxStatus.error();
      }

      // showToast(value.message.toString());
    });
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    log(categoryFile.path.toString());
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child:

      Scaffold(
        body: Obx(() {
          return statusOfUser.value.isSuccess ?
            SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add Your Recommendation",
                        style: GoogleFonts.mulish(fontWeight: FontWeight.w700, fontSize: 16, color: const Color(0xFF3797EF)),
                      ),
                      GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(Icons.clear))
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Recommendation",
                    style: GoogleFonts.mulish(fontWeight: FontWeight.w600, fontSize: 13, color: AppTheme.onboardingColor),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CommonTextfield(
                      controller: recommendationController, obSecure: false, hintText: "best color for furniture"),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Review",
                    style: GoogleFonts.mulish(fontWeight: FontWeight.w600, fontSize: 13, color: AppTheme.onboardingColor),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CommonTextfield(
                      isMulti: true,
                      controller: reviewController,
                      obSecure: false,
                      hintText: "Lorem Ipsum is simply dummy text of the printing and "),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Product Online link",
                    style: GoogleFonts.mulish(fontWeight: FontWeight.w600, fontSize: 13, color: AppTheme.onboardingColor),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CommonTextfield(
                    controller: linkController,
                    obSecure: false,
                    hintText: "Link",
                    onChanged: (url) {
                      setState(() {
                        _fetchImage(url);
                      });
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Category",
                    style: GoogleFonts.mulish(fontWeight: FontWeight.w600, fontSize: 13, color: AppTheme.onboardingColor),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CommonTextfield(
                      onTap: () {
                        Get.toNamed(MyRouters.categoriesScreen);
                      },
                      readOnly: true,
                      controller: profileController.categoriesController,
                      obSecure: false,
                      hintText: "Select category"),
                  const SizedBox(
                    height: 15,
                  ),
                  _imageUrl.isNotEmpty
                      ? GestureDetector(onTap: () {
                    _showActionSheet(context);
                  },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black12),
                          color: Colors.white,
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        width: double.maxFinite,
                        height: 180,
                        alignment: Alignment.center,
                        child: Image.network(_imageUrl,
                            errorBuilder: (_, __, ___) =>
                                Image.network(_imageUrl,
                                    errorBuilder: (_, __, ___) => const SizedBox())),
                      )
                  )
                      : GestureDetector(
                    onTap: () {
                      _showActionSheet(context);
                    },
                    child: categoryFile.path != ""
                        ? Container(
                      padding: const EdgeInsets.all(10),
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
                              Image.network(categoryFile.path,
                                  errorBuilder: (_, __, ___) => const SizedBox())),
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
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  CommonButton(
                      title: "Post",
                      onPressed: () {
                        // getImageUrlFromAmazon("https://www.amazon.com/crocs-Unisex-Classic-Black-Women/dp/B0014C5S7S/?_encoding=UTF8&pd_rd_w=Xibxh&content-id=amzn1.sym.64be5821-f651-4b0b-8dd3-4f9b884f10e5&pf_rd_p=64be5821-f651-4b0b-8dd3-4f9b884f10e5&pf_rd_r=1DD2JN3VYV13DGZPWR52&pd_rd_wg=wjvuL&pd_rd_r=baf78e1f-9861-4b19-8c00-b95400991097&ref_=pd_gw_crs_zg_bs_7141123011");
                        Map map = <String, String>{};
                        map['title'] = recommendationController.text.trim();
                        map['review'] = reviewController.text.trim();
                        map['link'] = linkController.text.trim();
                        map['status'] = "publish";
                        map['category_id'] = profileController.idController.text.trim();
                        map['id'] = id;
                        map['askrecommandation_id'] = getRecommendationController.idForAskReco.toString();

                        addRecommendationRepo(
                          fieldName1: 'image',
                          mapData: map,
                          context: context,
                          file1: categoryFile,
                        ).then((value) async {
                          if (value.status == true) {
                            UserProfile();
                            getRecommendationController.getRecommendation(idForReco: getRecommendationController.idForReco);
                            profileController.getData();
                            Get.back();
                            Get.back();
                            // Get.toNamed(MyRouters.followingScreen);
                            showToast(value.message.toString());
                          } else {
                            showToast(value.message.toString());
                          }
                        }
                        );
                      })
                ],
              ),
            ),
          ) : const Center(child: CircularProgressIndicator());
        }),
      ),
    );
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
                        ),
                        WebUiSettings(
                          context: context,
                        ),
                      ],
                    );
                    if (croppedFile != null) {
                      categoryFile = File(croppedFile.path);
                      if (categoryFile.path != "") {
                        _imageUrl = "";
                      }
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
                        ),
                        WebUiSettings(
                          context: context,
                        ),
                      ],
                    );
                    if (croppedFile != null) {
                      categoryFile = File(croppedFile.path);
                      if (categoryFile.path != "") {
                        _imageUrl = "";
                      }
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