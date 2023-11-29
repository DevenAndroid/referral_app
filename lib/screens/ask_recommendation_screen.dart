import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../controller/profile_controller.dart';
import '../repositories/add_ask_recommendation_repo.dart';
import '../resourses/api_constant.dart';
import '../routers/routers.dart';
import '../widgets/app_assets.dart';
import '../widgets/app_theme.dart';
import '../widgets/common_textfield.dart';
import '../widgets/custome_textfiled.dart';
import '../widgets/recommendation_popup.dart';

class AskRecommendationScreen extends StatefulWidget {
  const AskRecommendationScreen({super.key});

  @override
  State<AskRecommendationScreen> createState() =>
      _AskRecommendationScreenState();
}

class _AskRecommendationScreenState extends State<AskRecommendationScreen> {
  double start = 0.0;
  double end = 100.0;


  dynamic valueRange = 1;
  int value1 = 1;
  TextEditingController tittleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Image.asset(AppAssets.man, height: 30,),
                        SizedBox(width: 13,),
                        Obx(() {
                          return Text(
                            profileController.selectedValue.trim(),
                            style: GoogleFonts.mulish(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.black),
                          );
                        }),
                        SizedBox(width: 15,),
                        InkWell(
                            onTap: () {
                              setState(() {
                                showDialogue15(context);
                              });
                            },
                            child: Icon(Icons.arrow_drop_down)),
                        Spacer(),
                        SizedBox(
                            width: 80,
                            height: 32,
                            child: CommonButton(title: "Post", onPressed: () {
                              Map map = <String, String>{};
                              map['title'] = tittleController.text.trim();
                              map['description'] =
                                  descriptionController.text.trim();
                              map['min_price'] = start.toString();
                              map['max_price'] = end.toString();
                              map['post_viewers_type'] =
                                  profileController.selectedValue.value;

                              askRecommendationRepo(
                                fieldName1: 'image',
                                mapData: map,
                                context: context,
                                file1: image,
                              ).then((value) async {
                                if (value.status == true) {
                                  Get.toNamed(
                                      MyRouters.addRecommendationScreen);
                                  showToast(value.message.toString());
                                }
                                else {
                                  showToast(value.message.toString());
                                }
                              });
                            },))

                      ],

                    ),

                    SizedBox(height: 30,),
                    TextFormField(
                      style: GoogleFonts.mulish(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.black),
                      controller: tittleController,
                      decoration: InputDecoration(
                        hintText: 'What do you need a recommendation for',
                        hintStyle:
                        GoogleFonts.mulish(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: Colors.black),
                        // Remove the underline and border
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),

                    SizedBox(height: 10,),
                    TextFormField(
                      style: GoogleFonts.mulish(
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                          color: Color(0xFF162224)),
                      controller: descriptionController,
                      maxLines: 6,
                      decoration: InputDecoration(
                        hintText: 'I m looking for a water bottle that fits in my car cupholder and is at least 30 oz',

                        hintStyle:
                        GoogleFonts.mulish(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                            color: Color(0xFF162224)),
                        // Remove the underline and border
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),


                    Container(
                      width: size.width,
                      height: size.height * .15,
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

                    SizedBox(height: 30,),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        showValueIndicator: ShowValueIndicator.onlyForDiscrete,
                        trackHeight: 8,
                        trackShape: const RoundedRectSliderTrackShape(),
                        activeTrackColor: const Color(0xff3797EF),
                        inactiveTrackColor: const Color(0xFF3797EF).withOpacity(
                            0.12),
                        // thumbShape: const RoundSliderThumbShape(
                        //   enabledThumbRadius: 7.0,
                        //   pressedElevation: 8.0,
                        // ),
                        thumbColor: Colors.white,

                        overlayColor: const Color(0xFF3797EF).withOpacity(0.12),
                        // overlayShape: const RoundSliderOverlayShape(overlayRadius: 2.0),
                        // tickMarkShape: const RoundSliderTickMarkShape(),

                        activeTickMarkColor: const Color(0xff3797EF),
                        inactiveTickMarkColor: Colors.transparent,
                        // valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                        valueIndicatorColor: Colors.white10,
                        valueIndicatorTextStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                      ),
                      child: RangeSlider(
                        values: RangeValues(start, end),
                        labels: RangeLabels(
                            start.round().toString(), end.round().toString()),
                        divisions: 10,
                        onChanged: (value) {
                          setState(() {
                            start = value.start;
                            end = value.end;
                          });
                        },
                        min: 0.0,
                        max: 100.0,
                      ),
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

                  ]
              )
          ),
        )
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
}
