import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/app_assets.dart';
import '../widgets/app_theme.dart';
import '../widgets/custome_textfiled.dart';

class RecommendationSingleScreen extends StatefulWidget {
  const RecommendationSingleScreen({super.key});

  @override
  State<RecommendationSingleScreen> createState() =>
      _RecommendationSingleScreenState();
}

class _RecommendationSingleScreenState
    extends State<RecommendationSingleScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(Icons.clear))
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
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
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Lorem Ipsum is simply dummy text of the \nprinting and typesetting industry. ",
                        style: GoogleFonts.mulish(
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                            color: Color(0xFF162224)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(AppAssets.location),
                          SizedBox(
                            width: 9,
                          ),
                          Text(
                            "56 Glassford Street Glasgow G1 1UL New York ",
                            style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Color(0xFF162224)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Image.asset(AppAssets.sofa)
                    ]))));
  }
}
