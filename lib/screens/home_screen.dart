// import 'dart:io';

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
import '../controller/wishlist controller.dart';
import '../models/categories_model.dart';
import '../models/home_page_model.dart';
import '../models/remove_reomeendation.dart';
import '../models/single_product_model.dart';
import '../repositories/add_ask_recommendation_repo.dart';
import '../repositories/categories_repo.dart';
import '../repositories/home_pafe_repo.dart';
import '../repositories/single_produc_repo.dart';
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



  Rx<RxStatus> statusOfCategories = RxStatus.empty().obs;

  Rx<CategoriesModel> categories = CategoriesModel().obs;
  Rx<RxStatus> statusOfSingle= RxStatus.empty().obs;

  Rx<SingleProduct> single = SingleProduct().obs;
  chooseCategories1() {
  getCategoriesRepo().then((value) {
  categories.value = value;

  if (value.status == true) {
  statusOfCategories.value = RxStatus.success();
  } else {
  statusOfCategories.value = RxStatus.error();
  }

  // showToast(value.message.toString());
  });
  }
  Rx<RxStatus> statusOfHome = RxStatus.empty().obs;
  final wishListController = Get.put(WishListController());
  final profileController = Get.put(ProfileController());

  Rx<RemoveRecommendationModel> modalRemove = RemoveRecommendationModel().obs;
  Rx<RxStatus> statusOfRemove = RxStatus.empty().obs;
  Rx<HomeModel> home = HomeModel().obs;
  bool like = false ;
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
    chooseCategories1();
  }

  final key = GlobalKey<ScaffoldState>();

  var currentDrawer = 0;

  // String selectedValue = 'friends';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
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
                    child: Text("Discover",
                        style: currentDrawer == 0
                            ? GoogleFonts.mulish(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                            fontSize: 15,
                            color: Color(0xFF3797EF))
                            : GoogleFonts.mulish(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                            fontSize: 15,
                            color: Colors.black)),
                  ),
                  Tab(
                    child: Text("Recommendation",
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
                            color: Colors.black)),
                  ),
                ],
              ),
            ),
            body: Padding(
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
                          return statusOfHome.value.isSuccess
                              ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: home.value.data!.discover!.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFF5F5F5F)
                                                  .withOpacity(0.2),
                                              offset:
                                              const Offset(0.0, 0.2),
                                              blurRadius: 2,
                                            ),
                                          ]),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              ClipOval(
                                                child: CachedNetworkImage(
                                                  width: 30,
                                                  height: 30,
                                                  fit: BoxFit.cover,
                                                  imageUrl: home
                                                      .value
                                                      .data!
                                                      .discover![index]
                                                      .userId!
                                                      .profileImage
                                                      .toString(),
                                                  placeholder: (context,
                                                      url) =>
                                                      Image.asset(
                                                          AppAssets.girl),
                                                  errorWidget: (context,
                                                      url, error) =>
                                                      Image.asset(
                                                          AppAssets.girl),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    home
                                                        .value
                                                        .data!
                                                        .discover![
                                                    index]
                                                        .userId!
                                                        .name ==
                                                        ""
                                                        ? Text(
                                                      "Name...",
                                                      style: GoogleFonts
                                                          .mulish(
                                                          fontWeight:
                                                          FontWeight
                                                              .w700,
                                                          // letterSpacing: 1,
                                                          fontSize:
                                                          14,
                                                          color: Colors
                                                              .black),
                                                    )
                                                        : Text(
                                                      home
                                                          .value
                                                          .data!
                                                          .discover![
                                                      index]
                                                          .userId!
                                                          .name
                                                          .toString(),
                                                      style: GoogleFonts
                                                          .mulish(
                                                          fontWeight:
                                                          FontWeight
                                                              .w700,
                                                          // letterSpacing: 1,
                                                          fontSize:
                                                          14,
                                                          color: Colors
                                                              .black),
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Expanded(
                                                          child: home
                                                              .value
                                                              .data!
                                                              .discover![
                                                          index]
                                                              .userId!
                                                              .address ==
                                                              ""
                                                              ? Text(
                                                            "address...",
                                                            style: GoogleFonts
                                                                .mulish(
                                                                fontWeight: FontWeight
                                                                    .w400,
                                                                // letterSpacing: 1,
                                                                fontSize: 14,
                                                                color: Color(
                                                                    0xFF878D98)),
                                                          )
                                                              : Text(
                                                            home
                                                                .value
                                                                .data!
                                                                .discover![
                                                            index]
                                                                .userId!
                                                                .address
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .mulish(
                                                                fontWeight: FontWeight
                                                                    .w400,
                                                                // letterSpacing: 1,
                                                                fontSize: 14,
                                                                color: Color(
                                                                    0xFF878D98)),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                          child:
                                                          VerticalDivider(
                                                            width: 8,
                                                            thickness: 1,
                                                            color:
                                                            Colors.grey,
                                                          ),
                                                        ),
                                                        Text(
                                                          "3 Hour",
                                                          style: GoogleFonts
                                                              .mulish(
                                                              fontWeight:
                                                              FontWeight
                                                                  .w300,
                                                              // letterSpacing: 1,
                                                              fontSize:
                                                              12,
                                                              color: Color(
                                                                  0xFF878D98)),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SvgPicture.asset(
                                                  AppAssets.bookmark),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Stack(children: [
                                            CachedNetworkImage(
                                              width: size.width,
                                              height: 200,
                                              fit: BoxFit.fill,
                                              imageUrl: home.value.data!
                                                  .discover![index].image
                                                  .toString(),
                                              placeholder: (context, url) =>
                                                 SizedBox(),
                                              errorWidget: (context, url,
                                                  error) =>
                                                  SizedBox(),
                                            ),
                                            Positioned(
                                                right: 10,
                                                top: 15,
                                                child: InkWell(
                                                    onTap: () {
                                                      Share.share(
                                                        home
                                                            .value
                                                            .data!
                                                            .discover![
                                                        index]
                                                            .image
                                                            .toString(),
                                                      );
                                                    },
                                                    child: SvgPicture.asset(
                                                        AppAssets.forward)))
                                          ]),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            home.value.data!
                                                .discover![index].title
                                                .toString(),
                                            style: GoogleFonts.mulish(
                                                fontWeight: FontWeight.w700,
                                                // letterSpacing: 1,
                                                fontSize: 17,
                                                color: Colors.black),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            home
                                                .value
                                                .data!
                                                .discover![index]
                                                .description
                                                .toString(),
                                            style: GoogleFonts.mulish(
                                                fontWeight: FontWeight.w300,
                                                // letterSpacing: 1,
                                                fontSize: 14,
                                                color: Color(0xFF6F7683)),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                width: size.width * .45,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF3797EF)
                                                      .withOpacity(.09),
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                ),
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                        AppAssets.message),
                                                    const SizedBox(
                                                      width: 6,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        showModalBottomSheet(
                                                          isScrollControlled: true,
                                                          context: context,
                                                          backgroundColor:
                                                          Colors.white,
                                                          elevation: 10,

                                                          shape:
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                20.0),
                                                          ),
                                                          builder: (BuildContext
                                                          context) {
                                                            // UDE : SizedBox instead of Container for whitespaces
                                                            return Center(
                                                              child: Padding(
                                                                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 20),
                                                                child: SingleChildScrollView(
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        'recommendation List',
                                                                        style: GoogleFonts
                                                                            .mulish(
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                          // letterSpacing: 1,
                                                                          fontSize:
                                                                          18,
                                                                          color: Colors
                                                                              .black,
                                                                        ),
                                                                      ),
                                                                      ListView.builder(
                                                                        scrollDirection: Axis.vertical,

                                                                        itemCount: 20,
                                                                        shrinkWrap: true,
                                                                        itemBuilder: (context, index) {
                                                                         return Padding(
                                                                            padding: const EdgeInsets.only(left: 8.0,top: 10),
                                                                            child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [

                                                                                Image(
                                                                                    height: 20,
                                                                                    width: 20,
                                                                                    image: AssetImage(
                                                                                        'assets/icons/chat.png')

                                                                                ),
                                                                                SizedBox(width: 10,),
                                                                                Container(
                                                                                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                                                                  decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10) ),
                                                                                      color: Color(
                                                                                          0xffF0F0F0)
                                                                                  ),
                                                                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Row(
                                                                                        children: [
                                                                                          Text(
                                                                                            'David Paterson',
                                                                                            style: GoogleFonts
                                                                                                .mulish(
                                                                                              fontWeight:
                                                                                              FontWeight
                                                                                                  .w600,
                                                                                              // letterSpacing: 1,
                                                                                              fontSize:
                                                                                              14,
                                                                                              color: Colors
                                                                                                  .black,
                                                                                            ),),
                                                                                          SizedBox(
                                                                                            width: 10,),
                                                                                          Text(
                                                                                            '2 days',
                                                                                            style: GoogleFonts
                                                                                                .mulish(
                                                                                              fontWeight:
                                                                                              FontWeight
                                                                                                  .w400,
                                                                                              // letterSpacing: 1,
                                                                                              fontSize:
                                                                                              10,
                                                                                              color: Colors
                                                                                                  .black,
                                                                                            ),),
                                                                                          SizedBox(width: 50,),
                                                                                          Icon(Icons.favorite_outline,color: Color(0xff134563),)
                                                                                        ],
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: size
                                                                                            .height *
                                                                                            .02,),
                                                                                      Text(
                                                                                        'i think Steel bottle is okay please use',
                                                                                        style: GoogleFonts
                                                                                            .mulish(
                                                                                          fontWeight:
                                                                                          FontWeight
                                                                                              .w600,
                                                                                          // letterSpacing: 1,
                                                                                          fontSize:
                                                                                          14,
                                                                                          color: Colors
                                                                                              .black,
                                                                                        ),)
                                                                                    ],
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          );
                                                                        },

                                                                      )
                                                                      ,SizedBox(
                                                                        height: 20,)
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Text(
                                                        "Recommendations: 120",
                                                        style:
                                                        GoogleFonts.mulish(
                                                            fontWeight:
                                                            FontWeight
                                                                .w500,
                                                            // letterSpacing: 1,
                                                            fontSize: 12,
                                                            color: const Color(
                                                                0xFF3797EF)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              Text( home
                                                  .value
                                                  .data!
                                                  .discover![index]
                                                  .maxPrice
                                                  .toString(),),
                                              SizedBox(width: 10,),
                                              Text( home
                                                  .value
                                                  .data!
                                                  .discover![index]
                                                  .maxPrice
                                                  .toString(),)
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    )
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
                  physics:
                  const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                            height: size.height * .15,
                            child: Obx(() {
                              return statusOfCategories.value.isSuccess && profileController.statusOfProfile.value.isSuccess
                                  ? ListView.builder(
                                  itemCount: categories
                                      .value.data!.length,
                                  shrinkWrap: true,
                                  scrollDirection:
                                  Axis.horizontal,
                                  physics:
                                  const AlwaysScrollableScrollPhysics(),
                                  itemBuilder:
                                      (context, index) {
                                    return Padding(
                                      padding:
                                      const EdgeInsets
                                          .all(8.0),
                                      child: Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              getSingleRepo(category_id:categories
                                                  .value.data![index].id.toString() ).then((value) {
                                                single.value = value;

                                                if (value.status == true) {
                                                  statusOfSingle.value = RxStatus.success();
                                                } else {
                                                  statusOfSingle.value = RxStatus.error();
                                                }
setState(() {

});
                                                // showToast(value.message.toString());
                                              });
                                              // profileController.categoriesController.text = item.name.toString();
                                              // profileController.idController.text = item.id.toString();
                                              // Get.back();
                                            },
                                            child: ClipOval(
                                              child:
                                              CachedNetworkImage(
                                                width: 70,
                                                height: 70,
                                                fit: BoxFit
                                                    .fill,
                                                imageUrl: categories
                                                    .value
                                                    .data![
                                                index]
                                                    .image
                                                    .toString(),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            categories
                                                .value
                                                .data![
                                            index]
                                                .name
                                                .toString(),
                                            style: GoogleFonts
                                                .mulish(
                                                fontWeight:
                                                FontWeight
                                                    .w300,
                                                // letterSpacing: 1,
                                                fontSize:
                                                14,
                                                color: Color(
                                                    0xFF26282E)),
                                          )
                                        ],
                                      ),
                                    );
                                  })
                                  : statusOfCategories
                                  .value.isError
                                  ? CommonErrorWidget(
                                errorText: "",
                                onTap: () {},
                              )
                                  : const Center(
                                  child:
                                  CircularProgressIndicator());
                            })),


                        statusOfSingle.value.isSuccess?
                        GridView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            // Number of columns
                            crossAxisSpacing: 8.0,
                            // Spacing between columns
                            mainAxisSpacing:
                            2.0, // Spacing between rows
                          ),
                          itemCount:  single.value.data!.length,
                          // Total number of items
                          itemBuilder: (BuildContext context,
                              int index) {
                            // You can replace the Container with your image widget
                            return InkWell(
                              onTap: (){
                                Get.toNamed(MyRouters.recommendationSingleScreen,arguments: [
                                  single.value.data![index]
                                      .image
                                      .toString(),
                                  single.value.data![index]
                                      .title
                                      .toString(),
                                  single.value.data![index]
                                      .review
                                      .toString(),
                                  single.value.data![index].id.toString(),


                                ]);
                              },
                              child: CachedNetworkImage(
                                imageUrl:  single.value.data![index]
                                    .image
                                    .toString(),
                                width: 50,
                                height: 50,
                              ),
                            );
                          },
                        ) : statusOfSingle
                            .value.isError
                            ? CommonErrorWidget(
                          errorText: "",
                          onTap: () {},
                        )
                            : const Center(
                            child:
                            CircularProgressIndicator()),

                        profileController.statusOfProfile.value.isSuccess?
                        GridView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            // Number of columns
                            crossAxisSpacing: 8.0,
                            // Spacing between columns
                            mainAxisSpacing:
                            2.0, // Spacing between rows
                          ),
                          itemCount: profileController
                              .modal
                              .value
                              .data!
                              .myRecommandation!
                              .length,
                          // Total number of items
                          itemBuilder: (BuildContext context,
                              int index) {
                            // You can replace the Container with your image widget
                            return CachedNetworkImage(
                              imageUrl: profileController
                                  .modal
                                  .value
                                  .data!
                                  .myRecommandation![index]
                                  .image
                                  .toString(),
                              width: 50,
                              height: 50,
                            );
                          },
                        ) : profileController.statusOfProfile
                            .value.isError
                            ? CommonErrorWidget(
                          errorText: "",
                          onTap: () {},
                        )
                            : const Center(
                            child:
                            CircularProgressIndicator()),
                      ],
                    ),
                  ),
                ),
              ]),
            )));
  }

}

