import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/profile_controller.dart';
import '../repositories/updateProfile_repo.dart';
import '../resourses/api_constant.dart';
import '../resourses/size.dart';
import '../routers/routers.dart';
import '../widgets/app_assets.dart';
import '../widgets/app_theme.dart';
import '../widgets/common_error_widget.dart';
import '../widgets/common_textfield.dart';
import '../widgets/custome_textfiled.dart';
class EditAccount extends StatefulWidget {
  const EditAccount({super.key});

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  File image = File("");
  String code = "+91";
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
    return Scaffold(
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
    leading:InkWell(
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

        Column(
          children: [
            const SizedBox(height: 12,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(12),
                width: size.width,
                height: size.height,
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
                    Container(
                      width: size.width,
                      height: size.height*.15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE4E4E4)),
                      ),
                      child:  InkWell(
                        onTap: () => pickImage(),
                        child: image.path != ""
                            ? Image.file(
                          image,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        )
                            : CachedNetworkImage(
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                              imageUrl: profileController
                                  .modal.value.data!.user!.profileImage
                                  .toString(),
                              placeholder: (context, url) =>
                              const SizedBox(),
                              errorWidget: (context, url, error) =>
                              const SizedBox(),
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

                        obSecure: false, hintText: "Enter your name"),
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
                        obSecure: false, hintText: "Enter your Email ID"),
                    const SizedBox(height: 20,),
                    Text("Phone",
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
                    Text("Address",
                      style: GoogleFonts.mulish(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: AppTheme.onboardingColor
                      ),),
                    const SizedBox(height: 12,),
                    InkWell(
                        onTap: () async {
                          var place = await PlacesAutocomplete.show(
                              hint: "Location",
                              context: context,
                              apiKey: googleApikey,
                              mode: Mode.overlay,
                              types: [],
                              strictbounds: false,
                              onError: (err) {
                                log("error.....   ${err.errorMessage}");
                              });
                          if (place != null) {
                            setState(() {
                              profileController.address = (place.description ?? "Location")
                                  .toString();
                            });
                            final plist = GoogleMapsPlaces(
                              apiKey: googleApikey,
                              apiHeaders: await const GoogleApiHeaders()
                                  .getHeaders(),
                            );
                            print(plist);
                            String placeid = place.placeId ?? "0";
                            final detail =
                            await plist.getDetailsByPlaceId(placeid);
                            final geometry = detail.result.geometry!;
                            final lat = geometry.location.lat;
                            final lang = geometry.location.lng;
                            setState(() {
                              profileController.address = (place.description ?? "Location")
                                  .toString();
                            });
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: !checkValidation(
                                            showValidation.value,
                                            profileController.address == "")
                                            ? Colors.grey.shade300
                                            : Colors.red),
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                    color: Colors.grey.shade50),
                                // width: MediaQuery.of(context).size.width - 40,
                                child: ListTile(
                                  leading: Icon(Icons.location_on_rounded),
                                  title: Text(
                                    profileController.address ?? "Location".toString(),
                                    style: TextStyle(
                                        fontSize: AddSize.font14),
                                  ),
                                  trailing: const Icon(Icons.search),
                                  dense: true,
                                )),
                            checkValidation(
                                showValidation.value,   profileController.address == "")
                                ? Padding(
                              padding: EdgeInsets.only(
                                  top: AddSize.size5),
                              child: Text(
                                "      Location is required",
                                style: TextStyle(
                                    color: Colors.red.shade700,
                                    fontSize: AddSize.font12),
                              ),
                            )
                                : SizedBox()
                          ],
                        )),

                    const SizedBox(height: 26,),
                    CommonButton(title: "Update Account",onPressed: (){
                      Map map = <String, String>{};
                      map['name'] = profileController.nameController.text.trim();
                      map['phone'] = profileController.mobileController.text.trim();
                      map['email'] = profileController.emailController.text.trim();
                      map['address'] =   profileController.address;

                      UpdateProfileRepo(
                        fieldName1: 'profile_image',
                        mapData: map,
                        context: context,
                        file1: image,
                      ).then((value) async {
                        if (value.status == true) {
                          profileController.getData();
                          if(value.data!.isComplete ==true) {
                            SharedPreferences pref = await SharedPreferences.getInstance();
                            pref.setBool('complete', true);
                          }
                          // Get.toNamed(MyRouters.thankYouScreen);
                        }
                        showToast(value.message.toString());
                      });

                    },),
                     SizedBox(height: 26,),
                    CommonButton(title: "Logout",onPressed: () async {

                            SharedPreferences pref = await SharedPreferences.getInstance();
                            pref.clear();
                            Get.toNamed(MyRouters.loginScreen);
                          }
                          // Get.toNamed(MyRouters.thankYouScreen);



                    )
                  ],
                ),
              ),
            ),
          ] )
      : profileController.statusOfProfile.value.isError
      ? CommonErrorWidget(
      errorText: "",
      onTap: () {},
      )
          : const Center(
      child: Center(child: CircularProgressIndicator()));
    })
   ));
  }
}
