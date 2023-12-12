import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:referral_app/routers/routers.dart';
import 'package:referral_app/screens/edit_account_screen.dart';
import 'package:referral_app/widgets/app_assets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/homeController.dart';
import '../controller/profile_controller.dart';
import '../models/categories_model.dart';
import '../models/home_page_model.dart';
import '../repositories/categories_repo.dart';
import '../repositories/home_pafe_repo.dart';
import '../widgets/app_theme.dart';
import '../widgets/common_error_widget.dart';
import '../widgets/custome_textfiled.dart';
import 'edit_account_screen.dart';
import 'edit_account_screen.dart';
import 'edit_account_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  final homeController = Get.put(HomeController());

  Rx<RxStatus> statusOfHome = RxStatus.empty().obs;

  Rx<HomeModel> home = HomeModel().obs;
  RxString type = ''.obs;
  RxBool isDataLoading = false.obs;
  RxBool isPaginationLoading = true.obs;
  RxBool loadMore = true.obs;
  RxInt page = 1.obs;
  RxInt pagination = 10.obs;
  RxBool isDataLoading2 = false.obs;

  getData() {
    isDataLoading2.value = false;
    homeRepo().then((value) {
      isDataLoading2.value = true;
      home.value = value;
    });
  }

  /* Future<dynamic> chooseCategories({isFirstTime = false, context}) async {
    if(isFirstTime){
      page.value = 1;
    }
    if (isPaginationLoading.value && loadMore.value){
      isPaginationLoading.value = false;
    }
    getHomeRepo(page: page.value,pagination: pagination.value).then((value) {
        home.value = value;
         isPaginationLoading.value = true;


      if (value.status == true) {
        statusOfHome.value = RxStatus.success();
        page.value++;
        if(isFirstTime){
          home.value.data!.addAll(value.data!);
        }
        loadMore.value = value.link!.next ?? false;
      } else {
        statusOfHome.value = RxStatus.error();
      }

      // showToast(value.message.toString());
    });
  }*/

  chooseCategories() {
    homeRepo().then((value) {
      home.value = value;

      if (value.status == true) {
        statusOfHome.value = RxStatus.success();
      } else {
        statusOfHome.value = RxStatus.error();
      }

      // showToast(value.message.toString());
    });
  }

  final profileController = Get.put(ProfileController());

  bool showFloatingActionButton = false;
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_tabListener);
    profileController.getData();
    chooseCategories();
    getData();
    //homeController.getData();

    chooseCategories1();
  }

  void _tabListener() {
    setState(() {
      showFloatingActionButton = _tabController.index == 1; // 1 corresponds to "My recommendations"
    });
  }

  Rx<RxStatus> statusOfCategories = RxStatus.empty().obs;

  Rx<CategoriesModel> categories = CategoriesModel().obs;

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
            profileController.getData();
          },
          child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Obx(() {
                return profileController.statusOfProfile.value.isSuccess
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
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppTheme.secondaryColor,
                                                width: 1),
                                            shape: BoxShape.circle),
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
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
                                              imageUrl: profileController
                                                  .modal
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
                                      InkWell(
                                        onTap: () {
                                          Get.toNamed(
                                              MyRouters.profilePostScreen,
                                              arguments: [
                                                profileController.modal.value
                                                    .data!.user!.postCount
                                                    .toString(),
                                              ]);
                                        },
                                        child: Column(
                                          children: [
                                            Text(
                                                profileController.modal.value
                                                    .data!.user!.postCount
                                                    .toString(),
                                                style: GoogleFonts.mulish(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 18,
                                                    color: const Color(
                                                        0xFF000000))),
                                            const SizedBox(
                                              height: 7,
                                            ),
                                            Text("Posts",
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
                                          Get.toNamed(MyRouters.followingScreen,
                                              arguments: [
                                                profileController.modal.value
                                                    .data!.user!.followersCount
                                                    .toString(),
                                                profileController.modal.value
                                                    .data!.user!.followingCount
                                                    .toString(),
                                              ]);
                                        },
                                        child: Column(
                                          children: [
                                            Text(
                                                profileController.modal.value
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
                                          profileController.profileDrawer == 1;
                                          Get.toNamed(MyRouters.followingScreen,
                                              arguments: [
                                                profileController.modal.value
                                                    .data!.user!.followersCount
                                                    .toString(),
                                                profileController.modal.value
                                                    .data!.user!.followingCount
                                                    .toString(),
                                              ]);
                                        },
                                        child: Column(
                                          children: [
                                            Text(
                                                profileController.modal.value
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          profileController
                                              .modal.value.data!.user!.name
                                              .toString(),
                                          style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20,
                                              color: const Color(0xFF262626))),
                                      SizedBox(
                                          width: 100,
                                          height: 40,
                                          child: CommonButton(
                                            title: "Edit",
                                            onPressed: () async {
                                              Get.toNamed(
                                                  MyRouters.editAccount);
                                            },
                                          ))
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
                                      labelStyle:
                                          const TextStyle(color: Colors.blue),
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
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
                          Container(
                            width: size.width,
                            height: size.height,
                            color: Colors.transparent,
                            child: TabBarView(
                                controller: _tabController,
                                children: [
                                  SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Obx(() {
                                          return profileController
                                                  .statusOfProfile
                                                  .value
                                                  .isSuccess
                                              ? Column(
                                                  children: [
                                                    if (profileController
                                                        .modal
                                                        .value
                                                        .data!
                                                        .myRequest!
                                                        .isEmpty)
                                                      const Text(
                                                          "No data found "),
                                                    ListView.builder(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            vertical: 10),
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            profileController
                                                                .modal
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
                                                                color: Colors
                                                                    .white,
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        18),
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
                                                                            width:
                                                                                30,
                                                                            height:
                                                                                30,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            imageUrl:
                                                                                profileController.modal.value.data!.myRequest![index].userId!.profileImage.toString(),
                                                                            placeholder: (context, url) =>
                                                                                Image.asset(AppAssets.girl),
                                                                            errorWidget: (context, url, error) =>
                                                                                Image.asset(AppAssets.girl),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              20,
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              profileController.modal.value.data!.myRequest![index].userId!.name.toString() == ""
                                                                                  ? Text(
                                                                                      "Name...",
                                                                                      style: GoogleFonts.mulish(
                                                                                          fontWeight: FontWeight.w700,
                                                                                          // letterSpacing: 1,
                                                                                          fontSize: 14,
                                                                                          color: Colors.black),
                                                                                    )
                                                                                  : Text(
                                                                                      profileController.modal.value.data!.myRequest![index].userId!.name.toString(),
                                                                                      style: GoogleFonts.mulish(
                                                                                          fontWeight: FontWeight.w700,
                                                                                          // letterSpacing: 1,
                                                                                          fontSize: 14,
                                                                                          color: Colors.black),
                                                                                    ),
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
                                                                    profileController
                                                                        .modal
                                                                        .value
                                                                        .data!
                                                                        .myRequest![index].image == ""
                                                                        ? SizedBox()
                                                                        : ClipRRect(
                                                                      borderRadius: BorderRadius.circular(10),
                                                                      child: CachedNetworkImage(
                                                                        width: size.width,
                                                                        height: 200,
                                                                        fit: BoxFit.fill,
                                                                        imageUrl:   profileController
                                                                            .modal
                                                                            .value
                                                                            .data!
                                                                            .myRequest![index].image
                                                                            .toString(),
                                                                        placeholder: (context, url) => SizedBox(
                                                                          height: 0,
                                                                        ),
                                                                        errorWidget: (context, url, error) => SizedBox(
                                                                          height: 0,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Text(
                                                                      profileController
                                                                          .modal
                                                                          .value
                                                                          .data!
                                                                          .myRequest![
                                                                              index]
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
                                                                      profileController
                                                                          .modal
                                                                          .value
                                                                          .data!
                                                                          .myRequest![
                                                                              index]
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
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .all(
                                                                              5),
                                                                      height:
                                                                          30,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: const Color(0xFF3797EF)
                                                                            .withOpacity(.09),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          SvgPicture.asset(
                                                                              AppAssets.message),
                                                                          const SizedBox(
                                                                            width:
                                                                                6,
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
                                                                height: 10,
                                                              )
                                                            ],
                                                          );
                                                        }),
                                                    const SizedBox(
                                                      height: 350,
                                                    )
                                                  ],
                                                )
                                              : profileController
                                                      .statusOfProfile
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
                                  SingleChildScrollView(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                              height: size.height * .15,
                                              child: Obx(() {
                                                return profileController
                                                        .statusOfProfile
                                                        .value
                                                        .isSuccess
                                                    ? ListView.builder(
                                                        itemCount:
                                                            profileController
                                                                .modal
                                                                .value
                                                                .data!
                                                                .myCategories!
                                                                .length,
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
                                                                      imageUrl: profileController
                                                                          .modal
                                                                          .value
                                                                          .data!
                                                                          .myCategories![
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
                                                                  profileController
                                                                      .modal
                                                                      .value
                                                                      .data!
                                                                      .myCategories![
                                                                          index]
                                                                      .name
                                                                      .toString(),
                                                                  style: GoogleFonts.mulish(
                                                                      fontWeight: FontWeight.w300,
                                                                      // letterSpacing: 1,
                                                                      fontSize: 14,
                                                                      color: const Color(0xFF26282E)),
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        })
                                                    : profileController
                                                            .statusOfProfile
                                                            .value
                                                            .isError
                                                        ? CommonErrorWidget(
                                                            errorText: "",
                                                            onTap: () {},
                                                          )
                                                        : const Center(
                                                            child:
                                                                CircularProgressIndicator());
                                              })),
                                          Column(
                                            children: [
                                              if (profileController
                                                  .modal
                                                  .value
                                                  .data!
                                                  .myRecommandation!
                                                  .isEmpty)
                                                const Text("No data found "),
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
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  // You can replace the Container with your image widget
                                                  return InkWell(
                                                    onTap: () {
                                                      Get.toNamed(
                                                        MyRouters.singleScreen,
                                                        arguments: [
                                                          profileController
                                                              .modal
                                                              .value
                                                              .data!
                                                              .myRecommandation![
                                                                  index]
                                                              .image
                                                              .toString(),
                                                          profileController
                                                              .modal
                                                              .value
                                                              .data!
                                                              .myRecommandation![
                                                                  index]
                                                              .title
                                                              .toString(),
                                                          profileController
                                                              .modal
                                                              .value
                                                              .data!
                                                              .myRecommandation![
                                                                  index]
                                                              .review
                                                              .toString(),
                                                          profileController
                                                              .modal
                                                              .value
                                                              .data!
                                                              .myRecommandation![
                                                                  index]
                                                              .id
                                                              .toString(),
                                                          profileController
                                                              .modal
                                                              .value
                                                              .data!
                                                              .myRecommandation![
                                                                  index]
                                                              .link
                                                              .toString(),
                                                        ],
                                                      );
                                                      print("object");
                                                    },
                                                    child: CachedNetworkImage(
                                                        imageUrl: profileController
                                                            .modal
                                                            .value
                                                            .data!
                                                            .myRecommandation![
                                                                index]
                                                            .image
                                                            .toString(),
                                                        width: 50,
                                                        height: 50,
                                                        errorWidget: (_, __,
                                                                ___) =>
                                                            Image.network(
                                                                profileController
                                                                    .modal
                                                                    .value
                                                                    .data!
                                                                    .myRecommandation![
                                                                        index]
                                                                    .link!)),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (profileController.modal.value.data!
                                      .saveRecommandation!.isNotEmpty)
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
                                              return profileController
                                                      .statusOfProfile
                                                      .value
                                                      .isSuccess
                                                  ? Column(
                                                      children: [
                                                        ListView.builder(
                                                            shrinkWrap: true,
                                                            itemCount:
                                                                profileController
                                                                    .modal
                                                                    .value
                                                                    .data!
                                                                    .saveRecommandation!
                                                                    .length,
                                                            physics:
                                                                const NeverScrollableScrollPhysics(),
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return Column(
                                                                children: [
                                                                  profileController.modal.value.data!.saveRecommandation !=
                                                                              null &&
                                                                          profileController.modal.value.data!.saveRecommandation![index].post !=
                                                                              null
                                                                      ? Container(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              10),
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
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  ClipOval(
                                                                                    child: profileController.modal.value.data!.saveRecommandation![index].post != null
                                                                                        ? CachedNetworkImage(
                                                                                            width: 30,
                                                                                            height: 30,
                                                                                            fit: BoxFit.cover,
                                                                                            imageUrl: profileController.modal.value.data!.saveRecommandation![index].post!.toString(),
                                                                                            placeholder: (context, url) => Image.asset(AppAssets.girl),
                                                                                            errorWidget: (context, url, error) => Image.asset(AppAssets.girl),
                                                                                          )
                                                                                        : Image.asset(AppAssets.girl),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    width: 20,
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Column(
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        profileController.modal.value.data!.saveRecommandation![index].post!.review.toString() == "" && profileController.modal.value.data!.saveRecommandation![index].post!.review == null
                                                                                            ? Text(
                                                                                                "Name...",
                                                                                                style: GoogleFonts.mulish(
                                                                                                    fontWeight: FontWeight.w700,
                                                                                                    // letterSpacing: 1,
                                                                                                    fontSize: 14,
                                                                                                    color: Colors.black),
                                                                                              )
                                                                                            : Text(
                                                                                                profileController.modal.value.data!.saveRecommandation![index].post!.review.toString(),
                                                                                                style: GoogleFonts.mulish(
                                                                                                    fontWeight: FontWeight.w700,
                                                                                                    // letterSpacing: 1,
                                                                                                    fontSize: 14,
                                                                                                    color: Colors.black),
                                                                                              ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  SvgPicture.asset(AppAssets.bookmark1),
                                                                                ],
                                                                              ),
                                                                              const SizedBox(
                                                                                height: 15,
                                                                              ),
                                                                              profileController
                                                                                  .modal
                                                                                  .value
                                                                                  .data!
                                                                                  .saveRecommandation![index].post!.image == ""
                                                                                  ? SizedBox()
                                                                                  : ClipRRect(
                                                                                borderRadius: BorderRadius.circular(10),
                                                                                child: CachedNetworkImage(
                                                                                  width: size.width,
                                                                                  height: 200,
                                                                                  fit: BoxFit.fill,
                                                                                  imageUrl:   profileController
                                                                                      .modal
                                                                                      .value
                                                                                      .data!
                                                                                      .saveRecommandation![index].post!.image
                                                                                      .toString(),
                                                                                  placeholder: (context, url) => SizedBox(
                                                                                    height: 0,
                                                                                  ),
                                                                                  errorWidget: (context, url, error) => SizedBox(
                                                                                    height: 0,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              const SizedBox(
                                                                                height: 10,
                                                                              ),
                                                                              Text(
                                                                                profileController.modal.value.data!.saveRecommandation![index].post!.title.toString(),
                                                                                style: GoogleFonts.mulish(
                                                                                    fontWeight: FontWeight.w700,
                                                                                    // letterSpacing: 1,
                                                                                    fontSize: 17,
                                                                                    color: Colors.black),
                                                                              ),
                                                                              const SizedBox(
                                                                                height: 10,
                                                                              ),
                                                                              GestureDetector(
                                                                                onTap: () async {
                                                                                  //output: Hello%20Flutter
                                                                                  Uri mail = Uri.parse(
                                                                                    "https://" + profileController.modal.value.data!.saveRecommandation![index].post!.link.toString(),
                                                                                  );
                                                                                  if (await launchUrl(mail)) {
                                                                                    //email app opened
                                                                                  } else {
                                                                                    //email app is not opened
                                                                                  }
                                                                                },
                                                                                child: Text(
                                                                                  profileController.modal.value.data!.saveRecommandation![index].post!.link.toString(),
                                                                                  style: GoogleFonts.mulish(
                                                                                      fontWeight: FontWeight.w300,
                                                                                      decoration: TextDecoration.underline,
                                                                                      // letterSpacing: 1,
                                                                                      fontSize: 14,
                                                                                      color: const Color(0xFF6F7683)),
                                                                                ),
                                                                              ),
                                                                              const SizedBox(
                                                                                height: 10,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        )
                                                                      : const Text(
                                                                          "No data found "),
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
                                                  : profileController
                                                          .statusOfProfile
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
                    : profileController.statusOfProfile.value.isError
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

