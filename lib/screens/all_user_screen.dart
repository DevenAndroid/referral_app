import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:referral_app/routers/routers.dart';
import 'package:referral_app/screens/recommendation_single_page.dart';
import 'package:referral_app/screens/users_category_list.dart';
import 'package:referral_app/widgets/app_assets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/get_comment_controller.dart';
import '../controller/get_recommendation_controller.dart';
import '../controller/homeController.dart';
import '../controller/profile_controller.dart';
import '../models/add_remove_recommendation.dart';
import '../models/categories_model.dart';
import '../models/get_comment_model.dart';
import '../models/home_page_model.dart';
import '../models/model_review_list.dart';
import '../models/model_user_profile.dart';
import '../models/single_product_model.dart';
import '../repositories/add_comment_repo.dart';
import '../repositories/add_remove_follow_repo.dart';
import '../repositories/categories_repo.dart';
import '../repositories/get_comment_repo.dart';
import '../repositories/get_user_profile.dart';
import '../repositories/home_pafe_repo.dart';
import '../repositories/remove_bookmark_repo.dart';
import '../repositories/repo_add_like.dart';
import '../repositories/repo_delete_recomm.dart';
import '../repositories/repo_review_list.dart';
import '../repositories/single_produc_repo.dart';
import '../resourses/api_constant.dart';
import '../widgets/app_theme.dart';
import '../widgets/common_error_widget.dart';
import '../widgets/custome_textfiled.dart';
import 'comment_screen.dart';
import 'get_recommendation_ui.dart';
import 'my_recommendation_category.dart';

class AllUserProfileScreen extends StatefulWidget {
  const AllUserProfileScreen({super.key});

  @override
  State<AllUserProfileScreen> createState() => AllUserProfileScreenState();
}

class AllUserProfileScreenState extends State<AllUserProfileScreen> with SingleTickerProviderStateMixin {
  Rx<ModelAddRemoveFollow> modalRemove = ModelAddRemoveFollow().obs;
  Rx<RxStatus> statusOfReviewList = RxStatus.empty().obs;
  Rx<ModelReviewList> modelReviewList = ModelReviewList().obs;
  final profileController = Get.put(ProfileController());
  final getCommentController = Get.put(GetCommentController());
  Rx<RxStatus> statusOfRemove = RxStatus
      .empty()
      .obs;

  var id = Get.arguments[0];

  Rx<GetCommentModel> getCommentModel = GetCommentModel().obs;
  Rx<RxStatus> statusOfGetComment = RxStatus.empty().obs;
  final homeController = Get.put(HomeController());
  String postId = '';
  String post = '';
  String post1 = '';

  final getRecommendationController = Get.put(GetRecommendationController());

