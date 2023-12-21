import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:referral_app/routers/routers.dart';
import 'package:referral_app/widgets/app_assets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/profile_controller.dart';
import '../models/add_remove_recommendation.dart';
import '../models/categories_model.dart';
import '../models/home_page_model.dart';
import '../models/model_review_list.dart';
import '../models/model_user_profile.dart';
import '../repositories/add_remove_follow_repo.dart';
import '../repositories/categories_repo.dart';
import '../repositories/get_user_profile.dart';
import '../repositories/home_pafe_repo.dart';
import '../repositories/remove_bookmark_repo.dart';
import '../repositories/repo_add_like.dart';
import '../repositories/repo_review_list.dart';
import '../resourses/api_constant.dart';
import '../widgets/app_theme.dart';
import '../widgets/common_error_widget.dart';
import '../widgets/custome_textfiled.dart';

class AllUserProfileScreen extends StatefulWidget {
  const AllUserProfileScreen({super.key});

  @override
  State<AllUserProfileScreen> createState() => AllUserProfileScreenState();
}

class AllUserProfileScreenState extends State<AllUserProfileScreen> with SingleTickerProviderStateMixin {
  Rx<RxStatus> statusOfUser = RxStatus
      .empty()
      .obs;

  Rx<ModelUserProfile> userProfile = ModelUserProfile().obs;
  Rx<ModelAddRemoveFollow> modalRemove = ModelAddRemoveFollow().obs;
  Rx<RxStatus> statusOfReviewList = RxStatus.empty().obs;
  Rx<ModelReviewList> modelReviewList = ModelReviewList().obs;


  Rx<RxStatus> statusOfRemove = RxStatus
      .empty()
      .obs;

  var id = Get.arguments[0];

  UserProfile() {
    userProfileRepo(recommandation_id: id, type: "user").then((value) {
      userProfile.value = value;
      print(id);
      if (value.status == true) {
        statusOfUser.value = RxStatus.success();
      } else {
        statusOfUser.value = RxStatus.error();
      }

      // showToast(value.message.toString());
    });
  }

  // final profileController = Get.put(ProfileController());

