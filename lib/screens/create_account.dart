
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:referral_app/routers/routers.dart';
import 'package:referral_app/widgets/app_assets.dart';
import 'package:referral_app/widgets/custome_textfiled.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/profile_controller.dart';
import '../models/Pages_model.dart';
import '../repositories/pages_repo.dart';
import '../repositories/updateProfile_repo.dart';
import '../resourses/api_constant.dart';
import '../resourses/size.dart';
import '../widgets/app_theme.dart';
import '../widgets/common_textfield.dart';
import '../widgets/helper.dart';
class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final formKeyUpdate = GlobalKey<FormState>();
  File categoryFile = File("");
  bool showValidation1 = false;
  bool showValidationImg = false;
  String code = "+91";
  String googleApikey = "AIzaSyDDl-_JOy_bj4MyQhYbKbGkZ0sfpbTZDNU";

  File image = File("");
  RxBool showValidation = false.obs;
  final profileController = Get.put(ProfileController());
  bool checkValidation(bool bool1, bool2) {
    if (bool1 == true && bool2 == true) {
      return true;
    } else {
      return false;
    }
  }
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
      //print('image'+image);
    } on PlatformException catch (e) {
      print('Field to pick img : $e');
    }
  }


  Rx<RxStatus> statusOfSlug = RxStatus.empty().obs;
  Rx<PagesModel> page = PagesModel().obs;
  slug() {
    getPagesRepo(slug: "terms-condition").then((value) {
      page.value = value;

      if (value.status == true) {
        statusOfSlug.value = RxStatus.success();
      } else {
        statusOfSlug.value = RxStatus.error();
      }

      // showToast(value.message.toString());
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    slug();
  }
  RxBool checkboxColor = false.obs;
  bool value = false;
  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title:         Text("Create Account",
            style: GoogleFonts.mulish(
                fontWeight: FontWeight.w700,

                fontSize: 18,
                color:const Color(0xFF262626)
            ),),
          leading:GestureDetector(
            onTap: (){
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: SvgPicture.asset(AppAssets.arrowBack),
            ),
          )
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKeyUpdate,
          child: Column(
              children: [
                const SizedBox(height: 12,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    width: size.width,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(topRight: Radius.circular(15),topLeft:  Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF5F5F5F).withOpacity(0.4),
                          offset: const Offset(0.1, 0.1),
                          blurRadius: 1,),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15,),
                        Text("Upload Profile Photo",
                          style: GoogleFonts.mulish(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: AppTheme.onboardingColor
                          ),),
                        const SizedBox(height: 12,),
                        GestureDetector(
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
                        /*    Container(
                    width: size.width,
                    height: size.height*.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFE4E4E4)),
                    ),
                    child: GestureDetector(
                      onTap: (){
                        _showActionSheet(context);
                      },
                      child: Image.file(
                        categoryFile,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: image.path,
                          height: AddSize.size30,
                          width: AddSize.size30,
                          errorWidget: (_, __, ___) => const Icon(
                            Icons.person,
                            size: 60,
                          ),
                          placeholder: (_, __) => const SizedBox(),
                        ),
                      ),
                    ),




                  ),*/
                        const SizedBox(height: 20,),
                        Text("Full Name",
                          style: GoogleFonts.mulish(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: AppTheme.onboardingColor
                          ),),
                        const SizedBox(height: 12,),
                        CommonTextfield(
                            controller: profileController.nameController,
                            obSecure: false, hintText: "Enter your name"),
                        const SizedBox(height: 20,),
                        Text("Mobile Number",
                          style: GoogleFonts.mulish(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: AppTheme.onboardingColor
                          ),),
                        const SizedBox(height: 12,),

                        IntlPhoneField(
                          flagsButtonPadding: const EdgeInsets.all(8),
                          showDropdownIcon: false,
                          cursorColor: Colors.black,
                            textInputAction: TextInputAction.next,
                          dropdownTextStyle: const TextStyle(color: Colors.white),
                          style: const TextStyle(
                              color: AppTheme.textColor
                          ),

                          controller: profileController.mobileController,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              hintStyle: TextStyle(   color: AppTheme.textColor),
                              hintText: 'Phone Number',
                              labelStyle: TextStyle(   color: AppTheme.textColor),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.shadowColor)),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.shadowColor))),
                          initialCountryCode: 'IN',

                          onChanged: (phone) {
                            code = phone.countryCode.toString();
                          },
                        ),

                        const SizedBox(height: 20,),
                        Text("Email ID",
                          style: GoogleFonts.mulish(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: AppTheme.onboardingColor
                          ),),
                        const SizedBox(height: 12,),
                        CommonTextfield(
                            readOnly: true,
                            controller: profileController.emailController,
                            obSecure: false, hintText: "Enter your Email ID"),
                        // const SizedBox(height: 20,),
                        // Text("Address",
                        //   style: GoogleFonts.mulish(
                        //       fontWeight: FontWeight.w600,
                        //       fontSize: 13,
                        //       color: AppTheme.onboardingColor
                        //   ),),
                        // const SizedBox(height: 12,),
                        // GestureDetector(
                        //     onTap: () async {
                        //       var place = await PlacesAutocomplete.show(
                        //           hint: "Location",
                        //           context: context,
                        //           apiKey: googleApikey,
                        //           mode: Mode.overlay,
                        //           types: [],
                        //           strictbounds: false,
                        //           onError: (err) {
                        //             log("error.....   ${err.errorMessage}");
                        //           });
                        //       if (place != null) {
                        //         setState(() {
                        //           profileController.address = (place.description ?? "Location")
                        //               .toString();
                        //         });
                        //         final plist = GoogleMapsPlaces(
                        //           apiKey: googleApikey,
                        //           apiHeaders: await const GoogleApiHeaders()
                        //               .getHeaders(),
                        //         );
                        //         print(plist);
                        //         String placeid = place.placeId ?? "0";
                        //         final detail =
                        //         await plist.getDetailsByPlaceId(placeid);
                        //         final geometry = detail.result.geometry!;
                        //         final lat = geometry.location.lat;
                        //         final lang = geometry.location.lng;
                        //         setState(() {
                        //           profileController.address = (place.description ?? "Location")
                        //               .toString();
                        //         });
                        //       }
                        //     },
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Container(
                        //             decoration: BoxDecoration(
                        //                 border: Border.all(
                        //                     color: !checkValidation(
                        //                         showValidation.value,
                        //                         profileController.address == "")
                        //                         ? Colors.grey.shade300
                        //                         : Colors.red),
                        //                 borderRadius:
                        //                 BorderRadius.circular(10.0),
                        //                 color: Colors.grey.shade50),
                        //             // width: MediaQuery.of(context).size.width - 40,
                        //             child: ListTile(
                        //               leading: const Icon(Icons.location_on_rounded),
                        //               title: Text(
                        //                 profileController.address ?? "Location".toString(),
                        //                 style: TextStyle(
                        //                     fontSize: AddSize.font14),
                        //               ),
                        //               trailing: const Icon(Icons.search),
                        //               dense: true,
                        //             )),
                        //         checkValidation(
                        //             showValidation.value,   profileController.address == "")
                        //             ? Padding(
                        //           padding: EdgeInsets.only(
                        //               top: AddSize.size5),
                        //           child: Text(
                        //             "      Location is required",
                        //             style: TextStyle(
                        //                 color: Colors.red.shade700,
                        //                 fontSize: AddSize.font12),
                        //           ),
                        //         )
                        //             : const SizedBox()
                        //       ],
                        //     )),
                        // CommonTextfield(
                        //
                        //     controller: profileController.addressController,
                        //
                        //     obSecure: false, hintText: "Enter your Address"),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            Transform.scale(
                              scale: 1.0,
                              child: Theme(
                                data: ThemeData(
                                    checkboxTheme: CheckboxThemeData(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    unselectedWidgetColor: checkboxColor.value == false
                                        ? const Color(0xFF64646F)
                                        : const Color(0xFF64646F)
                                ),
                                child: Checkbox(
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    value: value,
                                    activeColor: AppTheme.primaryColor,
                                    onChanged: (newValue) {
                                      setState(() {
                                        value = newValue!;
                                        showValidation.value = newValue;
                                        checkboxColor.value = newValue;
                                      });
                                    }),
                              ),
                            ),
                            Expanded(
                                child: RichText(
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.end,
                                  textDirection: TextDirection.rtl,
                                  softWrap: true,
                                  text: TextSpan(
                                    text: 'Yes I understand and agree to the ',
                                    style: const TextStyle(color: Colors.black),
                                    children: <TextSpan>[
                                      TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  // Return the dialog box widget
                                                  return  statusOfSlug.value.isSuccess?

                                                  AlertDialog(
                                                    title:
                                                    Text(page.value.data!.title.toString()),
                                                    content: Html(
                                                      data:page.value.data!.content.toString(),
                                                    ),
                                                    actions: <Widget>[],
                                                  ):const CircularProgressIndicator();
                                                },
                                              );
                                            },
                                          text: 'Terms And Conditions',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.red)),
                                    ],
                                  ),
                                )),
                          ],
                        ),

                        const SizedBox(height: 26,),
                        CommonButton(title: "Create Account",onPressed: (){
                          print('value is${showValidation.value}');
                          if (formKeyUpdate.currentState!.validate() && showValidation.value == true) {
                            Map map = <String, String>{};
                            map['name'] = profileController.nameController.text.trim();
                            map['phone'] = profileController.mobileController.text.trim();
                            map['email'] = profileController.emailController.text.trim();
                            map['address'] = profileController.addressController.text.trim();

                            UpdateProfileRepo(
                              fieldName1: 'profile_image',
                              mapData: map,
                              context: context,
                              file1: categoryFile,
                            ).then((value) async {
                              if (value.status == true) {
                                if(value.data!.isComplete ==true) {
                                  SharedPreferences pref = await SharedPreferences.getInstance();
                                  pref.setBool('complete', true);
                                }
                                Get.toNamed(MyRouters.thankYouScreen);
                              }
                              showToast(value.message.toString());
                            });

                            // Get.toNamed(MyRouters.doctorNavbar);
                          }
                          else if(showValidation.value == false){
                            showToastError('Please Select Terms & Conditions');
                            setState(() {
                            });
                          }
                          else{
                            showValidation.value = true;
                          }


                        },)
                      ],
                    ),
                  ),
                ),

              ] ),
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