  // getComments(id) {
  //   // modelReviewList.value.data!.clear();
  //   print('id isss...${id.toString()}');
  //   getCommentRepo(
  //       context: context,
  //       id: id, type: 'recommandation')
  //       .then((value) {
  //     getCommentModel.value = value;
  //     if (value.status == true) {
  //       statusOfGetComment.value = RxStatus.success();
  //       commentBottomSheetReco(context);
  //     } else {
  //       statusOfGetComment.value = RxStatus.error();
  //     }
  //
  //     setState(() {});
  //   });
  // }
  SampleItem? selectedMenu;
  reviewList(id) {
    getReviewListRepo(context: context, id: id).then((value) {
      modelReviewList.value = value;

      if (value.status == true) {
        statusOfReviewList.value = RxStatus.success();
      } else {
        statusOfReviewList.value = RxStatus.error();
      }
      setState(() {});
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
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_tabListener);
    // Get.arguments[0];
    // profileController.getData();
    profileController.checkForUser = false;
    profileController.idUserPro = id;
    profileController.UserProfile();
    reviewList(id);
    // chooseCategories1();
  }


  Rx<RxStatus> statusOfSingle = RxStatus.empty().obs;
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
              physics: const NeverScrollableScrollPhysics(),
              child: Obx(() {
                if(profileController.refreshUserCat.value > 0){}
                return profileController.statusOfUser.value.isSuccess
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
                                    child: const Icon(Icons.arrow_back)),
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
                                        imageUrl: profileController.userProfile.value.data!.user!.profileImage.toString(),
                                        placeholder: (context, url) => const SizedBox(),
                                        errorWidget: (context, url, error) => const SizedBox(),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(MyRouters.singlePostScreen,
                                        arguments: [profileController.userProfile.value.data!.user!.postCount.toString()]);
                                  },
                                  child: Column(
                                    children: [
                                      Text(profileController.userProfile.value.data!.user!.postCount.toString(),
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
                                    Get.toNamed(MyRouters.followingScreenUser, arguments: [
                                      profileController.userProfile.value.data!.user!.followersCount.toString(),
                                      profileController.userProfile.value.data!.user!.followingCount.toString(),
                                      profileController.userProfile.value.data!.user!.id.toString(),
                                    ]);
                                  },
                                  child: Column(
                                    children: [
                                      Text(profileController.userProfile.value.data!.user!.followersCount.toString(),
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
                                    Get.toNamed(MyRouters.followingScreenUser, arguments: [
                                      profileController.userProfile.value.data!.user!.followersCount.toString(),
                                      profileController.userProfile.value.data!.user!.followingCount.toString(),
                                      profileController.userProfile.value.data!.user!.id.toString(),
                                    ]);
                                  },
                                  child: Column(
                                    children: [
                                      Text(profileController.userProfile.value.data!.user!.followingCount.toString(),
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
                                Text(profileController.userProfile.value.data!.user!.name!.capitalizeFirst.toString(),
                                    style: GoogleFonts.mulish(
                                        fontWeight: FontWeight.w700, fontSize: 20, color: const Color(0xFF262626))),
                                const Spacer(),
                                profileController.userProfile.value.data!.user!.myAccount == false ?
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Obx(() {
                                    return SizedBox(
                                        width: 120,
                                        height: 35,
                                        child: CommonButton(
                                          title: profileController.userProfile.value.data!.user!.isFollow == true
                                              ? "Following" : "Follow",
                                          onPressed: () {
                                            addRemoveRepo(
                                              context: context,
                                              following_id: profileController.userProfile.value.data!.user!.id.toString(),
                                            ).then((value) async {
                                              // userProfile.value = value;
                                              if (value.status == true) {
                                                print('wishlist-----');
                                                statusOfRemove.value = RxStatus.success();
                                                //homeController.getPaginate();
                                                 profileController.UserProfile();
                                                // like=true;
                                                showToast(value.message.toString());
                                              } else {
                                                statusOfRemove.value = RxStatus.error();
                                                // like=false;
                                                showToast(value.message.toString());
                                              }
                                            });
                                            setState(() {
                                              if (profileController.userProfile.value.data!.user!.isFollow == false) {
                                                profileController.userProfile.value.data!.user!.isFollow = true;
                                              } else {
                                                profileController.userProfile.value.data!.user!.isFollow = false;
                                              }
                                            });
                                          },
                                        ));
                                  }),
                                ) : const SizedBox()
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
                                labelColor:  const Color(0xFF3797EF),
                                unselectedLabelColor: Colors.black,
                                dividerColor: Colors.transparent,
                                physics: const AlwaysScrollableScrollPhysics(),
                                // indicatorSize: TabBarIndicatorSize.tab,
                                indicatorColor: AppTheme.primaryColor,
                                tabAlignment: TabAlignment.start,
                                // automaticIndicatorColorAdjustment: true,
                                onTap: (value) {
                                  currentDrawer = value;
                                  setState(() {});
                                  print(currentDrawer);
                                },
                                tabs: [
                                  Tab(
                                    child: Text(
                                      '${profileController.userProfile.value.data!.user!.name!.capitalizeFirst.toString()} Requests',
                                        // "Recco Feed",
                                        style: GoogleFonts.mulish(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        )
                                      // currentDrawer == 0
                                      //     ? GoogleFonts.mulish(
                                      //     fontWeight: FontWeight.w400,
                                      //     fontSize: 14,
                                      //     color: const Color(0xFF3797EF))
                                      //     : GoogleFonts.mulish(
                                      //     fontWeight: FontWeight.w400,
                                      //     fontSize: 14,
                                      //     color: Colors.black)
                                    ),
                                  ),
                                  Tab(
                                    child: Text("${profileController.userProfile.value.data!.user!.name!.capitalizeFirst.toString()} Recommendations",
                                        style: GoogleFonts.mulish(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        )
                                      // style: currentDrawer == 1
                                      //     ? GoogleFonts.mulish(
                                      //     fontWeight: FontWeight.w400,
                                      //     fontSize: 14,
                                      //     color: const Color(0xFF3797EF))
                                      //     : GoogleFonts.mulish(
                                      //     fontWeight: FontWeight.w400,
                                      //     fontSize: 14,
                                      //     color: Colors.black)
                                    ),
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
                                  return profileController.statusOfUser.value.isSuccess
                                      ? Column(
                                    children: [
                                      if (profileController.userProfile.value.data!.myRequest!.isEmpty)
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: Get.height / 5),
                                          child: Center(
                                              child: Text(
                                                'No Data Found',
                                                style: GoogleFonts.mulish(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              )),
                                        ),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: profileController.userProfile.value.data!.myRequest!.length,
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
                                                                imageUrl: profileController.userProfile.value.data!
                                                                    .myRequest![index].userId ==
                                                                    null
                                                                    ? AppAssets.man
                                                                    : profileController.userProfile.value.data!
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
                                                              profileController.userProfile.value.data!
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
                                                                profileController.userProfile.value.data!
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
                                                                child: profileController.userProfile.value.data!
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
                                                                  profileController.userProfile.value.data!
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
                                                      profileController.userProfile.value.data!
                                                          .myRequest![index].image == ""
                                                          ? const SizedBox()
                                                          : ClipRRect(
                                                        borderRadius: BorderRadius.circular(10),
                                                        child: CachedNetworkImage(
                                                          width: size.width,
                                                          height: 200,
                                                          fit: BoxFit.fill,
                                                          imageUrl: profileController.userProfile.value.data!
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
                                                        profileController.userProfile.value.data!
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
                                                        profileController.userProfile.value.data!
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
                                                        children: [
                                                          Column(
                                                            children: [
                                                              profileController.userProfile.value.data!
                                                                  .myRequest![index].minPrice
                                                                  .toString()
                                                                  .isNotEmpty
                                                                  ? const Text("Min Price")
                                                                  : const Text('No Budget'),
                                                              profileController.userProfile.value.data!
                                                                  .myRequest![index].minPrice
                                                                  .toString()
                                                                  .isNotEmpty
                                                                  ? Text(
                                                                profileController.userProfile.value.data!
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
                                                              profileController.userProfile.value.data!
                                                                  .myRequest![index].maxPrice
                                                                  .toString()
                                                                  .isNotEmpty
                                                                  ? const Text("Max Price")
                                                                  : const SizedBox(),
                                                              profileController.userProfile.value.data!
                                                                  .myRequest![index].maxPrice
                                                                  .toString()
                                                                  .isNotEmpty
                                                                  ? Text(
                                                                profileController.userProfile.value.data!
                                                                    .myRequest![index].maxPrice
                                                                    .toString(),
                                                              )
                                                                  : const SizedBox(),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: GestureDetector(
                                                              onTap: () {
                                                                // setState(() {
                                                                //   getReviewListRepo(
                                                                //       context: context,
                                                                //       id: profileController.userProfile.value.data!.myRequest![index].id.toString())
                                                                //       .then((value) {
                                                                //     modelReviewList.value = value;
                                                                //     if (value.status == true) {
                                                                //       statusOfReviewList.value = RxStatus.success();
                                                                //       post1 = profileController.userProfile.value.data!.myRequest![index].id.toString();
                                                                //       _settingModalBottomSheet(context);
                                                                //     } else {
                                                                //       statusOfReviewList.value = RxStatus.error();
                                                                //     }
                                                                //     setState(() {});
                                                                //   });
                                                                // });
                                                                setState(() {
                                                                  getRecommendationController.idForReco = profileController.userProfile.value.data!.myRequest![index].id.toString();
                                                                  getRecommendationController.idForAskReco = profileController.userProfile.value.data!.myRequest![index].id.toString();
                                                                  _settingModalBottomSheet(context);
                                                                });
                                                              },
                                                              child: Container(
                                                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                  color: const Color(0xFF3797EF).withOpacity(.09),
                                                                  borderRadius: BorderRadius.circular(5),
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    SvgPicture.asset(
                                                                      AppAssets.message,
                                                                      height: 16,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 6,
                                                                    ),
                                                                    Expanded(
                                                                      child: FittedBox(
                                                                        child: Text(
                                                                          "Recommendation: ${profileController.userProfile.value.data!.myRequest![index].reviewCount.toString()}",
                                                                          maxLines: 2,
                                                                          overflow: TextOverflow.ellipsis,
                                                                          style: GoogleFonts.mulish(
                                                                              fontWeight: FontWeight.w500,
                                                                              // letterSpacing: 1,
                                                                              fontSize: 12,
                                                                              color: const Color(0xFF3797EF)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Expanded(
                                                            child: GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  getCommentController.id = profileController.userProfile.value.data!.myRequest![index].id.toString();
                                                                  getCommentController.type = 'askrecommandation';
                                                                  commentBottomSheet(context);
                                                                  print('Id Is....${profileController.userProfile.value.data!
                                                                      .myRequest![index].id.toString()}');
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
                                                                    SvgPicture.asset(
                                                                      AppAssets.message,
                                                                      height: 16,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 6,
                                                                    ),
                                                                    Text(
                                                                      "Comments:   ${profileController.userProfile.value.data!
                                                                          .myRequest![index].commentCount.toString()}",
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
                                                          ),
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
                                      : profileController.statusOfUser.value.isError
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height: size.height * .15,
                                    child: Obx(() {
                                      return profileController.statusOfUser.value.isSuccess
                                          ? SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(()=> const UsersCategoryList());
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom: 20),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(10),
                                                      decoration: BoxDecoration(border: Border.all(color: AppTheme.primaryColor), shape: BoxShape.circle),
                                                      child: ClipOval(
                                                        child: Image.asset('assets/images/categoryList.png',width: 35,),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      'Category list',
                                                      // maxLines: 2,
                                                      textAlign: TextAlign.center,
                                                      style: GoogleFonts.mulish(
                                                          fontWeight: FontWeight.w300,
                                                          // letterSpacing: 1,
                                                          fontSize: 14,
                                                          color: const Color(0xFF26282E)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 18,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                profileController.checkForUser = false;
                                                setState(() {});
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom: 20),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(10),
                                                      decoration: BoxDecoration(border: Border.all(color: AppTheme.primaryColor), shape: BoxShape.circle),
                                                      child: ClipOval(
                                                        child: Image.asset('assets/images/viewAll.png',width: 35,),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      'View All',
                                                      // maxLines: 2,
                                                      textAlign: TextAlign.center,
                                                      style: GoogleFonts.mulish(
                                                          fontWeight: FontWeight.w300,
                                                          // letterSpacing: 1,
                                                          fontSize: 14,
                                                          color: const Color(0xFF26282E)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 18,
                                            ),
                                            if(profileController.checkForUser == true)
                                              profileController.single.value.data!= null ?
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  ClipOval(
                                                    child: CachedNetworkImage(
                                                      width: 60,
                                                      height: 60,
                                                      fit: BoxFit.fill,
                                                      imageUrl: profileController.single.value.data!.categoryImage.toString(),
                                                      errorWidget: (_, __, ___) =>  const Icon(
                                                        Icons.error_outline_outlined,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  SizedBox(
                                                    width: 70,
                                                    child: Text(
                                                      profileController.single.value.data!.categoryName.toString(),
                                                      maxLines: 2,
                                                      textAlign: TextAlign.center,
                                                      style: GoogleFonts.mulish(
                                                          fontWeight: FontWeight.w300,
                                                          // letterSpacing: 1,
                                                          fontSize: 14,
                                                          color: const Color(0xFF26282E)),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                ],
                                              ) : const SizedBox(),

                                            // ListView.builder(
                                            // itemCount: profileController.userProfile.value.data!.myCategories!.length,
                                            // shrinkWrap: true,
                                            // scrollDirection: Axis.horizontal,
                                            // physics: const NeverScrollableScrollPhysics(),
                                            // itemBuilder: (context, index) {
                                            //   return Padding(
                                            //     padding: const EdgeInsets.all(0.0),
                                            //     child: Column(
                                            //       children: [
                                            //         if(profileController.userProfile.value.data!.myCategories!.isEmpty)
                                            //           Text("No Record Found "),
                                            //         GestureDetector(
                                            //           onTap: () {
                                            //
                                            //           },
                                            //           child: ClipOval(
                                            //             child: CachedNetworkImage(
                                            //               width: 60,
                                            //               height: 60,
                                            //               fit: BoxFit.fill,
                                            //               imageUrl: profileController.userProfile
                                            //                   .value.data!.myCategories![index].image
                                            //                   .toString(),
                                            //             ),
                                            //           ),
                                            //         ),
                                            //         const SizedBox(
                                            //           height: 4,
                                            //         ),
                                            //         Text(
                                            //           profileController.userProfile.value.data!.myCategories![index].name.toString(),
                                            //           style: GoogleFonts.mulish(
                                            //               fontWeight: FontWeight.w300,
                                            //               // letterSpacing: 1,
                                            //               fontSize: 14,
                                            //               color: Color(0xFF26282E)),
                                            //         )
                                            //       ],
                                            //     ),
                                            //   );
                                            // }),
                                          ],
                                        ),
                                      )
                                          : profileController.statusOfUser.value.isError
                                          ? CommonErrorWidget(
                                        errorText: "",
                                        onTap: () {},
                                      )
                                          : const Center(child: CircularProgressIndicator());
                                    })),

                                Column(
                                  children: [
                                    if (  profileController.checkForUser == true)
                                      profileController.statusOfSingle.value.isSuccess
                                          ? Column(
                                        children: [
                                          if (profileController.single.value.data!.details!.isEmpty) const Text("No Record found",style: TextStyle(
                                            color: Colors.black
                                          ),),
                                          GridView.builder(
                                            padding: EdgeInsets.zero,
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              // Number of columns
                                              crossAxisSpacing: 10.0,
                                              // Spacing between columns
                                              mainAxisSpacing: 10.0, // Spacing between rows
                                            ),
                                            itemCount: profileController.single.value.data!.details!.length,
                                            // Total number of items
                                            itemBuilder: (BuildContext context, int index) {
                                              // You can replace the Container with your image widget
                                              return GestureDetector(
                                                onTap: () {
                                                  print(
                                                    "id:::::::::::::::::::::::::::::${profileController.single.value.data!.details![index].id}",
                                                  );
                                                  Get.toNamed(
                                                    MyRouters.recommendationSingleScreen,
                                                    arguments: [
                                                      profileController.single.value.data!.details![index].id.toString(),
                                                    ],
                                                  );
                                                  print("object");
                                                },
                                                child: CachedNetworkImage(
                                                  imageUrl: profileController.single.value.data!.details![index].image.toString(),
                                                  fit: BoxFit.fill,
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      )
                                          : statusOfSingle.value.isError
                                          ? CommonErrorWidget(
                                        errorText: "",
                                        onTap: () {},
                                      )
                                          : const Center(child: SizedBox()),
                                    if (  profileController.checkForUser == false)
                                    // if (profileController.modal.value.data!.myRecommandation!.isEmpty)
                                    //   const Text("No data found "),
                                      profileController.statusOfUser.value.isSuccess
                                          ? SingleChildScrollView(
                                        child: GridView.builder(
                                          physics: const BouncingScrollPhysics(),
                                          padding: EdgeInsets.only(bottom: 50),
                                          shrinkWrap: true,

                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            // Number of columns
                                            crossAxisSpacing: 10.0,
                                            // Spacing between columns
                                            mainAxisSpacing: 10.0, // Spacing between rows
                                          ),
                                          itemCount:
                                          profileController.userProfile.value.data!.myRecommandation!.length,
                                          // Total number of items
                                          itemBuilder: (BuildContext context, int index) {
                                            // You can replace the Container with your image widget
                                            return GestureDetector(
                                              onTap: () {
                                                Get.toNamed(
                                                  MyRouters.userRecommendationSingleScreen,
                                                  arguments: [
                                                    // userProfile.value.data!.myRecommandation![index].image
                                                    //     .toString(),
                                                    // userProfile.value.data!.myRecommandation![index].title
                                                    //     .toString(),
                                                    // userProfile.value.data!.myRecommandation![index].review
                                                    //     .toString(),
                                                    profileController.userProfile.value.data!.myRecommandation![index].id
                                                        .toString(),
                                                    // userProfile.value.data!.myRecommandation![index].link
                                                    //     .toString(),
                                                  ],
                                                );
                                                print("object");
                                              },
                                              child: CachedNetworkImage(
                                                imageUrl: profileController.userProfile.value.data!.myRecommandation![index].image
                                                    .toString(),
                                                fit: BoxFit.fill,
                                                errorWidget: (_, __, ___) =>  const Icon(
                                                  Icons.error_outline_outlined,
                                                  color: Colors.red,
                                                ),),
                                            );
                                          },
                                        ),
                                      )
                                          : profileController.statusOfUser.value.isError
                                          ? CommonErrorWidget(
                                        errorText: "",
                                        onTap: () {},
                                      )
                                          : const Center(child: SizedBox()),
                                    SizedBox(
                                      height: 300,
                                    )
                                  ],
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
                    : profileController.statusOfUser.value.isError
                    ? CommonErrorWidget(
                  errorText: "",
                  onTap: () {},
                )
                    :  Padding(
                    padding: EdgeInsets.only(top : Get.height/2),
                    child: const Center(child: CircularProgressIndicator()));
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
          return const GetRecommendationScreen();
        });
  }

  void commentBottomSheet(context) {
    var size = MediaQuery
        .of(context)
        .size;
    var height = MediaQuery
        .of(context)
        .size
        .height;
    showModalBottomSheet(
        enableDrag: true,
        isDismissible: true,
        constraints: BoxConstraints(
          maxHeight: height * .7,
        ),
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.white,
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
        ),
        builder: (BuildContext context) {
          return const CommentScreen();
        });
  }

  // void commentBottomSheetReco(context) {
  //   var size = MediaQuery
  //       .of(context)
  //       .size;
  //   var height = MediaQuery
  //       .of(context)
  //       .size
  //       .height;
  //   TextEditingController commentController = TextEditingController();
  //   showModalBottomSheet(
  //       enableDrag: true,
  //       isDismissible: true,
  //       constraints: BoxConstraints(
  //         maxHeight: height * .9,
  //       ),
  //       isScrollControlled: true,
  //       context: context,
  //       backgroundColor: Colors.white,
  //       elevation: 10,
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
  //       ),
  //       builder: (BuildContext context) {
  //         // UDE : SizedBox instead of Container for whitespaces
  //         return statusOfGetComment.value.isSuccess
  //             ? SingleChildScrollView(
  //           child: Obx(() {
  //             return Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20).copyWith(
  //                   bottom: MediaQuery.of(context).viewInsets.bottom
  //               ),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: <Widget>[
  //                   Row(
  //                     children: [
  //                       Text(
  //                         'Comments List',
  //                         style: GoogleFonts.mulish(
  //                           fontWeight: FontWeight.w700,
  //                           // letterSpacing: 1,
  //                           fontSize: 18,
  //                           color: Colors.black,
  //                         ),
  //                       ),
  //                       const Spacer(),
  //                       GestureDetector(
  //                           onTap: () {
  //                             Get.back();
  //                             setState(() {});
  //                           },
  //                           child: const Icon(Icons.close)),
  //                       const SizedBox(
  //                         height: 10,
  //                       ),
  //                     ],
  //                   ),
  //                   const SizedBox(
  //                     height: 15,
  //                   ),
  //                   // statusOfReviewList.value.isSuccess
  //                   //     ?
  //                   SingleChildScrollView(
  //                       child: Column(
  //                         children: [
  //                           ListView.builder(
  //                             physics: const ScrollPhysics(),
  //                             itemCount: getCommentModel.value.data!.length,
  //                             scrollDirection: Axis.vertical,
  //                             shrinkWrap: true,
  //                             itemBuilder: (context, index) {
  //                               var item = getCommentModel.value.data![index].userId!;
  //                               var item1 = getCommentModel.value.data![index];
  //                               return Padding(
  //                                 padding: const EdgeInsets.only(left: 8.0, top: 10),
  //                                 child: Row(
  //                                   mainAxisAlignment: MainAxisAlignment.start,
  //                                   crossAxisAlignment: CrossAxisAlignment.start,
  //                                   children: [
  //                                     ClipOval(
  //                                       child: CachedNetworkImage(
  //                                         width: 30,
  //                                         height: 30,
  //                                         fit: BoxFit.cover,
  //                                         imageUrl: item.profileImage.toString(),
  //                                         placeholder: (context, url) => const SizedBox(),
  //                                         errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
  //                                       ),
  //                                     ),
  //                                     const SizedBox(
  //                                       width: 10,
  //                                     ),
  //                                     Expanded(
  //                                       child: Container(
  //                                         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
  //                                         decoration: BoxDecoration(
  //                                             borderRadius: const BorderRadius.only(
  //                                                 bottomRight: Radius.circular(10),
  //                                                 bottomLeft: Radius.circular(10),
  //                                                 topRight: Radius.circular(10)),
  //                                             color: Colors.grey.withOpacity(0.2)),
  //                                         child: Column(
  //                                           crossAxisAlignment: CrossAxisAlignment.start,
  //                                           children: [
  //                                             Row(
  //                                               crossAxisAlignment: CrossAxisAlignment.start,
  //                                               children: [
  //                                                 Text(
  //                                                   overflow: TextOverflow.ellipsis,
  //                                                   item.name.toString(),
  //                                                   style: GoogleFonts.mulish(
  //                                                     fontWeight: FontWeight.w600,
  //                                                     // letterSpacing: 1,
  //                                                     fontSize: 14,
  //                                                     color: Colors.black,
  //                                                   ),
  //                                                 ),
  //                                                 const SizedBox(
  //                                                   width: 15,
  //                                                 ),
  //                                                 Text(
  //                                                   item1.date.toString(),
  //                                                   style: GoogleFonts.mulish(
  //                                                     fontWeight: FontWeight.w400,
  //                                                     // letterSpacing: 1,
  //                                                     fontSize: 10,
  //                                                     color: Colors.black,
  //                                                   ),
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                             SizedBox(
  //                                               height: size.height * .01,
  //                                             ),
  //                                             Text(
  //                                               item1.comment.toString(),
  //                                               style: GoogleFonts.mulish(
  //                                                 fontWeight: FontWeight.w400,
  //                                                 // letterSpacing: 1,
  //                                                 fontSize: 14,
  //                                                 color: Colors.black,
  //                                               ),
  //                                             ),
  //                                             const SizedBox(
  //                                               height: 8,
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ),
  //                                     )
  //                                   ],
  //                                 ),
  //                               );
  //                             },
  //                           ),
  //                           const SizedBox(
  //                             height: 25,
  //                           ),
  //                           Container(
  //                             height: 50,
  //                             decoration: BoxDecoration(
  //                                 color: const Color(0xFF070707).withOpacity(.06),
  //                                 borderRadius: BorderRadius.circular(44)
  //                             ),
  //                             child: Padding(
  //                               padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 12).copyWith(bottom: 0),
  //                               child: CustomTextField(
  //                                 obSecure: false.obs,
  //                                 hintText: 'Type a message...'.obs,
  //                                 controller: commentController,
  //                                 suffixIcon: InkWell(
  //                                     onTap: (){
  //                                       addCommentRepo(context: context,type: 'recommandation',comment: commentController.text.trim(),postId: postId.toString()).then((value) {
  //                                         if (value.status == true) {
  //                                           showToast(value.message.toString());
  //                                           getComments(postId.toString());
  //                                           reviewList(post1.toString());
  //                                           // Get.back();
  //                                           setState(() {
  //                                             commentController.clear();
  //                                           });
  //                                         }
  //                                         else {
  //                                           showToast(value.message.toString());
  //                                         }
  //                                       });
  //                                     },
  //                                     child: Column(
  //                                       crossAxisAlignment: CrossAxisAlignment.center,
  //                                       mainAxisAlignment: MainAxisAlignment.center,
  //                                       children: [
  //                                         Image.asset('assets/images/comment_send_icon.png',width: 35,height: 35,),
  //                                       ],
  //                                     )),
  //                               ),
  //                             ),
  //                           ),
  //                           const SizedBox(
  //                             height: 20,
  //                           )
  //                         ],
  //                       )
  //                   ),
  //                   // : const Center(child: Text('No Data Available')),
  //                   const SizedBox(
  //                     height: 20,
  //                   )
  //                 ],
  //               ),
  //             );
  //           }),
  //         ) : const Center(child: Text('No Data Available'));
  //       });
  // }
}