  bool showFloatingActionButton = false;
  late TabController _tabController;

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showToast('Could not launch $url');
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_tabListener);
    // Get.arguments[0];
    // profileController.getData();
    UserProfile();

    // chooseCategories1();
  }

  void _tabListener() {
    setState(() {
      showFloatingActionButton = _tabController.index == 1; // 1 corresponds to "My recommendations"
    });
  }

  var currentDrawer = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // floatingActionButton: showFloatingActionButton
        //     ? Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 0).copyWith(bottom: 80),
        //   child: FloatingActionButton(
        //     onPressed: () {
        //       Get.toNamed(MyRouters.addRecommendationScreen);
        //     },
        //     backgroundColor: Colors.transparent,
        //     child: SvgPicture.asset(AppAssets.add1),
        //   ),
        // )
        //     : const SizedBox(),
        backgroundColor: const Color(0xFFEAEEF1),
        body: RefreshIndicator(
          color: Colors.white,
          backgroundColor: AppTheme.primaryColor,
          onRefresh: () async {
            // profileController.getData();
          },
          child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Obx(() {
                return statusOfUser.value.isSuccess
                    ? Column(
                  children: [
                    Container(
                      width: size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Icon(Icons.arrow_back)),
                                SizedBox(
                                  width: 130,
                                ),
                                Text("Profile",
                                    style: GoogleFonts.mulish(
                                        fontWeight: FontWeight.w700, fontSize: 18, color: const Color(0xFF262626))),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: AppTheme.secondaryColor.withOpacity(.3), width: 1),
                                      shape: BoxShape.circle),
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: AppTheme.secondaryColor.withOpacity(.3), width: 1),
                                        shape: BoxShape.circle),
                                    child: ClipOval(
                                      child: CachedNetworkImage(
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                        imageUrl: userProfile.value.data!.user!.profileImage.toString(),
                                        placeholder: (context, url) => const SizedBox(),
                                        errorWidget: (context, url, error) => const SizedBox(),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(MyRouters.singlePostScreen,
                                        arguments: [userProfile.value.data!.user!.postCount.toString(),]);
                                  },
                                  child: Column(
                                    children: [
                                      Text(userProfile.value.data!.user!.postCount.toString(),
                                          style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                              color: const Color(0xFF000000))),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text("posts",
                                          style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 16,
                                              color: const Color(0xFF262626))),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(MyRouters.followingScreen, arguments: [
                                      userProfile.value.data!.user!.followersCount.toString(),
                                      userProfile.value.data!.user!.followingCount.toString(),
                                      userProfile.value.data!.user!.id.toString(),
                                    ]);
                                  },
                                  child: Column(
                                    children: [
                                      Text(userProfile.value.data!.user!.followersCount.toString(),
                                          style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                              color: const Color(0xFF000000))),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text("followers",
                                          style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 16,
                                              color: const Color(0xFF262626))),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    currentDrawer == 1;
                                    Get.toNamed(MyRouters.followingScreen, arguments: [
                                      userProfile.value.data!.user!.followersCount.toString(),
                                      userProfile.value.data!.user!.followingCount.toString(),
                                      userProfile.value.data!.user!.id.toString(),
                                    ]);
                                  },
                                  child: Column(
                                    children: [
                                      Text(userProfile.value.data!.user!.followingCount.toString(),
                                          style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                              color: const Color(0xFF000000))),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text("following",
                                          style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 16,
                                              color: const Color(0xFF262626))),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(userProfile.value.data!.user!.name!. capitalizeFirst.toString(),
                                    style: GoogleFonts.mulish(
                                        fontWeight: FontWeight.w700, fontSize: 20, color: const Color(0xFF262626))),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Obx(() {
                                    return SizedBox(
                                        width: 120,
                                        height: 35,
                                        child: CommonButton(
                                          title: userProfile.value.data!.user!.isFollow == true
                                              ? "Following" : "Follow",
                                          onPressed: () {
                                            addRemoveRepo(
                                              context: context,
                                              following_id: userProfile.value.data!.user!.id.toString(),
                                            ).then((value) async {
                                              // userProfile.value = value;
                                              if (value.status == true) {
                                                print('wishlist-----');
                                                statusOfRemove.value = RxStatus.success();
                                                //homeController.getPaginate();

                                                // like=true;
                                                showToast(value.message.toString());
                                              } else {
                                                statusOfRemove.value = RxStatus.error();
                                                // like=false;
                                                showToast(value.message.toString());
                                              }
                                            });
                                            setState(() {
                                              if (userProfile.value.data!.user!.isFollow == false) {
                                                userProfile.value.data!.user!.isFollow = true;
                                              } else {
                                                userProfile.value.data!.user!.isFollow = false;
                                              }
                                            });
                                          },
                                        ));
                                  }),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            // Row(
                            //   children: [
                            //     SvgPicture.asset(AppAssets.location1),
                            //     SizedBox(
                            //       width: 6,
                            //     ),
                            //     Text(
                            //         profileController
                            //             .modal.value.data!.user!.address
                            //             .toString(),
                            //         style: GoogleFonts.mulish(
                            //             fontWeight: FontWeight.w300,
                            //             fontSize: 16,
                            //             color: const Color(0xFF262626))),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TabBar(
                                controller: _tabController,
                                padding: EdgeInsets.zero,
                                isScrollable: true,
                                labelColor: Colors.blue,
                                labelStyle: TextStyle(color: Colors.blue),
                                dividerColor: Colors.transparent,
                                physics: const AlwaysScrollableScrollPhysics(),
                                // indicatorSize: TabBarIndicatorSize.tab,
                                indicatorColor: AppTheme.primaryColor,

                                // automaticIndicatorColorAdjustment: true,
                                onTap: (value) {
                                  currentDrawer = value;
                                  setState(() {});
                                  print(currentDrawer);
                                },
                                tabs: [
                                  Tab(
                                    child: Text("Requests",
                                        style: currentDrawer == 0
                                            ? GoogleFonts.mulish(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: const Color(0xFF3797EF))
                                            : GoogleFonts.mulish(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: Colors.black)),
                                  ),
                                  Tab(
                                    child: Text("Recommendations",
                                        style: currentDrawer == 1
                                            ? GoogleFonts.mulish(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: const Color(0xFF3797EF))
                                            : GoogleFonts.mulish(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: Colors.black)),
                                  ),
                                  // Tab(
                                  //   child: Text("Saved recommendations",
                                  //       style: currentDrawer == 2
                                  //           ? GoogleFonts.mulish(
                                  //           fontWeight:
                                  //           FontWeight.w600,
                                  //           letterSpacing: 1,
                                  //           fontSize: 15,
                                  //           color: const Color(
                                  //               0xFF3797EF))
                                  //           : GoogleFonts.mulish(
                                  //           fontWeight:
                                  //           FontWeight.w600,
                                  //           letterSpacing: 1,
                                  //           fontSize: 15,
                                  //           color: Colors.black)),
                                  // ),
                                ],
                              ),
                            ]),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: size.width,
                      height: size.height,
                      color: Colors.white,
                      padding: const EdgeInsets.all(8.0),
                      child: TabBarView(controller: _tabController, children: [
                        SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() {
                                  return statusOfUser.value.isSuccess
                                      ? Column(
                                    children: [
                                      ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: userProfile.value.data!.myRequest!.length,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [

                                                Container(
                                                  padding: const EdgeInsets.all(10),
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
                                                          GestureDetector(
                                                            onTap: () {
                                                              // Get.toNamed(MyRouters.allUserProfileScreen, arguments: [
                                                              //   homeController.homeModel.value.data!.discover![index]
                                                              //       .userId!.id
                                                              //       .toString(),
                                                              // ]);
                                                            },
                                                            child: ClipOval(
                                                              child: CachedNetworkImage(
                                                                width: 30,
                                                                height: 30,
                                                                fit: BoxFit.cover,
                                                                imageUrl: userProfile.value.data!
                                                                    .myRequest![index].userId ==
                                                                    null
                                                                    ? AppAssets.man
                                                                    : userProfile.value.data!
                                                                    .myRequest![index]
                                                                    .userId!.profileImage
                                                                    .toString(),
                                                                errorWidget: (_, __, ___) => Image.asset(
                                                                  AppAssets.man,
                                                                  color: Colors.grey.shade200,
                                                                ),
                                                                placeholder: (_, __) => Image.asset(
                                                                  AppAssets.man,
                                                                  color: Colors.grey.shade200,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 20,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              userProfile.value.data!
                                                                  .myRequest![index]
                                                                  .userId?.name ==
                                                                  ""
                                                                  ? Text(
                                                                "Name...",
                                                                style: GoogleFonts.mulish(
                                                                    fontWeight: FontWeight.w700,
                                                                    // letterSpacing: 1,
                                                                    fontSize: 14,
                                                                    color: Colors.black),
                                                              )
                                                                  : Text(
                                                                userProfile.value.data!
                                                                    .myRequest![index].userId!.name
                                                                    .toString()
                                                                    .capitalizeFirst
                                                                    .toString(),
                                                                style: GoogleFonts.mulish(
                                                                    fontWeight: FontWeight.w700,
                                                                    // letterSpacing: 1,
                                                                    fontSize: 14,
                                                                    color: Colors.black),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(width: 5,),


                                                          // const SizedBox(
                                                          //   height: 15,
                                                          //   width: 20,
                                                          //   child: VerticalDivider(
                                                          //     color: Color(0xffD9D9D9),
                                                          //
                                                          //   ),
                                                          // ),
                                                          // Text(
                                                          //   userProfile.value.data!
                                                          //       .myRequest![index].!.capitalize.toString(),
                                                          //   style: GoogleFonts.mulish(
                                                          //     fontWeight: FontWeight.w300,
                                                          //     // letterSpacing: 1,
                                                          //     fontSize: 12,
                                                          //     color:  Color(0xff878D98),
                                                          //   ),
                                                          // ),
                                                          Spacer(),

                                                          Padding(
                                                            padding: const EdgeInsets.only(right: 8.0),
                                                            child: Obx(() {
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  // home.value.data!.discover![index].wishlist.toString();

                                                                  // bookmarkRepo(
                                                                  //   context: context,
                                                                  //   post_id: userProfile.value.data!
                                                                  //       .myRequest![index].id
                                                                  //       .toString(),
                                                                  //   type: "askrecommandation",
                                                                  // ).then((value) async {
                                                                  //   modalRemove.value = value;
                                                                  //   if (value.status == true) {
                                                                  //     print('wishlist-----');
                                                                  //     homeController.getData();
                                                                  //     statusOfRemove.value = RxStatus.success();
                                                                  //     //homeController.getPaginate();
                                                                  //
                                                                  //     // like=true;
                                                                  //     showToast(value.message.toString());
                                                                  //   } else {
                                                                  //     statusOfRemove.value = RxStatus.error();
                                                                  //     // like=false;
                                                                  //     showToast(value.message.toString());
                                                                  //   }
                                                                  // });
                                                                  // setState(() {});
                                                                },
                                                                child: userProfile.value.data!
                                                                    .myRequest![index].wishlist ==
                                                                    true
                                                                    ? SvgPicture.asset(
                                                                  AppAssets.bookmark1,
                                                                  height: 20,
                                                                )
                                                                    : SvgPicture.asset(AppAssets.bookmark),
                                                              );
                                                            }),
                                                          ),
                                                          const SizedBox(
                                                            width: 15,
                                                          ),
                                                          GestureDetector(
                                                              onTap: () {
                                                                Share.share(
                                                                  userProfile.value.data!
                                                                      .myRequest![index].image
                                                                      .toString(),
                                                                );
                                                              },
                                                              child: SvgPicture.asset(AppAssets.forward))
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      userProfile.value.data!
                                                          .myRequest![index].image == ""
                                                          ? const SizedBox()
                                                          : ClipRRect(
                                                        borderRadius: BorderRadius.circular(10),
                                                        child: CachedNetworkImage(
                                                          width: size.width,
                                                          height: 200,
                                                          fit: BoxFit.fill,
                                                          imageUrl: userProfile.value.data!
                                                              .myRequest![index].image
                                                              .toString(),
                                                          placeholder: (context, url) => const SizedBox(
                                                            height: 0,
                                                          ),
                                                          errorWidget: (context, url, error) => const SizedBox(
                                                            height: 0,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        userProfile.value.data!
                                                            .myRequest![index].title
                                                            .toString()
                                                            .capitalizeFirst
                                                            .toString(),
                                                        style: GoogleFonts.mulish(
                                                            fontWeight: FontWeight.w700,
                                                            // letterSpacing: 1,
                                                            fontSize: 17,
                                                            color: Colors.black),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        userProfile.value.data!
                                                            .myRequest![index].description
                                                            .toString()
                                                            .capitalizeFirst
                                                            .toString(),
                                                        style: GoogleFonts.mulish(
                                                            fontWeight: FontWeight.w300,
                                                            // letterSpacing: 1,
                                                            fontSize: 14,
                                                            color: const Color(0xFF6F7683)),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                getReviewListRepo(
                                                                    context: context,
                                                                    id: userProfile.value.data!
                                                                        .myRequest![index].id
                                                                        .toString())
                                                                    .then((value) {
                                                                  modelReviewList.value = value;

                                                                  if (value.status == true) {
                                                                    statusOfReviewList.value = RxStatus.success();
                                                                    _settingModalBottomSheet(context);
                                                                  } else {
                                                                    statusOfReviewList.value = RxStatus.error();
                                                                  }
                                                                  setState(() {});
                                                                });
                                                              });
                                                            },
                                                            child: Container(
                                                              padding: const EdgeInsets.only(left: 15),
                                                              width: size.width * .45,
                                                              height: 30,
                                                              decoration: BoxDecoration(
                                                                color: const Color(0xFF3797EF).withOpacity(.09),
                                                                borderRadius: BorderRadius.circular(5),
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  SvgPicture.asset(AppAssets.message,height: 16,),
                                                                  const SizedBox(
                                                                    width: 6,
                                                                  ),
                                                                  Text(
                                                                    "Recommendation: ${userProfile.value.data!
                                                                        .myRequest![index].reviewCount.toString()}",
                                                                    style: GoogleFonts.mulish(
                                                                        fontWeight: FontWeight.w500,
                                                                        // letterSpacing: 1,
                                                                        fontSize: 12,
                                                                        color: const Color(0xFF3797EF)),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  userProfile.value.data!
                                                                      .myRequest![index].minPrice
                                                                      .toString()
                                                                      .isNotEmpty
                                                                      ? const Text("Min Price")
                                                                      : const Text('No Budget'),
                                                                  userProfile.value.data!
                                                                      .myRequest![index].minPrice
                                                                      .toString()
                                                                      .isNotEmpty
                                                                      ? Text(
                                                                    userProfile.value.data!
                                                                        .myRequest![index].minPrice
                                                                        .toString(),
                                                                  )
                                                                      : const SizedBox(),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                width: 30,
                                                              ),
                                                              Column(
                                                                children: [
                                                                  userProfile.value.data!
                                                                      .myRequest![index].maxPrice
                                                                      .toString()
                                                                      .isNotEmpty
                                                                      ? const Text("Max Price")
                                                                      : const SizedBox(),
                                                                  userProfile.value.data!
                                                                      .myRequest![index].maxPrice
                                                                      .toString()
                                                                      .isNotEmpty
                                                                      ? Text(
                                                                    userProfile.value.data!
                                                                        .myRequest![index].maxPrice
                                                                        .toString(),
                                                                  )
                                                                      : const SizedBox(),
                                                                ],
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 20,),
                                                // Container(
                                                //   padding: const EdgeInsets.all(10),
                                                //   decoration: BoxDecoration(
                                                //       color: Colors.white,
                                                //       borderRadius: BorderRadius.circular(10),
                                                //       boxShadow: [
                                                //         BoxShadow(
                                                //           color: const Color(0xFF5F5F5F).withOpacity(0.2),
                                                //           offset: const Offset(0.0, 0.2),
                                                //           blurRadius: 2,
                                                //         ),
                                                //       ]),
                                                //   child: Column(
                                                //     mainAxisAlignment: MainAxisAlignment.start,
                                                //     crossAxisAlignment: CrossAxisAlignment.start,
                                                //     children: [
                                                //       Row(
                                                //         children: [
                                                //           ClipOval(
                                                //             child: CachedNetworkImage(
                                                //               width: 30,
                                                //               height: 30,
                                                //               fit: BoxFit.cover,
                                                //               imageUrl: userProfile.value.data!.myRequest![index]
                                                //                   .userId!.profileImage
                                                //                   .toString(),
                                                //               placeholder: (context, url) =>
                                                //                   Image.asset(AppAssets.girl),
                                                //               errorWidget: (context, url, error) =>
                                                //                   Image.asset(AppAssets.girl),
                                                //             ),
                                                //           ),
                                                //           const SizedBox(
                                                //             width: 20,
                                                //           ),
                                                //           Expanded(
                                                //             child: Column(
                                                //               mainAxisAlignment: MainAxisAlignment.start,
                                                //               crossAxisAlignment: CrossAxisAlignment.start,
                                                //               children: [
                                                //                 userProfile.value.data!.myRequest![index].userId!
                                                //                     .name
                                                //                     .toString() ==
                                                //                     ""
                                                //                     ? Text(
                                                //                   "Name...",
                                                //                   style: GoogleFonts.mulish(
                                                //                       fontWeight: FontWeight.w700,
                                                //                       // letterSpacing: 1,
                                                //                       fontSize: 14,
                                                //                       color: Colors.black),
                                                //                 )
                                                //                     : Text(
                                                //                   userProfile.value.data!.myRequest![index]
                                                //                       .userId!.name
                                                //                       .toString(),
                                                //                   style: GoogleFonts.mulish(
                                                //                       fontWeight: FontWeight.w700,
                                                //                       // letterSpacing: 1,
                                                //                       fontSize: 14,
                                                //                       color: Colors.black),
                                                //                 ),
                                                //                 // Row(
                                                //                 //   crossAxisAlignment: CrossAxisAlignment.start,
                                                //                 //   children: [
                                                //                 //
                                                //                 //     const SizedBox(
                                                //                 //       height: 15,
                                                //                 //       child: VerticalDivider(
                                                //                 //         width: 8,
                                                //                 //         thickness: 1,
                                                //                 //         color: Colors.grey,
                                                //                 //       ),
                                                //                 //     ),
                                                //                 //     Text(
                                                //                 //       "3 Hour",
                                                //                 //       style: GoogleFonts.mulish(
                                                //                 //           fontWeight: FontWeight.w300,
                                                //                 //           // letterSpacing: 1,
                                                //                 //           fontSize: 12,
                                                //                 //           color: const Color(0xFF878D98)),
                                                //                 //     ),
                                                //                 //   ],
                                                //                 // )
                                                //               ],
                                                //             ),
                                                //           ),
                                                //           SvgPicture.asset(AppAssets.bookmark),
                                                //         ],
                                                //       ),
                                                //       const SizedBox(
                                                //         height: 15,
                                                //       ),
                                                //       CachedNetworkImage(
                                                //         width: size.width,
                                                //         height: 200,
                                                //         fit: BoxFit.fill,
                                                //         imageUrl: userProfile.value.data!.myRequest![index].image
                                                //             .toString(),
                                                //         placeholder: (context, url) =>
                                                //             Image.asset(AppAssets.picture),
                                                //         errorWidget: (context, url, error) =>
                                                //             Image.asset(AppAssets.picture),
                                                //       ),
                                                //       const SizedBox(
                                                //         height: 10,
                                                //       ),
                                                //       Text(
                                                //         userProfile.value.data!.myRequest![index].title
                                                //             .toString(),
                                                //         style: GoogleFonts.mulish(
                                                //             fontWeight: FontWeight.w700,
                                                //             // letterSpacing: 1,
                                                //             fontSize: 17,
                                                //             color: Colors.black),
                                                //       ),
                                                //       const SizedBox(
                                                //         height: 10,
                                                //       ),
                                                //       Text(
                                                //         userProfile.value.data!.myRequest![index].description
                                                //             .toString(),
                                                //         style: GoogleFonts.mulish(
                                                //             fontWeight: FontWeight.w300,
                                                //             // letterSpacing: 1,
                                                //             fontSize: 14,
                                                //             color: const Color(0xFF6F7683)),
                                                //       ),
                                                //       const SizedBox(
                                                //         height: 10,
                                                //       ),
                                                //       // Container(
                                                //       //   padding: const EdgeInsets.all(5),
                                                //       //   width: 180,
                                                //       //   height: 30,
                                                //       //   decoration: BoxDecoration(
                                                //       //     color: const Color(0xFF3797EF).withOpacity(.09),
                                                //       //     borderRadius: BorderRadius.circular(10),
                                                //       //   ),
                                                //       //   child: Row(
                                                //       //     children: [
                                                //       //       SvgPicture.asset(AppAssets.message),
                                                //       //       const SizedBox(
                                                //       //         width: 6,
                                                //       //       ),
                                                //       //       Text(
                                                //       //         "Recommendations: 120",
                                                //       //         style: GoogleFonts.mulish(
                                                //       //             fontWeight: FontWeight.w500,
                                                //       //             // letterSpacing: 1,
                                                //       //             fontSize: 12,
                                                //       //             color: const Color(0xFF3797EF)),
                                                //       //       ),
                                                //       //     ],
                                                //       //   ),
                                                //       // ),
                                                //       const SizedBox(
                                                //         height: 10,
                                                //       ),
                                                //     ],
                                                //   ),
                                                // ),
                                                const SizedBox(
                                                  height: 15,
                                                )
                                              ],
                                            );
                                          }),
                                      const SizedBox(
                                        height: 350,
                                      )
                                    ],
                                  )
                                      : statusOfUser.value.isError
                                      ? CommonErrorWidget(
                                    errorText: "",
                                    onTap: () {},
                                  )
                                      : const Center(child: CircularProgressIndicator());
                                })
                              ],
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SizedBox(
                                    height: size.height * .15,
                                    child: Obx(() {
                                      return statusOfUser.value.isSuccess
                                          ? ListView.builder(
                                          itemCount: userProfile.value.data!.myCategories!.length,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          physics: const AlwaysScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  if(userProfile.value.data!.myCategories!.isEmpty)
                                                    Text("No Record Found "),
                                                  GestureDetector(
                                                    onTap: () {
                                                      // profileController.categoriesController.text = item.name.toString();
                                                      // profileController.idController.text = item.id.toString();
                                                      // Get.back();
                                                    },
                                                    child: ClipOval(
                                                      child: CachedNetworkImage(
                                                        width: 70,
                                                        height: 70,
                                                        fit: BoxFit.fill,
                                                        imageUrl: userProfile
                                                            .value.data!.myCategories![index].image
                                                            .toString(),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    userProfile.value.data!.myCategories![index].name.toString(),
                                                    style: GoogleFonts.mulish(
                                                        fontWeight: FontWeight.w300,
                                                        // letterSpacing: 1,
                                                        fontSize: 14,
                                                        color: Color(0xFF26282E)),
                                                  )
                                                ],
                                              ),
                                            );
                                          })
                                          : statusOfUser.value.isError
                                          ? CommonErrorWidget(
                                        errorText: "",
                                        onTap: () {},
                                      )
                                          : const Center(child: CircularProgressIndicator());
                                    })),
                                GridView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,

                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    // Number of columns
                                    crossAxisSpacing: 8.0,
                                    // Spacing between columns
                                    mainAxisSpacing: 2.0, // Spacing between rows
                                  ),
                                  itemCount: userProfile.value.data!.myRecommandation!.length,
                                  // Total number of items
                                  itemBuilder: (BuildContext context, int index) {
                                    // You can replace the Container with your image widget
                                    return

                                      Column(
                                        children: [
                                          if(userProfile.value.data!.myRecommandation!.isEmpty)
                                            Text("No Record Found "),
                                          GestureDetector(
                                          onTap: () {
                                            Get.toNamed(
                                              MyRouters.singleScreen,
                                              arguments: [
                                                userProfile.value.data!.myRecommandation![index].image.toString(),
                                                userProfile.value.data!.myRecommandation![index].title.toString(),
                                                userProfile.value.data!.myRecommandation![index].review.toString(),
                                                userProfile.value.data!.myRecommandation![index].id.toString(),
                                                userProfile.value.data!.myRecommandation![index].link.toString(),
                                              ],
                                            );
                                            print("object");
                                          },
                                          child: CachedNetworkImage(
                                            imageUrl: userProfile.value.data!.myRecommandation![index].image.toString(),
                                            width: 60,
                                            height: 60,
                                          ),
                                                                              ),
                                        ],
                                      );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        // SingleChildScrollView(
                        //   physics:
                        //   const AlwaysScrollableScrollPhysics(),
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Column(
                        //       mainAxisAlignment:
                        //       MainAxisAlignment.start,
                        //       crossAxisAlignment:
                        //       CrossAxisAlignment.start,
                        //       children: [
                        //         Obx(() {
                        //           return statusOfUser
                        //               .value
                        //               .isSuccess
                        //               ? Column(
                        //             children: [
                        //               ListView.builder(
                        //                   shrinkWrap: true,
                        //                   itemCount:
                        //                   userProfile
                        //                       .value
                        //                       .data!
                        //                       .saveRecommandation!
                        //                       .length,
                        //                   physics:
                        //                   const NeverScrollableScrollPhysics(),
                        //                   itemBuilder:
                        //                       (context, index) {
                        //                     return Column(
                        //                       children: [
                        //                         Container(
                        //                           padding:
                        //                           const EdgeInsets
                        //                               .all(
                        //                               10),
                        //                           decoration: BoxDecoration(
                        //                               color: Colors
                        //                                   .white,
                        //                               borderRadius:
                        //                               BorderRadius.circular(
                        //                                   10),
                        //                               boxShadow: [
                        //                                 BoxShadow(
                        //                                   color:
                        //                                   const Color(0xFF5F5F5F).withOpacity(0.2),
                        //                                   offset: const Offset(
                        //                                       0.0,
                        //                                       0.2),
                        //                                   blurRadius:
                        //                                   2,
                        //                                 ),
                        //                               ]),
                        //                           child: Column(
                        //                             mainAxisAlignment:
                        //                             MainAxisAlignment
                        //                                 .start,
                        //                             crossAxisAlignment:
                        //                             CrossAxisAlignment
                        //                                 .start,
                        //                             children: [
                        //                               Row(
                        //                                 children: [
                        //                                   ClipOval(
                        //                                     child:
                        //                                     CachedNetworkImage(
                        //                                       width: 30,
                        //                                       height: 30,
                        //                                       fit: BoxFit.cover,
                        //                                       imageUrl: userProfile.value.data!.myRequest![index].userId!.profileImage.toString(),
                        //                                       placeholder: (context, url) => Image.asset(AppAssets.girl),
                        //                                       errorWidget: (context, url, error) => Image.asset(AppAssets.girl),
                        //                                     ),
                        //                                   ),
                        //                                   const SizedBox(
                        //                                     width:
                        //                                     20,
                        //                                   ),
                        //                                   Expanded(
                        //                                     child:
                        //                                     Column(
                        //                                       mainAxisAlignment: MainAxisAlignment.start,
                        //                                       crossAxisAlignment: CrossAxisAlignment.start,
                        //                                       children: [
                        //                                         userProfile.value.data!.myRequest![index].userId!.name.toString() == ""
                        //                                             ? Text(
                        //                                           "Name...",
                        //                                           style: GoogleFonts.mulish(
                        //                                               fontWeight: FontWeight.w700,
                        //                                               // letterSpacing: 1,
                        //                                               fontSize: 14,
                        //                                               color: Colors.black),
                        //                                         )
                        //                                             : Text(
                        //                                           userProfile.value.data!.myRequest![index].userId!.name.toString(),
                        //                                           style: GoogleFonts.mulish(
                        //                                               fontWeight: FontWeight.w700,
                        //                                               // letterSpacing: 1,
                        //                                               fontSize: 14,
                        //                                               color: Colors.black),
                        //                                         ),
                        //                                         Row(
                        //                                           crossAxisAlignment: CrossAxisAlignment.start,
                        //                                           children: [
                        //                                             Expanded(
                        //                                                 child: userProfile.value.data!.myRequest![index].userId!.address.toString() == ""
                        //                                                     ? Text(
                        //                                                   "address...",
                        //                                                   style: GoogleFonts.mulish(
                        //                                                       fontWeight: FontWeight.w400,
                        //                                                       // letterSpacing: 1,
                        //                                                       fontSize: 14,
                        //                                                       color: const Color(0xFF878D98)),
                        //                                                 )
                        //                                                     : Text(
                        //                                                   userProfile.value.data!.myRequest![index].userId!.address.toString(),
                        //                                                   style: GoogleFonts.mulish(
                        //                                                       fontWeight: FontWeight.w400,
                        //                                                       // letterSpacing: 1,
                        //                                                       fontSize: 14,
                        //                                                       color: const Color(0xFF878D98)),
                        //                                                 )),
                        //                                             const SizedBox(
                        //                                               height: 15,
                        //                                               child: VerticalDivider(
                        //                                                 width: 8,
                        //                                                 thickness: 1,
                        //                                                 color: Colors.grey,
                        //                                               ),
                        //                                             ),
                        //                                             Text(
                        //                                               "3 Hour",
                        //                                               style: GoogleFonts.mulish(
                        //                                                   fontWeight: FontWeight.w300,
                        //                                                   // letterSpacing: 1,
                        //                                                   fontSize: 12,
                        //                                                   color: const Color(0xFF878D98)),
                        //                                             ),
                        //                                           ],
                        //                                         )
                        //                                       ],
                        //                                     ),
                        //                                   ),
                        //                                   SvgPicture.asset(
                        //                                       AppAssets.bookmark),
                        //                                 ],
                        //                               ),
                        //                               const SizedBox(
                        //                                 height:
                        //                                 15,
                        //                               ),
                        //                               Stack(
                        //                                   children: [
                        //                                     CachedNetworkImage(
                        //                                       width: size.width,
                        //                                       height: 200,
                        //                                       fit: BoxFit.fill,
                        //                                       imageUrl: userProfile.value.data!.saveRecommandation![index].post!.image.toString(),
                        //                                       placeholder: (context, url) => Image.asset(AppAssets.picture),
                        //                                       errorWidget: (context, url, error) => Image.asset(AppAssets.picture),
                        //                                     ),
                        //                                     Positioned(
                        //                                         right: 10,
                        //                                         top: 15,
                        //                                         child: Container(
                        //                                           padding: const EdgeInsets.all(6),
                        //                                           decoration: (BoxDecoration(
                        //                                             color: Colors.white,
                        //                                             borderRadius: BorderRadius.circular(15),
                        //                                           )),
                        //                                           child: Row(
                        //                                             children: [
                        //                                               const Icon(
                        //                                                 Icons.remove_red_eye_outlined,
                        //                                                 size: 20,
                        //                                               ),
                        //                                               Text(
                        //                                                 " Views " + userProfile.value.data!.saveRecommandation![index].post!.review.toString(),
                        //                                                 style: GoogleFonts.mulish(
                        //                                                     fontWeight: FontWeight.w500,
                        //                                                     // letterSpacing: 1,
                        //                                                     fontSize: 12,
                        //                                                     color: Colors.black),
                        //                                               ),
                        //                                             ],
                        //                                           ),
                        //                                         ))
                        //                                   ]),
                        //                               const SizedBox(
                        //                                 height:
                        //                                 10,
                        //                               ),
                        //                               Text(
                        //                                 userProfile
                        //                                     .value
                        //                                     .data!
                        //                                     .saveRecommandation![index]
                        //                                     .post!
                        //                                     .title
                        //                                     .toString(),
                        //                                 style: GoogleFonts.mulish(
                        //                                     fontWeight: FontWeight.w700,
                        //                                     // letterSpacing: 1,
                        //                                     fontSize: 17,
                        //                                     color: Colors.black),
                        //                               ),
                        //                               const SizedBox(
                        //                                 height:
                        //                                 10,
                        //                               ),
                        //                               GestureDetector(
                        //                                 onTap:
                        //                                     () async {
                        //                                   //output: Hello%20Flutter
                        //                                   Uri mail =
                        //                                   Uri.parse(
                        //                                     "https://" +
                        //                                         userProfile.value.data!.saveRecommandation![index].post!.link.toString(),
                        //                                   );
                        //                                   if (await launchUrl(
                        //                                       mail)) {
                        //                                     //email app opened
                        //                                   } else {
                        //                                     //email app is not opened
                        //                                   }
                        //                                 },
                        //                                 child:
                        //                                 Text(
                        //                                   userProfile
                        //                                       .value
                        //                                       .data!
                        //                                       .saveRecommandation![index]
                        //                                       .post!
                        //                                       .link
                        //                                       .toString(),
                        //                                   style: GoogleFonts.mulish(
                        //                                       fontWeight: FontWeight.w300,
                        //                                       decoration: TextDecoration.underline,
                        //                                       // letterSpacing: 1,
                        //                                       fontSize: 14,
                        //                                       color: const Color(0xFF6F7683)),
                        //                                 ),
                        //                               ),
                        //                               const SizedBox(
                        //                                 height:
                        //                                 10,
                        //                               ),
                        //                             ],
                        //                           ),
                        //                         ),
                        //                         const SizedBox(
                        //                           height: 15,
                        //                         )
                        //                       ],
                        //                     );
                        //                   }),
                        //               const SizedBox(
                        //                 height: 350,
                        //               )
                        //             ],
                        //           )
                        //               : statusOfUser
                        //               .value
                        //               .isError
                        //               ? CommonErrorWidget(
                        //             errorText: "",
                        //             onTap: () {},
                        //           )
                        //               : const Center(
                        //               child:
                        //               CircularProgressIndicator());
                        //         })
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ]),
                    ),
                  ],
                )
                    : statusOfUser.value.isError
                    ? CommonErrorWidget(
                  errorText: "",
                  onTap: () {},
                )
                    : const Center(child: Center(child: CircularProgressIndicator()));
              })),
        ),
      ),
    );
  }
  void _settingModalBottomSheet(context) {
    var size = MediaQuery.of(context).size;
    var hieght = MediaQuery.of(context).size.height;

    showModalBottomSheet(
        enableDrag: true,
        isDismissible: true,
        constraints: BoxConstraints(
          maxHeight: hieght * .9,
        ),
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.white,
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
        ),
        builder: (BuildContext context) {
          // UDE : SizedBox instead of Container for whitespaces
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Text(
                        'Recommendation List',
                        style: GoogleFonts.mulish(
                          fontWeight: FontWeight.w700,
                          // letterSpacing: 1,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                          onTap: () {
                            Get.back();
                            setState(() {});
                          },
                          child: const Icon(Icons.close)),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  statusOfReviewList.value.isSuccess
                      ? SingleChildScrollView(
                    child: Obx(() {
                      return Column(
                        children: [
                          ListView.builder(
                            physics: const ScrollPhysics(),
                            itemCount: modelReviewList.value.data!.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 8.0, top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipOval(
                                      child: CachedNetworkImage(
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.cover,
                                        imageUrl: modelReviewList.value.data![index].user!.profileImage.toString(),
                                        placeholder: (context, url) => const SizedBox(),
                                        errorWidget: (context, url, error) => const SizedBox(),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                topRight: Radius.circular(10)),
                                            color: Colors.grey.withOpacity(0.2)),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  overflow: TextOverflow.ellipsis,
                                                  modelReviewList.value.data![index].user!.name.toString(),
                                                  style: GoogleFonts.mulish(
                                                    fontWeight: FontWeight.w600,
                                                    // letterSpacing: 1,
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Text(
                                                  modelReviewList.value.data![index].date.toString(),
                                                  style: GoogleFonts.mulish(
                                                    fontWeight: FontWeight.w400,
                                                    // letterSpacing: 1,
                                                    fontSize: 10,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Spacer(),
                                                GestureDetector(
                                                    onTap: () {

                                                      addRemoveLikeRepo(
                                                        context: context,
                                                        recommended_id: modelReviewList.value.data![index].id.toString(),
                                                      ).then((value) async {
                                                        // userProfile.value = value;
                                                        if (value.status == true) {
                                                          print('wishlist-----');
                                                          statusOfRemove.value = RxStatus.success();
                                                          // getReviewListRepo(context: context, id: modelReviewList.value.data![index].id.toString(),).then((value) {
                                                          //   modelReviewList.value = value;
                                                          //
                                                          //   if (value.status == true) {
                                                          //     statusOfReviewList.value = RxStatus.success();
                                                          //   } else {
                                                          //     statusOfReviewList.value = RxStatus.error();
                                                          //   }
                                                          //   setState(() {});
                                                          // });
                                                          // like=true;
                                                          showToast(value.message.toString());
                                                        } else {
                                                          statusOfRemove.value = RxStatus.error();
                                                          // like=false;
                                                          showToast(value.message.toString());
                                                        }
                                                      });  setState(() {
                                                      });// home.value.data!.discover![index].wishlist.toString();
                                                    },
                                                    child: modelReviewList.value.data![index].isLike ==
                                                        true
                                                        ?  SvgPicture.asset(AppAssets.heart,height: 26,)
                                                        :
                                                    const Image(
                                                      image: AssetImage('assets/icons/1814104_favorite_heart_like_love_icon 3.png'),
                                                      height: 25,
                                                    )

                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: size.height * .02,
                                            ),
                                            Text(
                                              modelReviewList.value.data![index].review.toString(),
                                              style: GoogleFonts.mulish(
                                                fontWeight: FontWeight.w600,
                                                // letterSpacing: 1,
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            modelReviewList.value.data![index].link == ""
                                                ? SizedBox()
                                                : GestureDetector(
                                              onTap: () {
                                                launchURL(
                                                  modelReviewList.value.data![index].link.toString(),
                                                );
                                              },
                                              child: Text(
                                                modelReviewList.value.data![index].link.toString(),
                                                style: GoogleFonts.mulish(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: Color(0xFF3797EF)),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            modelReviewList.value.data![index].image == ""
                                                ? const SizedBox()
                                                : ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                width: size.width,
                                                height: 200,
                                                fit: BoxFit.fill,
                                                imageUrl: modelReviewList.value.data![index].image.toString(),
                                                placeholder: (context, url) => const SizedBox(
                                                  height: 0,
                                                ),
                                                errorWidget: (context, url, error) => const SizedBox(
                                                  height: 0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(MyRouters.addRecommendationScreen);
                            },
                            child: const CommonButton(title: "Send Recommendation"),
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      );
                    }),
                  )
                      : const Center(child: Text('No Data Available')),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          );
        });
  }
}
