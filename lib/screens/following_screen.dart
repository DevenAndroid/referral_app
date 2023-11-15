import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:referral_app/main.dart';
import 'package:referral_app/routers/routers.dart';

import '../widgets/app_assets.dart';
import '../widgets/app_theme.dart';
class FollowingScreen extends StatefulWidget {
  const FollowingScreen({super.key});

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  var currentDrawer = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
              appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title:         Text("Following",
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
            ),
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
                        "Followers 120",
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
                        "Following 150",
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
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: size.height,
                  child: TabBarView(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: 6,
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
                                        child: Row(
                                          children: [
                                            Image.asset(AppAssets.img,height: 40,),
                                            SizedBox(width: 20,),
                                            Text(
                                              "David Paterson",
                                              style: GoogleFonts.mulish(
                                                  fontWeight: FontWeight.w400,
                                                  // letterSpacing: 1,
                                                  fontSize: 17,
                                                  color: Colors.black),
                                            ),

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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: 6,
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
                                        child: Row(
                                          children: [
                                            Image.asset(AppAssets.img1,height: 40,),
                                            SizedBox(width: 20,),
                                            Text(
                                              "David Paterson",
                                              style: GoogleFonts.mulish(
                                                  fontWeight: FontWeight.w400,
                                                  // letterSpacing: 1,
                                                  fontSize: 17,
                                                  color: Colors.black),
                                            ),
Spacer(),
Container(
  padding: EdgeInsets.all(5),
  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
  border: Border.all(color: AppTheme.secondaryColor)
  ),
  child:  Text(
    "Unfollow",
    style: GoogleFonts.mulish(
        fontWeight: FontWeight.w500,
        // letterSpacing: 1,
        fontSize: 15,
        color: AppTheme.secondaryColor),
  ),
)
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

                  ]),
                ),
              ),
            )));
  }
}
