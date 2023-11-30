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
import '../models/categories_model.dart';
import '../models/home_page_model.dart';
import '../models/model_user_profile.dart';
import '../repositories/categories_repo.dart';
import '../repositories/get_user_profile.dart';
import '../repositories/home_pafe_repo.dart';
import '../widgets/app_theme.dart';
import '../widgets/common_error_widget.dart';
import '../widgets/custome_textfiled.dart';

class AllUserProfileScreen extends StatefulWidget {
  const AllUserProfileScreen({super.key});

  @override
  State<AllUserProfileScreen> createState() => AllUserProfileScreenState();
}

class AllUserProfileScreenState extends State<AllUserProfileScreen>
    with SingleTickerProviderStateMixin {
  Rx<RxStatus> statusOfUser = RxStatus.empty().obs;

  Rx<ModelUserProfile> userProfile = ModelUserProfile().obs;
  var id = Get.arguments[0];
  UserProfile() {
    userProfileRepo(recommandation_id: id,type: "user").then((value) {
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
      showFloatingActionButton =
          _tabController.index == 1; // 1 corresponds to "My recommendations"
    });
  }


  var currentDrawer = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: showFloatingActionButton
            ? Padding(
          padding: const EdgeInsets.symmetric(vertical: 0)
              .copyWith(bottom: 80),
          child: FloatingActionButton(
            onPressed: () {
              Get.toNamed(MyRouters.addRecommendationScreen);
            },
            backgroundColor: Colors.transparent,
            child: SvgPicture.asset(AppAssets.add1),
          ),
        )
            : const SizedBox(),
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
                              height: 20,
                            ),
                            Text("My Profile",
                                style: GoogleFonts.mulish(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: const Color(0xFF262626))),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppTheme.secondaryColor,
                                          width: 1),
                                      shape: BoxShape.circle),
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                            AppTheme.secondaryColor,
                                            width: 1),
                                        shape: BoxShape.circle),
                                    child: ClipOval(
                                      child: CachedNetworkImage(
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                        imageUrl:
                                        userProfile
                                            .value
                                            .data!
                                            .user!
                                            .profileImage
                                            .toString(),
                                        placeholder: (context, url) =>
                                        const SizedBox(),
                                        errorWidget:
                                            (context, url, error) =>
                                        const SizedBox(),
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                        userProfile
                                            .value
                                            .data!
                                            .user!
                                            .postCount
                                            .toString(),
                                        style: GoogleFonts.mulish(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                            color:
                                            const Color(0xFF000000))),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Text("Posts",
                                        style: GoogleFonts.mulish(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16,
                                            color:
                                            const Color(0xFF262626))),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(MyRouters.followingScreen,
                                        arguments: [
                                          userProfile.value
                                              .data!.user!.followersCount
                                              .toString(),
                                          userProfile.value
                                              .data!.user!.followingCount
                                              .toString(),
                                        ]);
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                          userProfile.value
                                              .data!.user!.followersCount
                                              .toString(),
                                          style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                              color: const Color(
                                                  0xFF000000))),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text("Followers",
                                          style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 16,
                                              color: const Color(
                                                  0xFF262626))),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    currentDrawer == 1;
                                    Get.toNamed(MyRouters.followingScreen,
                                        arguments: [
                                          userProfile.value
                                              .data!.user!.followersCount
                                              .toString(),
                                          userProfile.value
                                              .data!.user!.followingCount
                                              .toString(),
                                        ]);
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                          userProfile.value
                                              .data!.user!.followingCount
                                              .toString(),
                                          style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                              color: const Color(
                                                  0xFF000000))),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text("Following",
                                          style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 16,
                                              color: const Color(
                                                  0xFF262626))),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                userProfile.value.data!.user!.name
                                    .toString(),
                                style: GoogleFonts.mulish(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: const Color(0xFF262626))),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(AppAssets.call),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                    userProfile.value.data!.user!.phone
                                        .toString(),
                                    style: GoogleFonts.mulish(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16,
                                        color: const Color(0xFF262626))),
                                const Spacer(),
                                SizedBox(
                                    width: 70,
                                    height: 30,
                                    child: CommonButton(
                                      title: "Edit",
                                      onPressed: () {
                                        Get.toNamed(
                                            MyRouters.editAccount);
                                      },
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 5,
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
                                physics:
                                const AlwaysScrollableScrollPhysics(),
                                // indicatorSize: TabBarIndicatorSize.tab,
                                indicatorColor: AppTheme.primaryColor,
                                indicatorPadding:
                                const EdgeInsets.symmetric(
                                    horizontal: 12),
                                // automaticIndicatorColorAdjustment: true,
                                onTap: (value) {
                                  currentDrawer = value;
                                  setState(() {});
                                  print(currentDrawer);
                                },
                                tabs: [
                                  Tab(
                                    child: Text("My Requests",
                                        style: currentDrawer == 0
                                            ? GoogleFonts.mulish(
                                            fontWeight:
                                            FontWeight.w600,
                                            letterSpacing: 1,
                                            fontSize: 15,
                                            color: const Color(
                                                0xFF3797EF))
                                            : GoogleFonts.mulish(
                                            fontWeight:
                                            FontWeight.w600,
                                            letterSpacing: 1,
                                            fontSize: 15,
                                            color: Colors.black)),
                                  ),
                                  Tab(
                                    child: Text("My recommendations",
                                        style: currentDrawer == 1
                                            ? GoogleFonts.mulish(
                                            fontWeight:
                                            FontWeight.w600,
                                            letterSpacing: 1,
                                            fontSize: 15,
                                            color: const Color(
                                                0xFF3797EF))
                                            : GoogleFonts.mulish(
                                            fontWeight:
                                            FontWeight.w600,
                                            letterSpacing: 1,
                                            fontSize: 15,
                                            color: Colors.black)),
                                  ),
                                  Tab(
                                    child: Text("Saved recommendations",
                                        style: currentDrawer == 2
                                            ? GoogleFonts.mulish(
                                            fontWeight:
                                            FontWeight.w600,
                                            letterSpacing: 1,
                                            fontSize: 15,
                                            color: const Color(
                                                0xFF3797EF))
                                            : GoogleFonts.mulish(
                                            fontWeight:
                                            FontWeight.w600,
                                            letterSpacing: 1,
                                            fontSize: 15,
                                            color: Colors.black)),
                                  ),
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
                      child: TabBarView(
                          controller: _tabController,
                          children: [
                            SingleChildScrollView(
                              physics:
                              const AlwaysScrollableScrollPhysics(),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Obx(() {
                                      return
                                        statusOfUser
                                            .value
                                            .isSuccess
                                            ? Column(
                                          children: [
                                            ListView.builder(
                                                shrinkWrap: true,
                                                itemCount:
                                                userProfile
                                                    .value
                                                    .data!
                                                    .myRequest!
                                                    .length,
                                                physics:
                                                const NeverScrollableScrollPhysics(),
                                                itemBuilder:
                                                    (context, index) {
                                                  return Column(
                                                    children: [
                                                      Container(
                                                        padding:
                                                        const EdgeInsets
                                                            .all(
                                                            10),
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .white,
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color:
                                                                const Color(0xFF5F5F5F).withOpacity(0.2),
                                                                offset: const Offset(
                                                                    0.0,
                                                                    0.2),
                                                                blurRadius:
                                                                2,
                                                              ),
                                                            ]),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                ClipOval(
                                                                  child:
                                                                  CachedNetworkImage(
                                                                    width: 30,
                                                                    height: 30,
                                                                    fit: BoxFit.cover,
                                                                    imageUrl: userProfile.value.data!.myRequest![index].userId!.profileImage.toString(),
                                                                    placeholder: (context, url) => Image.asset(AppAssets.girl),
                                                                    errorWidget: (context, url, error) => Image.asset(AppAssets.girl),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width:
                                                                  20,
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                  Column(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      userProfile.value.data!.myRequest![index].userId!.name.toString() == ""
                                                                          ? Text(
                                                                        "Name...",
                                                                        style: GoogleFonts.mulish(
                                                                            fontWeight: FontWeight.w700,
                                                                            // letterSpacing: 1,
                                                                            fontSize: 14,
                                                                            color: Colors.black),
                                                                      )
                                                                          : Text(
                                                                        userProfile.value.data!.myRequest![index].userId!.name.toString(),
                                                                        style: GoogleFonts.mulish(
                                                                            fontWeight: FontWeight.w700,
                                                                            // letterSpacing: 1,
                                                                            fontSize: 14,
                                                                            color: Colors.black),
                                                                      ),
                                                                      Row(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Expanded(
                                                                              child:  userProfile.value.data!.myRequest![index].userId!.address.toString() == ""
                                                                                  ? Text(
                                                                                "address...",
                                                                                style: GoogleFonts.mulish(
                                                                                    fontWeight: FontWeight.w400,
                                                                                    // letterSpacing: 1,
                                                                                    fontSize: 14,
                                                                                    color: const Color(0xFF878D98)),
                                                                              )
                                                                                  : Text(
                                                                                userProfile.value.data!.myRequest![index].userId!.address.toString(),
                                                                                style: GoogleFonts.mulish(
                                                                                    fontWeight: FontWeight.w400,
                                                                                    // letterSpacing: 1,
                                                                                    fontSize: 14,
                                                                                    color: const Color(0xFF878D98)),
                                                                              )),
                                                                          const SizedBox(
                                                                            height: 15,
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
                                                                                color: const Color(0xFF878D98)),
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
                                                            const SizedBox(
                                                              height:
                                                              15,
                                                            ),
                                                            CachedNetworkImage(
                                                              width: size
                                                                  .width,
                                                              height:
                                                              200,
                                                              fit: BoxFit
                                                                  .fill,
                                                              imageUrl:  userProfile
                                                                  .value
                                                                  .data!
                                                                  .myRequest![index]
                                                                  .image
                                                                  .toString(),
                                                              placeholder:
                                                                  (context, url) =>
                                                                  Image.asset(AppAssets.picture),
                                                              errorWidget: (context,
                                                                  url,
                                                                  error) =>
                                                                  Image.asset(AppAssets.picture),
                                                            ),
                                                            const SizedBox(
                                                              height:
                                                              10,
                                                            ),
                                                            Text(
                                                              userProfile.value
                                                                  .data!
                                                                  .myRequest![index]
                                                                  .title
                                                                  .toString(),
                                                              style: GoogleFonts.mulish(
                                                                  fontWeight: FontWeight.w700,
                                                                  // letterSpacing: 1,
                                                                  fontSize: 17,
                                                                  color: Colors.black),
                                                            ),
                                                            const SizedBox(
                                                              height:
                                                              10,
                                                            ),
                                                            Text(
                                                              userProfile.value
                                                                  .data!
                                                                  .myRequest![index]
                                                                  .description
                                                                  .toString(),
                                                              style: GoogleFonts.mulish(
                                                                  fontWeight: FontWeight.w300,
                                                                  // letterSpacing: 1,
                                                                  fontSize: 14,
                                                                  color: const Color(0xFF6F7683)),
                                                            ),
                                                            const SizedBox(
                                                              height:
                                                              10,
                                                            ),
                                                            Container(
                                                              padding: const EdgeInsets
                                                                  .all(
                                                                  5),
                                                              width:
                                                              180,
                                                              height:
                                                              30,
                                                              decoration:
                                                              BoxDecoration(
                                                                color:
                                                                const Color(0xFF3797EF).withOpacity(.09),
                                                                borderRadius:
                                                                BorderRadius.circular(10),
                                                              ),
                                                              child:
                                                              Row(
                                                                children: [
                                                                  SvgPicture.asset(AppAssets.message),
                                                                  const SizedBox(
                                                                    width: 6,
                                                                  ),
                                                                  Text(
                                                                    "Recommendations: 120",
                                                                    style: GoogleFonts.mulish(
                                                                        fontWeight: FontWeight.w500,
                                                                        // letterSpacing: 1,
                                                                        fontSize: 12,
                                                                        color: const Color(0xFF3797EF)),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height:
                                                              10,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
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
                                            : statusOfUser
                                            .value
                                            .isError
                                            ? CommonErrorWidget(
                                          errorText: "",
                                          onTap: () {},
                                        )
                                            : const Center(
                                            child:
                                            CircularProgressIndicator());
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
                                          return statusOfUser
                                              .value.isSuccess
                                              ? ListView.builder(
                                              itemCount: userProfile
                                                  .value.data!.myCategories!.length,
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
                                                          // profileController.categoriesController.text = item.name.toString();
                                                          // profileController.idController.text = item.id.toString();
                                                          // Get.back();
                                                        },
                                                        child:
                                                        ClipOval(
                                                          child:
                                                          CachedNetworkImage(
                                                            width: 70,
                                                            height:
                                                            70,
                                                            fit: BoxFit
                                                                .fill,
                                                            imageUrl:  userProfile
                                                                .value.data!.myCategories![
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
                                                        userProfile
                                                            .value.data!.myCategories![
                                                        index]
                                                            .name
                                                            .toString(),
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
                                              : statusOfUser
                                              .value.isError
                                              ? CommonErrorWidget(
                                            errorText: "",
                                            onTap: () {},
                                          )
                                              : const Center(
                                              child:
                                              CircularProgressIndicator());
                                        })),
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
                                      itemCount: userProfile
                                          .value
                                          .data!
                                          .myRecommandation!
                                          .length,
                                      // Total number of items
                                      itemBuilder: (BuildContext context,
                                          int index) {
                                        // You can replace the Container with your image widget
                                        return CachedNetworkImage(
                                          imageUrl: userProfile
                                              .value
                                              .data!
                                              .myRecommandation![index]
                                              .image
                                              .toString(),
                                          width: 50,
                                          height: 50,
                                        );
                                      },
                                    ),
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
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Obx(() {
                                      return statusOfUser
                                          .value
                                          .isSuccess
                                          ? Column(
                                        children: [
                                          ListView.builder(
                                              shrinkWrap: true,
                                              itemCount:
                                              userProfile
                                                  .value
                                                  .data!
                                                  .saveRecommandation!
                                                  .length,
                                              physics:
                                              const NeverScrollableScrollPhysics(),
                                              itemBuilder:
                                                  (context, index) {
                                                return Column(
                                                  children: [
                                                    Container(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(
                                                          10),
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .white,
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color:
                                                              const Color(0xFF5F5F5F).withOpacity(0.2),
                                                              offset: const Offset(
                                                                  0.0,
                                                                  0.2),
                                                              blurRadius:
                                                              2,
                                                            ),
                                                          ]),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .start,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              ClipOval(
                                                                child:
                                                                CachedNetworkImage(
                                                                  width: 30,
                                                                  height: 30,
                                                                  fit: BoxFit.cover,
                                                                  imageUrl: userProfile.value.data!.myRequest![index].userId!.profileImage.toString(),
                                                                  placeholder: (context, url) => Image.asset(AppAssets.girl),
                                                                  errorWidget: (context, url, error) => Image.asset(AppAssets.girl),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width:
                                                                20,
                                                              ),
                                                              Expanded(
                                                                child:
                                                                Column(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    userProfile.value.data!.myRequest![index].userId!.name.toString() == ""
                                                                        ? Text(
                                                                      "Name...",
                                                                      style: GoogleFonts.mulish(
                                                                          fontWeight: FontWeight.w700,
                                                                          // letterSpacing: 1,
                                                                          fontSize: 14,
                                                                          color: Colors.black),
                                                                    )
                                                                        : Text(
                                                                      userProfile.value.data!.myRequest![index].userId!.name.toString(),
                                                                      style: GoogleFonts.mulish(
                                                                          fontWeight: FontWeight.w700,
                                                                          // letterSpacing: 1,
                                                                          fontSize: 14,
                                                                          color: Colors.black),
                                                                    ),
                                                                    Row(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Expanded(
                                                                            child: userProfile.value.data!.myRequest![index].userId!.address.toString() == ""
                                                                                ? Text(
                                                                              "address...",
                                                                              style: GoogleFonts.mulish(
                                                                                  fontWeight: FontWeight.w400,
                                                                                  // letterSpacing: 1,
                                                                                  fontSize: 14,
                                                                                  color: const Color(0xFF878D98)),
                                                                            )
                                                                                : Text(
                                                                              userProfile.value.data!.myRequest![index].userId!.address.toString(),
                                                                              style: GoogleFonts.mulish(
                                                                                  fontWeight: FontWeight.w400,
                                                                                  // letterSpacing: 1,
                                                                                  fontSize: 14,
                                                                                  color: const Color(0xFF878D98)),
                                                                            )),
                                                                        const SizedBox(
                                                                          height: 15,
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
                                                                              color: const Color(0xFF878D98)),
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
                                                          const SizedBox(
                                                            height:
                                                            15,
                                                          ),
                                                          Stack(
                                                              children: [
                                                                CachedNetworkImage(
                                                                  width: size.width,
                                                                  height: 200,
                                                                  fit: BoxFit.fill,
                                                                  imageUrl: userProfile.value.data!.saveRecommandation![index].post!.image.toString(),
                                                                  placeholder: (context, url) => Image.asset(AppAssets.picture),
                                                                  errorWidget: (context, url, error) => Image.asset(AppAssets.picture),
                                                                ),
                                                                Positioned(
                                                                    right: 10,
                                                                    top: 15,
                                                                    child: Container(
                                                                      padding: const EdgeInsets.all(6),
                                                                      decoration: (BoxDecoration(
                                                                        color: Colors.white,
                                                                        borderRadius: BorderRadius.circular(15),
                                                                      )),
                                                                      child: Row(
                                                                        children: [
                                                                          const Icon(
                                                                            Icons.remove_red_eye_outlined,
                                                                            size: 20,
                                                                          ),
                                                                          Text(
                                                                            " Views " + userProfile.value.data!.saveRecommandation![index].post!.review.toString(),
                                                                            style: GoogleFonts.mulish(
                                                                                fontWeight: FontWeight.w500,
                                                                                // letterSpacing: 1,
                                                                                fontSize: 12,
                                                                                color: Colors.black),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ))
                                                              ]),
                                                          const SizedBox(
                                                            height:
                                                            10,
                                                          ),
                                                          Text(
                                                            userProfile
                                                                .value
                                                                .data!
                                                                .saveRecommandation![index]
                                                                .post!
                                                                .title
                                                                .toString(),
                                                            style: GoogleFonts.mulish(
                                                                fontWeight: FontWeight.w700,
                                                                // letterSpacing: 1,
                                                                fontSize: 17,
                                                                color: Colors.black),
                                                          ),
                                                          const SizedBox(
                                                            height:
                                                            10,
                                                          ),
                                                          GestureDetector(
                                                            onTap:
                                                                () async {
                                                              //output: Hello%20Flutter
                                                              Uri mail =
                                                              Uri.parse(
                                                                "https://" +
                                                                    userProfile.value.data!.saveRecommandation![index].post!.link.toString(),
                                                              );
                                                              if (await launchUrl(
                                                                  mail)) {
                                                                //email app opened
                                                              } else {
                                                                //email app is not opened
                                                              }
                                                            },
                                                            child:
                                                            Text(
                                                              userProfile
                                                                  .value
                                                                  .data!
                                                                  .saveRecommandation![index]
                                                                  .post!
                                                                  .link
                                                                  .toString(),
                                                              style: GoogleFonts.mulish(
                                                                  fontWeight: FontWeight.w300,
                                                                  decoration: TextDecoration.underline,
                                                                  // letterSpacing: 1,
                                                                  fontSize: 14,
                                                                  color: const Color(0xFF6F7683)),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height:
                                                            10,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
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
                                          : statusOfUser
                                          .value
                                          .isError
                                          ? CommonErrorWidget(
                                        errorText: "",
                                        onTap: () {},
                                      )
                                          : const Center(
                                          child:
                                          CircularProgressIndicator());
                                    })
                                  ],
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ],
                )
                    : statusOfUser.value.isError
                    ? CommonErrorWidget(
                  errorText: "",
                  onTap: () {},
                )
                    : const Center(
                    child: Center(child: CircularProgressIndicator()));
              })),
        ),
      ),
    );
  }
}
