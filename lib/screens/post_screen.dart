import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:referral_app/routers/routers.dart';
import 'package:referral_app/widgets/app_assets.dart';
import 'package:referral_app/widgets/app_theme.dart';
import 'package:referral_app/widgets/custome_textfiled.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 25,),
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
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(Icons.clear))
                        ],
                      ),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Best color for furniture",
                            style: GoogleFonts.mulish(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Color(0xFF000000)),
                          ),
                          SizedBox(
                              width: 80,
                              height: 32,
                              child: CommonButton(title: "Post", onPressed: () {
                                Get.toNamed(
                                    MyRouters.recommendationSingleScreen);
                              },))
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
                      Image.asset(AppAssets.sofa)

                    ]
                ))));
  }
}
