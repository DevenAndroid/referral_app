import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:referral_app/widgets/app_assets.dart';

import '../controller/profile_controller.dart';
import '../repositories/add_ask_recommendation_repo.dart';
import '../resourses/api_constant.dart';
import '../routers/routers.dart';
import '../widgets/app_text.dart';
import '../widgets/app_theme.dart';
import '../widgets/common_textfield.dart';
import '../widgets/custome_size.dart';
import '../widgets/custome_textfiled.dart';
import '../widgets/dimenestion.dart';
import '../widgets/recommendation_popup.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final key = GlobalKey<ScaffoldState>();

  var currentDrawer = 0;
  // String selectedValue = 'friends';


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Image.asset(AppAssets.man),
              ),
              title: Text(
                "Home",
                style: GoogleFonts.monomaniacOne(
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1,
                    fontSize: 25,
                    color: Color(0xFF262626)),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 14.0),
                  child: SvgPicture.asset(AppAssets.search),
                )
              ],
              bottom: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: AppTheme.primaryColor,
                indicatorPadding: EdgeInsets.symmetric(horizontal: 15),
                // automaticIndicatorColorAdjustment: true,
                onTap: (value) {
                  currentDrawer = 0;
                  setState(() {});
                },
                tabs: [
                  Tab(
                    child: Text(
                      "Discover",
                      style: currentDrawer == 0
                          ? GoogleFonts.mulish(
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                          fontSize: 15,
                          color: Color(0xFF3797EF))
                          :GoogleFonts.mulish(
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                          fontSize: 15,
                          color: Colors.black)
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Recommendation",
                      style: currentDrawer == 1
                          ? GoogleFonts.mulish(
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                          fontSize: 15,
                          color: Color(0xFF3797EF))
                          : GoogleFonts.mulish(
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                          fontSize: 15,
                          color: Colors.black)
                    ),
                  ),
                ],
              ),
            ),
            body:Padding(
              padding: const EdgeInsets.all(8.0),
              child: TabBarView(children: [
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: 4,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return
                                Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFF5F5F5F).withOpacity(0.2),
                                              offset: const Offset(0.0, 0.2),
                                              blurRadius: 2,
                                            ),
                                          ]),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(AppAssets.girl),
                                              SizedBox(width: 20,),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Camila",
                                                    style: GoogleFonts.mulish(
                                                        fontWeight: FontWeight.w700,
                                                        // letterSpacing: 1,
                                                        fontSize: 14,
                                                        color: Colors.black),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Mexico City, Mexico",
                                                        style: GoogleFonts.mulish(
                                                            fontWeight: FontWeight.w700,
                                                            // letterSpacing: 1,
                                                            fontSize: 12,
                                                            color: Color(0xFF878D98)),
                                                      ),

                                                      SizedBox(
                                                        height: 11,
                                                        child: VerticalDivider(
                                                          width: 8,
                                                          thickness: 1,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      Text(
                                                        "3 Hour",
                                                        style: GoogleFonts.mulish(
                                                            fontWeight: FontWeight.w300,
                                                            // letterSpacing: 1,
                                                            fontSize: 12,
                                                            color: Color(0xFF878D98)),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Spacer(),
                                              SvgPicture.asset(AppAssets.bookmark),
                                            ],
                                          ),
                                          SizedBox(height: 15,),
                                          Stack(children: [ Image.asset(AppAssets.picture),
                                            Positioned(
                                                right: 10,
                                                top: 15,
                                                child: SvgPicture.asset(AppAssets.forward))

                                          ]),
                                          SizedBox(height: 10,),
                                          Text(
                                            "What is a good water bottle?",
                                            style: GoogleFonts.mulish(
                                                fontWeight: FontWeight.w700,
                                                // letterSpacing: 1,
                                                fontSize: 17,
                                                color: Colors.black),
                                          ),
                                          SizedBox(height: 10,),
                                          Text(
                                            "What is a good water bottle?",
                                            style: GoogleFonts.mulish(
                                                fontWeight: FontWeight.w300,
                                                // letterSpacing: 1,
                                                fontSize: 14,
                                                color: Color(0xFF6F7683)),
                                          ),
                                          SizedBox(height: 10,),
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            width: 150,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: Color(0xFF3797EF).withOpacity(.09),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(AppAssets.message),
                                                SizedBox(width: 6,),
                                                Text(
                                                  "Recommendations: 120",
                                                  style: GoogleFonts.mulish(
                                                      fontWeight: FontWeight.w500,
                                                      // letterSpacing: 1,
                                                      fontSize: 12,
                                                      color: Color(0xFF3797EF)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 15,)
                                  ],
                                );

                            })
                      ],
                    ),
                  ),
                ),
               Column(
                 children: [

                 ],
               )
              ]),
            )));
  }

}
