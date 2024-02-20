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
import 'package:path_provider/path_provider.dart';

import '../controller/homeController.dart';
import '../controller/profile_controller.dart';
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

class AddRecommendationScreen extends StatefulWidget {
  const AddRecommendationScreen({super.key});

  @override
  State<AddRecommendationScreen> createState() => _AddRecommendationScreenState();
}

class _AddRecommendationScreenState extends State<AddRecommendationScreen> {
  TextEditingController recommendationController = TextEditingController();
  TextEditingController reviewController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  Rx<RxStatus> statusOfHome = RxStatus.empty().obs;

  Future<http.Response>? _imageResponse;
  String _imageUrl = '';
  String imageUrlApi = '';

  Future<File?> _fetchAndSaveImage(String url) async {
    try {
      // Fetch image
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Get the documents directory for the app
        final directory = await getApplicationDocumentsDirectory();

        // Get the file name from the URL
        final uri = Uri.parse(url);
        final fileName = uri.pathSegments.last;

        // Save the image to a file in the app's documents directory
        final file = File('${directory.path}/$fileName');
        await file.writeAsBytes(response.bodyBytes);

        // Return the saved file
        return file;
      } else {
        print("Failed to download image. Status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error downloading image: $e");
      return null;
    }
  }

  void _fetchImage(String url) async {
    if (url.isNotEmpty) {
      try {
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

            // Download the image and get the File
            final imageFile = await _fetchAndSaveImage(imageUrl!);

            if (imageFile != null) {
              setState(() {
                imageUrlApi = imageFile.path;
              });
              print("Image saved to: ${imageFile.path}");
            } else {
              setState(() {
                _imageUrl = "Failed to download and save image";
              });
            }
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
      } catch (e) {
        setState(() {
          _imageUrl = "Error: $e";
        });
      }
    }
  }

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

  final homeController = Get.put(HomeController());
  @override
  void initState() {
    super.initState();
    profileController.idController.clear();
    profileController.categoriesController.clear();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    log(categoryFile.path.toString());
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child:

      Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 35,
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
                  style: GoogleFonts.mulish(fontWeight: FontWeight.w700, fontSize: 13, color: Colors.black),
                ),
                const SizedBox(
                  height: 12,
                ),
                CommonTextfield(controller: recommendationController, obSecure: false, hintText: "I recommend..."),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Review",
                  style: GoogleFonts.mulish(fontWeight: FontWeight.w700, fontSize: 13, color: AppTheme.onboardingColor),
                ),
                const SizedBox(
                  height: 12,
                ),
                CommonTextfield(
                    isMulti: true,
                    controller: reviewController,
                    obSecure: false,
                    hintText: "I recommend this because…"),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Product Online link",
                  style: GoogleFonts.mulish(fontWeight: FontWeight.w700, fontSize: 13, color: AppTheme.onboardingColor),
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
                  style: GoogleFonts.mulish(fontWeight: FontWeight.w700, fontSize: 13, color: AppTheme.onboardingColor),
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
                Text(
                  "Photo Inspiration/Direction",
                  style: GoogleFonts.mulish(fontWeight: FontWeight.w700, fontSize: 13, color: AppTheme.onboardingColor),
                ),
                const SizedBox(
                  height: 12,
                ),
                Stack(
                  children: [
                    GestureDetector(
                      onTap: (){
                        _showActionSheet(context);
                      },
                      child: _imageUrl.isNotEmpty
                          ? GestureDetector(
                          onTap: (){
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
                                errorBuilder: (_, __, ___) => Image.network(_imageUrl,
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
                                          errorBuilder: (_, __, ___) => Image.network(categoryFile.path,
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
                    ),
                    Positioned(
                      top: 15,
                      right: 15,
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
                      // map['image'] = File(categoryFile.path.toString());

                      // map['askrecommandation_id'] = homeController
                      //     .homeModel.value.data!.discover![0].id.toString();

                      addRecommendationRepo(
                        fieldName1: 'image',
                        mapData: map,
                        context: context,
                        file1:  _imageUrl.isNotEmpty ? File(imageUrlApi.toString()) : categoryFile,
                      ).then((value) async {
                        if (value.status == true) {
                          profileController.getData();
                          profileController.UserProfile();
                          homeController.getData();
                          Get.back();
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
                  if(categoryFile.path != ""){
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
                  if(categoryFile.path != ""){
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
