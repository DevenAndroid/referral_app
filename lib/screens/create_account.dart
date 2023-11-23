
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:referral_app/routers/routers.dart';
import 'package:referral_app/widgets/app_assets.dart';
import 'package:referral_app/widgets/custome_textfiled.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/profile_controller.dart';
import '../repositories/updateProfile_repo.dart';
import '../resourses/api_constant.dart';
import '../resourses/size.dart';
import '../widgets/app_theme.dart';
import '../widgets/common_textfield.dart';
class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final formKeyUpdate = GlobalKey<FormState>();
  String code = "+91";
  String googleApikey = "AIzaSyDDl-_JOy_bj4MyQhYbKbGkZ0sfpbTZDNU";
  String? _address = "";
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
    } on PlatformException catch (e) {
      print('Field to pick img : $e');
    }
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
              color:Color(0xFF262626)
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
        child: Form(
          key: formKeyUpdate,
          child: Column(
            children: [
              SizedBox(height: 12,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
            padding: EdgeInsets.all(12),
            width: size.width,
             height: size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft:  Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF5F5F5F).withOpacity(0.4),
                  offset: Offset(0.1, 0.1),
                  blurRadius: 1,),
              ],
            ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15,),
                  Text("Upload Profile Photo",
                    style: GoogleFonts.mulish(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: AppTheme.onboardingColor
                    ),),
                  SizedBox(height: 12,),
                  Container(
                    width: size.width,
                    height: size.height*.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xFFE4E4E4)),
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
                  SizedBox(height: 20,),
                  Text("Full Name",
                    style: GoogleFonts.mulish(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: AppTheme.onboardingColor
                    ),),
                  SizedBox(height: 12,),
                  CommonTextfield(
                      controller: profileController.nameController,
                      obSecure: false, hintText: "Enter your name"),
                  SizedBox(height: 20,),
                  Text("Mobile Number",
                    style: GoogleFonts.mulish(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: AppTheme.onboardingColor
                    ),),
                  SizedBox(height: 12,),

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

                  SizedBox(height: 20,),
                  Text("Email ID",
                    style: GoogleFonts.mulish(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: AppTheme.onboardingColor
                    ),),
                  SizedBox(height: 12,),
                  CommonTextfield(
                    readOnly: true,
                      controller: profileController.emailController,
                      obSecure: false, hintText: "Enter your Email ID"),
                  SizedBox(height: 20,),
                  Text("Address",
                    style: GoogleFonts.mulish(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: AppTheme.onboardingColor
                    ),),
                  SizedBox(height: 12,),
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
                            _address = (place.description ?? "Location")
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
                            _address = (place.description ?? "Location")
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
                                          _address == "")
                                          ? Colors.grey.shade300
                                          : Colors.red),
                                  borderRadius:
                                  BorderRadius.circular(10.0),
                                  color: Colors.grey.shade50),
                              // width: MediaQuery.of(context).size.width - 40,
                              child: ListTile(
                                leading: Icon(Icons.location_on_rounded),
                                title: Text(
                                  _address ?? "Location".toString(),
                                  style: TextStyle(
                                      fontSize: AddSize.font14),
                                ),
                                trailing: const Icon(Icons.search),
                                dense: true,
                              )),
                          checkValidation(
                              showValidation.value, _address == "")
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
                  // CommonTextfield(
                  //
                  //     controller: profileController.addressController,
                  //
                  //     obSecure: false, hintText: "Enter your Address"),
                  SizedBox(height: 10,),
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
                                  ? Color(0xFF64646F)
                                  : Color(0xFF64646F)
                          ),
                          child: Checkbox(
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              value: value,
                              activeColor: AppTheme.primaryColor,
                              onChanged: (newValue) {
                                setState(() {
                                  value = newValue!;
                                  checkboxColor.value = !newValue!;
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
                                            return const AlertDialog(
                                              title:
                                              Text('Terms And Conditions'),
                                              content: Text(
                                                  'Terms and conditions are part of a contract that ensure parties understand their contractual rights and obligations. Parties draft them into a legal contract, also called a legal agreement, in accordance with local, state, and federal contract laws. They set important boundaries that all contract principals must uphold.'
                                                      'Several contract types utilize terms and conditions. When there is a formal agreement to create with another individual or entity, consider how you would like to structure your deal and negotiate the terms and conditions with the other side before finalizing anything. This strategy will help foster a sense of importance and inclusion on all sides.'),
                                              actions: <Widget>[],
                                            );
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

                  SizedBox(height: 26,),
                  CommonButton(title: "Create Account",onPressed: (){
                    if (formKeyUpdate.currentState!.validate()) {
                      Map map = <String, String>{};
                      map['name'] = profileController.nameController.text.trim();
                      map['phone'] = profileController.mobileController.text.trim();
                      map['email'] = profileController.emailController.text.trim();
                      map['address'] = profileController.addressController.text.trim();

                      UpdateProfileRepo(
                        fieldName1: 'profile_image',
                        mapData: map,
                        context: context,
                        file1: image,
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
}
