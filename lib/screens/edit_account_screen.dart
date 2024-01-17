import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/profile_controller.dart';
import '../models/delete_user_model.dart';
import '../models/get_profile_model.dart';
import '../models/logout_Model.dart';
import '../repositories/delete_user_repo.dart';
import '../repositories/logout_repo.dart';
import '../repositories/updateProfile_repo.dart';
import '../resourses/api_constant.dart';
import '../resourses/size.dart';
import '../routers/routers.dart';
import '../widgets/app_assets.dart';
import '../widgets/app_theme.dart';
import '../widgets/common_error_widget.dart';
import '../widgets/common_textfield.dart';
import '../widgets/custome_textfiled.dart';
import '../widgets/helper.dart';
class EditAccount extends StatefulWidget {
  const EditAccount({super.key});

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {


  Rx<LogoutModel> logout = LogoutModel().obs;
  Rx<DeleteUserModel> deleteUserModel = DeleteUserModel().obs;
  Rx<RxStatus> statusOfLogout = RxStatus.empty().obs;
  String? address = "";

  getLogout() {
    getLogoutRepo().then((value) async {
      logout.value = value;
      if (value.status == true) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.clear();
        statusOfLogout.value = RxStatus.success();
        Get.offAllNamed(MyRouters.loginScreen);

        // holder();
      } else {
        statusOfLogout.value = RxStatus.error();
      }

      print('logout response${value.message.toString()}');
    });
  }
  deleteUserApi() {
    deleteUserRepo().then((value) async {
      deleteUserModel.value = value;
      if (value.status == true) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.clear();
        showToastError(value.message.toString());
        statusOfLogout.value = RxStatus.success();
        profileController.modal.value = GetProfileModel();
        profileController.statusOfProfile.value = RxStatus.empty();
        profileController.emailController.text = '';
        profileController.mobileController.text = '';
        profileController.address = '';
        profileController.nameController.text = '';
        profileController.code = '';
        Get.offAllNamed(MyRouters.loginScreen);

        // holder();
      } else {
        statusOfLogout.value = RxStatus.error();
      }

      print('logout response${value.message.toString()}');
    });
  }

  File image = File("");
  File categoryFile = File("");
  String googleApikey = "AIzaSyDDl-_JOy_bj4MyQhYbKbGkZ0sfpbTZDNU";

  bool checkValidation(bool bool1, bool2) {
    if (bool1 == true && bool2 == true) {
      return true;
    } else {
      return false;
    }
  }
  RxBool showValidation = false.obs;
  final profileController = Get.put(ProfileController());
  final formKey = GlobalKey<FormState>();
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
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(

          backgroundColor:const Color(0xffEAEEF1),
          appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title:         Text("Edit Account",
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
              child: Obx(() {
                return  profileController.statusOfProfile.value.isSuccess?

                Form(
                  key: formKey,
                  child: Column(
                      children: [
                        const SizedBox(height: 12,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            width: size.width,

                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft:  Radius.circular(15)),
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: const Color(0xFF5F5F5F).withOpacity(0.4),
                              //     offset: const Offset(0.1, 0.1),
                              //     blurRadius: 1,),
                              // ],
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
                                      ? Stack(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
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
                                      ),
                                    ],
                                  )
                                      : Container(
                                    decoration: BoxDecoration(border: Border.all(color: Colors.black12),color: Colors.white),
                                    padding:
                                    const EdgeInsets.only(
                                        top: 8),
                                    margin: const EdgeInsets
                                        .symmetric(
                                        vertical: 8,
                                        horizontal: 8),
                                    width: double.maxFinite,
                                    height: 130,
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .center,
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: profileController.modal.value.data!.user!.profileImage.toString(),
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.contain,
                                          errorWidget: (context, url, error) => const Icon(Icons.error,color: Colors.red,),
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

                                  obSecure: false, hintText: "Enter your name",
                                  autofocus: false,
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
                                    controller: profileController.emailController,
                                    obSecure: false, hintText: "Enter your Email ID",
                                  readOnly: true,
                                ),
                                const SizedBox(height: 20,),
                                Text("Phone",
                                  style: GoogleFonts.mulish(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: AppTheme.onboardingColor
                                  ),),
                                const SizedBox(height: 12,),
                                IntlPhoneField(
                                  key: ValueKey(profileController.code),
                                  flagsButtonPadding: const EdgeInsets.all(8),
                                  showDropdownIcon: false,
                                  cursorColor: Colors.black,

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
                                  initialCountryCode:  profileController.code,
                                  onChanged: (phone) {
                                    profileController.code = phone.countryISOCode.toString();
                                    print(profileController.code.toString());
                                  },
                                ),
                                const SizedBox(height: 20,),
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
                                //               leading: Icon(Icons.location_on_rounded),
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
                                //             : SizedBox()
                                //       ],
                                //     )),

                                const SizedBox(height: 26,),
                                CommonButton(title: "Update Account",onPressed: (){
                                  FocusManager.instance.primaryFocus!.unfocus();
                                  Map map = <String, String>{};
                                  map['name'] = profileController.nameController.text.trim();
                                  map['phone'] = profileController.mobileController.text.trim();
                                  map['email'] = profileController.emailController.text.trim();
                                  map['country_code'] = profileController.code.toString();
                                  // map['address'] =   profileController.address;
                                  if(formKey.currentState!.validate()){
                                    UpdateProfileRepo(
                                      fieldName1: 'profile_image',
                                      mapData: map,
                                      context: context,
                                      file1: categoryFile,
                                    ).then((value) async {
                                      if (value.status == true) {
                                        profileController.getData();
                                        if(value.data!.isComplete ==true) {
                                          SharedPreferences pref = await SharedPreferences.getInstance();
                                          pref.setBool('complete', true);
                                        }
                                        // Get.toNamed(MyRouters.thankYouScreen);
                                      }
                                      showToastBlack(value.message.toString());
                                    });
                                  }

                                },),
                                const SizedBox(height: 16,),
                                CommonButton(title: "Logout",onPressed: () async {
                                  // SharedPreferences prefs = await SharedPreferences.getInstance();
                                  // await prefs.clear();
                                  // Get.toNamed(MyRouters.loginScreen);
                                 getLogout();
                                      }
                                ),
                                const SizedBox(height: 16,),
                                CommonButtonRed(title: "Delete Account",onPressed: () async {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                      title: const Text('Delete Account'),
                                      content: const Text('Do You Want To Delete Your Account'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => Get.back(),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () =>  deleteUserApi(),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                )



                                // )
                              ],
                            ),
                          ),
                        ),
                      ] ),
                )
                    : profileController.statusOfProfile.value.isError
                    ? CommonErrorWidget(
                  errorText: "",
                  onTap: () {},
                )
                    : const Center(
                    child: Center(child: CircularProgressIndicator()));
              })
          )),
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
