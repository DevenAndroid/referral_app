import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:referral_app/widgets/app_assets.dart';
import 'package:share_plus/share_plus.dart';

import '../controller/profile_controller.dart';
import '../models/home_page_model.dart';
import '../repositories/add_ask_recommendation_repo.dart';
import '../repositories/home_pafe_repo.dart';
import '../resourses/api_constant.dart';
import '../routers/routers.dart';
import '../widgets/app_text.dart';
import '../widgets/app_theme.dart';
import '../widgets/common_error_widget.dart';
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
  Rx<RxStatus> statusOfHome = RxStatus.empty().obs;

  Rx<HomeModel> home = HomeModel().obs;

  chooseCategories() {
    getHomeRepo().then((value) {
      home.value = value;

      if (value.status == true) {
        statusOfHome.value = RxStatus.success();
      } else {
        statusOfHome.value = RxStatus.error();
      }

      // showToast(value.message.toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chooseCategories();
  }
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
                  currentDrawer = value;
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
                          ?
                      GoogleFonts.mulish(
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

    Obx(() {

    return statusOfHome.value.isSuccess ?

                        ListView.builder(
                            shrinkWrap: true,
                            itemCount:  home.value.data!.discover!.length,
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
                                              ClipOval(
                                                child: CachedNetworkImage(
                                              width: 30,
                                                  height: 30,
                                                  fit: BoxFit.cover,
                                                  imageUrl: home.value.data!.discover![index].userId!.profileImage.toString(),
                                                  placeholder: (context, url) =>
                                                    Image.asset(AppAssets.girl),
                                                  errorWidget: (context, url, error) =>
                                                      Image.asset(AppAssets.girl),
                                                ),
                                              ),

                                              SizedBox(width: 20,),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  home.value.data!.discover![index].userId!.name ==""? Text("Name..."  , style: GoogleFonts.mulish(
                                                  fontWeight: FontWeight.w700,
                                                  // letterSpacing: 1,
                                                  fontSize: 14,
                                                  color: Colors.black),): Text(
                                                    home.value.data!.discover![index].userId!.name.toString(),
                                                    style: GoogleFonts.mulish(
                                                        fontWeight: FontWeight.w700,
                                                        // letterSpacing: 1,
                                                        fontSize: 14,
                                                        color: Colors.black),
                                                  ),
                                                  Row(
                                                    children: [
                                                      home.value.data!.discover![index].userId!.address ==""? Text("address..."  , style: GoogleFonts.mulish(
                                                          fontWeight: FontWeight.w400,
                                                          // letterSpacing: 1,
                                                          fontSize: 14,
                                                          color: Color(0xFF878D98)),): Text(
                                                        home.value.data!.discover![index].userId!.address.toString(),
                                                        style: GoogleFonts.mulish(
                                                            fontWeight: FontWeight.w400,
                                                            // letterSpacing: 1,
                                                            fontSize: 14,
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
                                          Stack(children: [
                                            CachedNetworkImage(
width: size.width,
                                              height: 200,
                                              fit: BoxFit.fill,

                                              imageUrl:home.value.data!.discover![index].image.toString(),
                                              placeholder: (context, url) =>
                                               Image.asset(AppAssets.picture),
                                              errorWidget: (context, url, error) =>
                                                Image.asset(AppAssets.picture),
                                            ),

                                            Positioned(
                                                right: 10,
                                                top: 15,
                                                child:
                                                InkWell(
                                                    onTap: (){
                                                      Share.share(home.value.data!.discover![index].image.toString(),);
                                                    },
                                                    child: SvgPicture.asset(AppAssets.forward)))

                                          ]),
                                          SizedBox(height: 10,),
                                          Text(
                              home.value.data!.discover![index].title.toString(),
                                            style: GoogleFonts.mulish(
                                                fontWeight: FontWeight.w700,
                                                // letterSpacing: 1,
                                                fontSize: 17,
                                                color: Colors.black),
                                          ),
                                          SizedBox(height: 10,),
                                          Text(
                                            home.value.data!.discover![index].description.toString(),
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
        : statusOfHome.value.isError
        ? CommonErrorWidget(
      errorText: "",
      onTap: () {},
    )
        : const Center(
        child: CircularProgressIndicator());
    })
                      ],
                    ),
                  ),
                ),
               SingleChildScrollView(
                 child: Column(
                   children: [
                     Obx(() {

                       return statusOfHome.value.isSuccess ?

                       ListView.builder(
                           shrinkWrap: true,
                           itemCount: home.value.data!.recommandation!.length,
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
                                             ClipOval(
                                               child: CachedNetworkImage(
                                                 width: 30,
                                                 height: 30,
                                                 fit: BoxFit.cover,
                                                 imageUrl: home.value.data!.recommandation![index].user!.profileImage.toString(),
                                                 placeholder: (context, url) =>
                                                     Image.asset(AppAssets.girl),
                                                 errorWidget: (context, url, error) =>
                                                     Image.asset(AppAssets.girl),
                                               ),
                                             ),
                                             SizedBox(width: 20,),
                                             Column(
                                               mainAxisAlignment: MainAxisAlignment.start,
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               children: [
                                                 home.value.data!.recommandation![index].user!.name ==""? Text("Name..."  , style: GoogleFonts.mulish(
                                                     fontWeight: FontWeight.w700,
                                                     // letterSpacing: 1,
                                                     fontSize: 14,
                                                     color: Colors.black),): Text(
                                                   home.value.data!.recommandation![index].user!.name.toString(),
                                                   style: GoogleFonts.mulish(
                                                       fontWeight: FontWeight.w700,
                                                       // letterSpacing: 1,
                                                       fontSize: 14,
                                                       color: Colors.black),
                                                 ),
                                                 Row(
                                                   children: [
                                                     home.value.data!.recommandation![index].user!.address ==""? Text("address..."  , style: GoogleFonts.mulish(
                                                         fontWeight: FontWeight.w400,
                                                         // letterSpacing: 1,
                                                         fontSize: 13,
                                                         color: Colors.grey),): Text(
                                                       home.value.data!.recommandation![index].user!.address.toString(),
                                                       style: GoogleFonts.mulish(
                                                           fontWeight: FontWeight.w400,
                                                           // letterSpacing: 1,
                                                           fontSize: 13,
                                                           color: Colors.grey),
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
                                         Stack(children: [
                                           CachedNetworkImage(
                                             width: size.width,
                                             height: 200,
                                             fit: BoxFit.contain ,

                                             imageUrl:home.value.data!.recommandation![index].image.toString(),
                                             placeholder: (context, url) =>
                                                 Image.asset(AppAssets.picture,width: size.width,),
                                             errorWidget: (context, url, error) =>
                                                 Image.asset(AppAssets.picture,width: size.width,),
                                           ),

                                           Positioned(
                                               right: 10,
                                               top: 15,
                                               child:
                                               InkWell(
                                                   onTap: (){
                                                     Share.share(home.value.data!.recommandation![index].image.toString(),);
                                                   },
                                                   child: SvgPicture.asset(AppAssets.forward)))

                                         ]),
                                         SizedBox(height: 10,),
                                         Text(
                                           home.value.data!.recommandation![index].title.toString(),
                                           style: GoogleFonts.mulish(
                                               fontWeight: FontWeight.w700,
                                               // letterSpacing: 1,
                                               fontSize: 17,
                                               color: Colors.black),
                                         ),
                                         SizedBox(height: 10,),
                                         Text(
                                           home.value.data!.recommandation![index].review.toString(),
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
                           : statusOfHome.value.isError
                           ? CommonErrorWidget(
                         errorText: "",
                         onTap: () {},
                       )
                           : const Center(
                           child: CircularProgressIndicator());
                     })
                   ],
                 ),
               )
              ]),
            )));
  }

}
