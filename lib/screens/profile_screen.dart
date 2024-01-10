import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:referral_app/routers/routers.dart';
import 'package:referral_app/screens/edit_account_screen.dart';
import 'package:referral_app/screens/recommendation_single_page.dart';
import 'package:referral_app/screens/update_myRequest_screen.dart';
import 'package:referral_app/widgets/app_assets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/get_comment_controller.dart';
import '../controller/get_recommendation_controller.dart';
import '../controller/homeController.dart';
import '../controller/profile_controller.dart';
import '../models/categories_model.dart';
import '../models/delete_recomm.dart';
import '../models/get_comment_model.dart';
import '../models/home_page_model.dart';
import '../models/model_review_list.dart';
import '../models/single_product_model.dart';
import '../repositories/add_comment_repo.dart';
import '../repositories/categories_repo.dart';
import '../repositories/get_comment_repo.dart';
import '../repositories/home_pafe_repo.dart';
import '../repositories/repo_add_like.dart';
import '../repositories/repo_delete_recomm.dart';
import '../repositories/repo_review_list.dart';
import '../repositories/single_produc_repo.dart';
import '../resourses/api_constant.dart';
import '../widgets/app_theme.dart';
import '../widgets/common_error_widget.dart';
import '../widgets/custome_textfiled.dart';
import 'comment_screen.dart';
import 'edit_account_screen.dart';
import 'edit_account_screen.dart';
import 'edit_account_screen.dart';
import 'get_recommendation_ui.dart';
import 'my_recommendation_category.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  final homeController = Get.put(HomeController());

  Rx<RxStatus> statusOfHome = RxStatus.empty().obs;
  final getCommentController = Get.put(GetCommentController());
  Rx<HomeModel> home = HomeModel().obs;
  RxString type = ''.obs;
  RxBool isDataLoading = false.obs;
  RxBool isPaginationLoading = true.obs;
  RxBool loadMore = true.obs;
  RxInt page = 1.obs;
  RxInt pagination = 10.obs;
  RxBool isDataLoading2 = false.obs;
  String postId = '';
  Rx<RxStatus> statusOfRemove = RxStatus.empty().obs;

  Rx<RxStatus> statusOfReviewList = RxStatus.empty().obs;
  Rx<ModelReviewList> modelReviewList = ModelReviewList().obs;
  Rx<ModelDeleteRecomm> deleteRecommendation = ModelDeleteRecomm().obs;
  Rx<RxStatus> statusOfDelete = RxStatus.empty().obs;
  getData() {
    isDataLoading2.value = false;
    homeRepo().then((value) {
      isDataLoading2.value = true;
      home.value = value;
    });
  }
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
  // reviewList(id) {
  //   // modelReviewList.value.data!.clear();
  //   getReviewListRepo(context: context, id: id).then((value) {
  //     modelReviewList.value = value;
  //
  //     if (value.status == true) {
  //       statusOfReviewList.value = RxStatus.success();
  //     } else {
  //       statusOfReviewList.value = RxStatus.error();
  //     }
  //     setState(() {});
  //   });
  // }

  /* Future<dynamic> chooseCategories({isFirstTime = false, context}) async {
    if(isFirstTime){
      page.value = 1;
    }
    if (isPaginationLoading.value && loadMore.value){
      isPaginationLoading.value = false;
    }
    getHomeRepo(page: page.value,paginfluation: pagination.value).then((value) {
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
  String post1 = "";

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showToast('Could not launch $url');
    }
  }
  Rx<GetCommentModel> getCommentModel = GetCommentModel().obs;
  Rx<RxStatus> statusOfGetComment = RxStatus.empty().obs;
  final getRecommendationController = Get.put(GetRecommendationController());
  String post = '';
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
  SampleItem? selectedMenu;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFF3797EF).withOpacity(.04),
        floatingActionButton: showFloatingActionButton
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 0).copyWith(bottom: 80),
                child: FloatingActionButton(
                  onPressed: () {
                    Get.toNamed(MyRouters.addRecommendationScreen);
                  },
                  backgroundColor: Colors.transparent,
                  child: SvgPicture.asset(AppAssets.add1),
                ),
              )
            : const SizedBox(),
        body: RefreshIndicator(
          color: Colors.white,
          backgroundColor: AppTheme.primaryColor,
          onRefresh: () async {
            profileController.getData();
          },
          child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Obx(() {
                if(profileController.refreshData1.value > 0){}
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
                                          fontWeight: FontWeight.w700, fontSize: 18, color: const Color(0xFF262626))),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            border: Border.all(color: AppTheme.secondaryColor.withOpacity(.3)),
                                            shape: BoxShape.circle),
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              border: Border.all(color: AppTheme.secondaryColor.withOpacity(.3)),
                                              shape: BoxShape.circle),
                                          child: ClipOval(
                                            child: CachedNetworkImage(
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.cover,
                                              imageUrl: profileController.modal.value.data!.user!.profileImage.toString(),
                                              placeholder: (context, url) => const SizedBox(),
                                              errorWidget: (context, url, error) => const SizedBox(),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(MyRouters.profilePostScreen, arguments: [
                                            profileController.modal.value.data!.user!.postCount.toString(),
                                          ]);
                                        },
                                        child: Column(
                                          children: [
                                            Text(profileController.modal.value.data!.user!.postCount.toString(),
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
                                            profileController.modal.value.data!.user!.followersCount.toString(),
                                            profileController.modal.value.data!.user!.followingCount.toString(),
                                            profileController.modal.value.data!.user!.id.toString(),
                                          ]);
                                        },
                                        child: Obx(() {
                                          return Column(
                                            children: [
                                              Text(
                                                profileController.modal.value.data!.user!.followersCount.toString(),
                                                style: GoogleFonts.mulish(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 18,
                                                    color: const Color(0xFF000000)),
                                              ),
                                              const SizedBox(
                                                height: 7,
                                              ),
                                              Text("followers",
                                                  style: GoogleFonts.mulish(
                                                      fontWeight: FontWeight.w300,
                                                      fontSize: 16,
                                                      color: const Color(0xFF262626))),
                                            ],
                                          );
                                        }),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          profileController.profileDrawer == 1;
                                          Get.toNamed(MyRouters.followingScreen, arguments: [
                                            profileController.modal.value.data!.user!.followersCount.toString(),
                                            profileController.modal.value.data!.user!.followingCount.toString(),
                                            profileController.modal.value.data!.user!.id.toString(),
                                          ]);
                                        },
                                        child: Column(
                                          children: [
                                            Text(profileController.modal.value.data!.user!.followingCount.toString(),
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(profileController.modal.value.data!.user!.name!.capitalizeFirst.toString(),
                                          style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w700, fontSize: 20, color: const Color(0xFF262626))),
                                      SizedBox(
                                          width: 100,
                                          height: 40,
                                          child: CommonButton(
                                            title: "Edit",
                                            onPressed: () async {
                                              Get.toNamed(MyRouters.editAccount);
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
                                      labelColor:  const Color(0xFF3797EF),
                                      unselectedLabelColor: Colors.black,
                                      controller: _tabController,
                                      padding: EdgeInsets.zero,
                                      dividerColor: Colors.transparent,
                                      tabAlignment: TabAlignment.start,
                                      isScrollable: true,
                                      // labelStyle: const TextStyle(color: Colors.blue),
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
                                          child: Text("My Requests",
                                            style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1,
                                              fontSize: 15,
                                            ),
                                              // style: currentDrawer == 0
                                              //     ? GoogleFonts.mulish(
                                              //         fontWeight: FontWeight.w600,
                                              //         letterSpacing: 1,
                                              //         fontSize: 15,
                                              //         color: const Color(0xFF3797EF))
                                              //     : GoogleFonts.mulish(
                                              //         fontWeight: FontWeight.w600,
                                              //         letterSpacing: 1,
                                              //         fontSize: 15,
                                              //         color: Colors.black)
                                          ),
                                        ),
                                        Tab(
                                          child: Text("My recommendations",
                                            style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1,
                                              fontSize: 15,
                                            ),
                                              // style: currentDrawer == 1
                                              //     ? GoogleFonts.mulish(
                                              //         fontWeight: FontWeight.w600,
                                              //         letterSpacing: 1,
                                              //         fontSize: 15,
                                              //         color: const Color(0xFF3797EF))
                                              //     : GoogleFonts.mulish(
                                              //         fontWeight: FontWeight.w600,
                                              //         letterSpacing: 1,
                                              //         fontSize: 15,
                                              //         color: Colors.black)
                                          ),
                                        ),
                                        Tab(
                                          child: Text("Saved recommendations",
                                            style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1,
                                              fontSize: 15,
                                            ),
                                              // style: currentDrawer == 2
                                              //     ? GoogleFonts.mulish(
                                              //         fontWeight: FontWeight.w600,
                                              //         letterSpacing: 1,
                                              //         fontSize: 15,
                                              //         color: const Color(0xFF3797EF))
                                              //     : GoogleFonts.mulish(
                                              //         fontWeight: FontWeight.w600,
                                              //         letterSpacing: 1,
                                              //         fontSize: 15,
                                              //         color: Colors.black)
                                          ),
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
                            child: TabBarView(controller: _tabController, children: [
                              SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Obx(() {
                                      return profileController.statusOfProfile.value.isSuccess
                                          ? Column(
                                              children: [
                                                if (profileController.modal.value.data!.myRequest!.isEmpty)
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
                                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                                    shrinkWrap: true,
                                                    itemCount: profileController.modal.value.data!.myRequest!.length,
                                                    physics: const NeverScrollableScrollPhysics(),
                                                    itemBuilder: (context, index) {
                                                      return Column(
                                                        children: [
                                                          Container(
                                                            color: Colors.white,
                                                            padding: const EdgeInsets.all(18),
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
                                                                        imageUrl: profileController.modal.value.data!
                                                                            .myRequest![index].userId!.profileImage
                                                                            .toString(),
                                                                        placeholder: (context, url) =>
                                                                            Image.asset(AppAssets.girl),
                                                                        errorWidget: (context, url, error) =>
                                                                            Image.asset(AppAssets.girl),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 20,
                                                                    ),
                                                                    Expanded(
                                                                      child: Column(
                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          profileController.modal.value.data!
                                                                                      .myRequest![index].userId!.name
                                                                                      .toString() ==
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
                                                                                  profileController
                                                                                      .modal
                                                                                      .value
                                                                                      .data!
                                                                                      .myRequest![index]
                                                                                      .userId!
                                                                                      .name!
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
                                                                    ),
                                                                    PopupMenuButton<SampleItem>(
                                                                      initialValue: selectedMenu,
                                                                      // Callback that sets the selected popup menu item.
                                                                      onSelected: (SampleItem item) {
                                                                        setState(() {
                                                                          selectedMenu = item;
                                                                        });
                                                                      },
                                                                      itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
                                                                        PopupMenuItem<SampleItem>(
                                                                          value: SampleItem.itemOne,
                                                                          onTap:  () {
                                                                            print("object${profileController
                                                                                .modal.value.data!.myRequest![index].id
                                                                                .toString()}");
                                                                            Get.to(()=>const UpdateMyRequestScreen(), arguments: [ profileController
                                                                                .modal.value.data!.myRequest![index].id
                                                                                .toString()]);
                                                                          },
                                                                          child: InkWell(
                                                                              onTap: () {
                                                                                print("object${profileController
                                                                                    .modal.value.data!.myRequest![index].id
                                                                                    .toString()}");
                                                                                Get.toNamed(MyRouters.addRecommendationScreen1, arguments: [ profileController
                                                                                    .modal.value.data!.myRequest![index].id
                                                                                    .toString()]);
                                                                              },
                                                                              child: Text('Edit')),
                                                                        ),
                                                                        PopupMenuItem<SampleItem>(
                                                                          value: SampleItem.itemTwo,
                                                                          onTap: () {
                                                                            showDialog<String>(
                                                                              context: context,
                                                                              builder: (BuildContext context) => AlertDialog(
                                                                                title: const Text(
                                                                                  'Are you sure to delete recommendation',
                                                                                  style: TextStyle(fontSize: 16),
                                                                                ),
                                                                                actionsPadding: EdgeInsets.all(30),
                                                                                actions: <Widget>[
                                                                                  InkWell(
                                                                                      onTap: () {
                                                                                        Get.back();
                                                                                        Get.back();
                                                                                        Get.back();
                                                                                      },
                                                                                      child: Text("Cancel ")),
                                                                                  const SizedBox(
                                                                                    width: 40,
                                                                                  ),
                                                                                  InkWell(
                                                                                      onTap: () {
                                                                                        deleteMyRequest(
                                                                                          context: context,
                                                                                          askRecommandationId : profileController
                                                                                              .modal.value.data!.myRequest![index].id
                                                                                              .toString(),
                                                                                        ).then((value) async {
                                                                                          if (value.status == true) {
                                                                                            deleteRecommendation.value = value;
                                                                                            profileController.getData();
                                                                                            Get.back();
                                                                                            Get.back();
                                                                                            Get.back();
                                                                                            print('wishlist-----');
                                                                                            statusOfDelete.value = RxStatus.success();

                                                                                            // like=true;
                                                                                            showToast(value.message.toString());
                                                                                          } else {
                                                                                            statusOfDelete.value = RxStatus.error();
                                                                                            // like=false;
                                                                                            showToast(value.message.toString());
                                                                                          }
                                                                                        });
                                                                                      },
                                                                                      child: const Text('OK')),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          },
                                                                          child: InkWell(
                                                                              onTap: () {
                                                                                showDialog<String>(
                                                                                  context: context,
                                                                                  builder: (BuildContext context) => AlertDialog(
                                                                                    title: const Text(
                                                                                      'Are you sure to delete recommendation',
                                                                                      style: TextStyle(fontSize: 16),
                                                                                    ),
                                                                                    actions: <Widget>[
                                                                                      InkWell(
                                                                                          onTap: () {
                                                                                            Get.back();
                                                                                            Get.back();
                                                                                            Get.back();
                                                                                          },
                                                                                          child: const Text("Cancel ")),
                                                                                      const SizedBox(
                                                                                        width: 40,
                                                                                      ),
                                                                                      InkWell(
                                                                                          onTap: () {
                                                                                            deleteRecommRepo(
                                                                                              context: context,
                                                                                              recommandation_id: profileController
                                                                                                  .modal.value.data!.myRequest![index].id
                                                                                                  .toString(),
                                                                                            ).then((value) async {
                                                                                              if (value.status == true) {
                                                                                                deleteRecommendation.value = value;
                                                                                                profileController.getData();
                                                                                                Get.back();
                                                                                                Get.back();
                                                                                                Get.back();
                                                                                                print('wishlist-----');
                                                                                                statusOfDelete.value = RxStatus.success();

                                                                                                // like=true;
                                                                                                showToast(value.message.toString());
                                                                                              } else {
                                                                                                statusOfDelete.value = RxStatus.error();
                                                                                                // like=false;
                                                                                                showToast(value.message.toString());
                                                                                              }
                                                                                            });
                                                                                          },
                                                                                          child: const Text('OK')),
                                                                                    ],
                                                                                  ),
                                                                                );
                                                                              },
                                                                              child: const Text('Delete')),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                                profileController
                                                                            .modal.value.data!.myRequest![index].image ==
                                                                        ""
                                                                    ? SizedBox()
                                                                    : ClipRRect(
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        child: CachedNetworkImage(
                                                                          width: size.width,
                                                                          height: 200,
                                                                          fit: BoxFit.fill,
                                                                          imageUrl: profileController
                                                                              .modal.value.data!.myRequest![index].image
                                                                              .toString(),
                                                                          placeholder: (context, url) => const SizedBox(
                                                                            height: 0,
                                                                          ),
                                                                          errorWidget: (context, url, error) =>
                                                                              const SizedBox(
                                                                            height: 0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Text(
                                                                  profileController.modal.value.data!.myRequest![index]
                                                                      .title!.capitalizeFirst
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
                                                                  profileController.modal.value.data!.myRequest![index]
                                                                      .description!.capitalizeFirst
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
                                                                        profileController.modal.value.data!
                                                                            .myRequest![index].minPrice
                                                                            .toString()
                                                                            .isNotEmpty
                                                                            ? const Text("Min Price")
                                                                            : const Text('No Budget'),
                                                                        profileController.modal.value.data!
                                                                            .myRequest![index].minPrice
                                                                            .toString()
                                                                            .isNotEmpty
                                                                            ? Text(profileController.modal.value.data!
                                                                            .myRequest![index].minPrice
                                                                            .toString())
                                                                            : const SizedBox(),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Column(
                                                                      children: [
                                                                        profileController.modal.value.data!
                                                                            .myRequest![index].maxPrice
                                                                            .toString()
                                                                            .isNotEmpty
                                                                            ? const Text("Max Price")
                                                                            : SizedBox(),
                                                                        profileController.modal.value.data!
                                                                            .myRequest![index].maxPrice
                                                                            .toString()
                                                                            .isNotEmpty
                                                                            ? Text(profileController.modal.value.data!
                                                                            .myRequest![index].maxPrice
                                                                            .toString())
                                                                            : const SizedBox(),
                                                                      ],
                                                                    )
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
                                                                          //           context: context,
                                                                          //           id: homeController.homeModel.value.data!
                                                                          //               .discover![index].id
                                                                          //               .toString())
                                                                          //       .then((value) {
                                                                          //     modelReviewList.value = value;
                                                                          //
                                                                          //     if (value.status == true) {
                                                                          //       statusOfReviewList.value = RxStatus.success();
                                                                          //       post1 = homeController
                                                                          //           .homeModel.value.data!.discover![index].id
                                                                          //           .toString();
                                                                          //       print(homeController.homeModel.value.data!
                                                                          //           .discover![index].id);
                                                                          //       _settingModalBottomSheet(context);
                                                                          //     } else {
                                                                          //       statusOfReviewList.value = RxStatus.error();
                                                                          //     }
                                                                          //     setState(() {});
                                                                          //   });
                                                                          // });
                                                                          setState(() {
                                                                            getRecommendationController.idForReco = homeController.homeModel.value.data!.discover![index].id.toString();
                                                                            _settingModalBottomSheet(context);
                                                                          });
                                                                        },
                                                                        child: Container(
                                                                          padding: const EdgeInsets.all(5),
                                                                          height: 30,
                                                                          decoration: BoxDecoration(
                                                                            color: const Color(0xFF3797EF).withOpacity(.09),
                                                                            borderRadius: BorderRadius.circular(10),
                                                                          ),
                                                                          child: Row(
                                                                            children: [
                                                                              SvgPicture.asset(AppAssets.message),
                                                                              const SizedBox(
                                                                                width: 6,
                                                                              ),
                                                                              Text(
                                                                                "Recommendation: ${profileController.modal.value.data!.myRequest![index].reviewCount.toString()}",
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
                                                                    const SizedBox(
                                                                      width: 20,
                                                                    ),
                                                                    Expanded(
                                                                      child: GestureDetector(
                                                                        onTap: () {
                                                                          // setState(() {
                                                                          //   getCommentRepo(
                                                                          //       context: context,
                                                                          //       id: profileController.modal.value.data!
                                                                          //           .myRequest![index].id.toString(), type: 'askrecommandation')
                                                                          //       .then((value) {
                                                                          //     getCommentModel.value = value;
                                                                          //
                                                                          //     if (value.status == true) {
                                                                          //       statusOfGetComment.value = RxStatus.success();
                                                                          //       post = profileController.modal.value.data!
                                                                          //           .myRequest![index].id.toString();
                                                                          //       print('Id Is....${profileController.modal.value.data!
                                                                          //           .myRequest![index].id.toString()}');
                                                                          //       commentBottomSheet(context);
                                                                          //     } else {
                                                                          //       statusOfGetComment.value = RxStatus.error();
                                                                          //     }
                                                                          //
                                                                          //     setState(() {});
                                                                          //   });
                                                                          // });

                                                                          setState(() {
                                                                            getCommentController.id = profileController.modal.value.data!.myRequest![index].id.toString();
                                                                            getCommentController.type = 'askrecommandation';
                                                                            commentBottomSheet(context);
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
                                                                                "Comments:   ${profileController.modal.value.data!
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
                                          : profileController.statusOfProfile.value.isError
                                              ? CommonErrorWidget(
                                                  errorText: "",
                                                  onTap: () {},
                                                )
                                              : const Center(child: CircularProgressIndicator());
                                    })
                                  ],
                                ),
                              ),
                              SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(()=> const MyRecommendationsCategory());
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
                                                profileController.check = false;
                                                profileController.getData();
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
                                            if(profileController.check == true)
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
                                            // SizedBox(
                                            //     height: size.height * .15,
                                            //     child: Obx(() {
                                            //       return profileController.statusOfProfile.value.isSuccess &&
                                            //               statusOfCategories.value.isSuccess
                                            //           ? ListView.builder(
                                            //               itemCount:
                                            //                   profileController.modal.value.data!.myCategories!.length,
                                            //               shrinkWrap: true,
                                            //               scrollDirection: Axis.horizontal,
                                            //               physics: const NeverScrollableScrollPhysics(),
                                            //               itemBuilder: (context, index) {
                                            //                 return Padding(
                                            //                   padding: const EdgeInsets.all(8.0),
                                            //                   child: GestureDetector(
                                            //                     onTap: () {
                                            //
                                            //                     },
                                            //                     child: Column(
                                            //                       children: [
                                            //                         ClipOval(
                                            //                           child: CachedNetworkImage(
                                            //                             width: 60,
                                            //                             height: 60,
                                            //                             fit: BoxFit.fill,
                                            //                             imageUrl: profileController
                                            //                                 .modal.value.data!.myCategories![index].image
                                            //                                 .toString(),
                                            //                           ),
                                            //                         ),
                                            //                         const SizedBox(
                                            //                           height: 2,
                                            //                         ),
                                            //                         Text(
                                            //                           profileController
                                            //                               .modal.value.data!.myCategories![index].name
                                            //                               .toString(),
                                            //                           style: GoogleFonts.mulish(
                                            //                               fontWeight: FontWeight.w300,
                                            //                               // letterSpacing: 1,
                                            //                               fontSize: 14,
                                            //                               color: const Color(0xFF26282E)),
                                            //                         )
                                            //                       ],
                                            //                     ),
                                            //                   ),
                                            //                 );
                                            //               })
                                            //           : profileController.statusOfProfile.value.isError
                                            //               ? CommonErrorWidget(
                                            //                   errorText: "",
                                            //                   onTap: () {},
                                            //                 )
                                            //               : const Center(child: CircularProgressIndicator());
                                            //     })),
                                            // const SizedBox(
                                            //   width: 20,
                                            // )
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          if (profileController.check == true)
                                            profileController.statusOfSingle.value.isSuccess
                                                ? Column(
                                                    children: [
                                                      if (profileController.single.value.data!.details!.isEmpty) const Text("No Record found"),
                                                      GridView.builder(
                                                        padding: EdgeInsets.zero,
                                                        shrinkWrap: true,
                                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 3,
                                                          // Number of columns
                                                          crossAxisSpacing: 10.0,
                                                          // Spacing between columns
                                                          mainAxisSpacing: 10.0, // Spacing between rows
                                                        ),
                                                        itemCount:  profileController.single.value.data!.details!.length,
                                                        // Total number of items
                                                        itemBuilder: (BuildContext context, int index) {
                                                          // You can replace the Container with your image widget
                                                          return GestureDetector(
                                                            onTap: () {
                                                              print(
                                                                "id:::::::::::::::::::::::::::::" +
                                                                    profileController.single.value.data!.details![index].id.toString(),
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
                                                              imageUrl:  profileController.single.value.data!.details![index].image.toString(),
                                                              fit: BoxFit.fill,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  )
                                                :  profileController.statusOfSingle.value.isError
                                                    ? CommonErrorWidget(
                                                        errorText: "",
                                                        onTap: () {},
                                                      )
                                                    : const Center(child: SizedBox()),
                                          if (profileController.check == false)
                                            // if (profileController.modal.value.data!.myRecommandation!.isEmpty)
                                            //   const Text("No data found "),
                                            profileController.statusOfProfile.value.isSuccess
                                                ? SingleChildScrollView(
                                                    child: profileController.modal.value.data!.myRecommandation != null &&
                                                            profileController.modal.value.data!.myRecommandation!.isNotEmpty
                                                        ? GridView.builder(
                                                            physics: const BouncingScrollPhysics(),
                                                            padding: const EdgeInsets.only(bottom: 50),
                                                            shrinkWrap: true,
                                                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount: 3,
                                                              // Number of columns
                                                              crossAxisSpacing: 10.0,
                                                              // Spacing between columns
                                                              mainAxisSpacing: 10.0, // Spacing between rows
                                                            ),
                                                            itemCount: profileController.modal.value.data!.myRecommandation!.length,
                                                            // Total number of items
                                                            itemBuilder: (BuildContext context, int index) {
                                                              // You can replace the Container with your image widget
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  Get.toNamed(
                                                                    MyRouters.singleScreen,
                                                                    arguments: [
                                                                      profileController
                                                                          .modal.value.data!.myRecommandation![index].image
                                                                          .toString(),
                                                                      profileController
                                                                          .modal.value.data!.myRecommandation![index].title
                                                                          .toString(),
                                                                      profileController
                                                                          .modal.value.data!.myRecommandation![index].review
                                                                          .toString(),
                                                                      profileController
                                                                          .modal.value.data!.myRecommandation![index].id
                                                                          .toString(),
                                                                      profileController
                                                                          .modal.value.data!.myRecommandation![index].link
                                                                          .toString(),
                                                                    ],
                                                                  );
                                                                  print("object");
                                                                },
                                                                child: CachedNetworkImage(
                                                                  imageUrl: profileController
                                                                      .modal.value.data!.myRecommandation![index].image
                                                                      .toString(),
                                                                  fit: BoxFit.fill,
                                                                  height: 110,
                                                                  errorWidget: (_, __, ___) => const Icon(
                                                                    Icons.error_outline_outlined,
                                                                    color: Colors.red,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          )
                                                        : Padding(
                                                            padding: EdgeInsets.symmetric(vertical: Get.height / 6),
                                                            child: Center(
                                                                child: Text(
                                                              'No Data Found',
                                                              style: GoogleFonts.mulish(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 15,
                                                                  color: Colors.black),
                                                            )),
                                                          ),
                                                  )
                                                : profileController.statusOfProfile.value.isError
                                                    ? CommonErrorWidget(
                                                        errorText: "",
                                                        onTap: () {},
                                                      )
                                                    : const Center(child: SizedBox()),
                                          const SizedBox(
                                            height: 300,
                                          )
                                        ],
                                      ),
                                      // SizedBox(height: 100,)
                                    ],
                                  ),
                                ),
                              ),
                              // if (profileController.modal.value.data!.saveRecommandation!.isNotEmpty)
                              SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Obx(() {
                                        return profileController.statusOfProfile.value.isSuccess
                                            ? Column(
                                                children: [
                                                  profileController.modal.value.data!.saveRecommandation!= null &&  profileController.modal.value.data!.saveRecommandation!.isNotEmpty ?
                                                  ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount:
                                                          profileController.modal.value.data!.saveRecommandation!.length,
                                                      physics: const NeverScrollableScrollPhysics(),
                                                      itemBuilder: (context, index) {
                                                        return Column(
                                                          children: [
                                                            profileController.modal.value.data!.saveRecommandation != null &&
                                                                    profileController.modal.value.data!
                                                                            .saveRecommandation![index].post !=
                                                                        null
                                                                ? Container(
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
                                                                            ClipOval(
                                                                              child: profileController
                                                                                          .modal
                                                                                          .value
                                                                                          .data!
                                                                                          .saveRecommandation![index]
                                                                                          .post!
                                                                                          .user!
                                                                                          .profileImage !=
                                                                                      null
                                                                                  ? CachedNetworkImage(
                                                                                      width: 30,
                                                                                      height: 30,
                                                                                      fit: BoxFit.cover,
                                                                                      imageUrl: profileController
                                                                                          .modal
                                                                                          .value
                                                                                          .data!
                                                                                          .saveRecommandation![index]
                                                                                          .post!
                                                                                          .user!
                                                                                          .profileImage
                                                                                          .toString(),
                                                                                      // placeholder: (context, url) =>
                                                                                      //     Image.asset(AppAssets.girl),
                                                                                      // errorWidget: (context, url, error) =>
                                                                                      //     Image.asset(AppAssets.girl),
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
                                                                                  profileController
                                                                                                  .modal
                                                                                                  .value
                                                                                                  .data!
                                                                                                  .saveRecommandation![index]
                                                                                                  .post!
                                                                                                  .user!
                                                                                                  .name
                                                                                                  .toString() ==
                                                                                              "" &&
                                                                                          profileController
                                                                                                  .modal
                                                                                                  .value
                                                                                                  .data!
                                                                                                  .saveRecommandation![index]
                                                                                                  .post!
                                                                                                  .user!
                                                                                                  .name ==
                                                                                              null
                                                                                      ? Text(
                                                                                          "Name...",
                                                                                          style: GoogleFonts.mulish(
                                                                                              fontWeight: FontWeight.w700,
                                                                                              // letterSpacing: 1,
                                                                                              fontSize: 14,
                                                                                              color: Colors.black),
                                                                                        )
                                                                                      : Text(
                                                                                          profileController
                                                                                              .modal
                                                                                              .value
                                                                                              .data!
                                                                                              .saveRecommandation![index]
                                                                                              .post!
                                                                                              .user!
                                                                                              .name
                                                                                              .toString(),
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
                                                                                    .saveRecommandation![index]
                                                                                    .post!
                                                                                    .image ==
                                                                                ""
                                                                            ? SizedBox()
                                                                            : ClipRRect(
                                                                                borderRadius: BorderRadius.circular(10),
                                                                                child: CachedNetworkImage(
                                                                                  width: size.width,
                                                                                  height: 200,
                                                                                  fit: BoxFit.fill,
                                                                                  imageUrl: profileController
                                                                                      .modal
                                                                                      .value
                                                                                      .data!
                                                                                      .saveRecommandation![index]
                                                                                      .post!
                                                                                      .image
                                                                                      .toString(),
                                                                                  placeholder: (context, url) => SizedBox(
                                                                                    height: 0,
                                                                                  ),
                                                                                  errorWidget: (context, url, error) =>
                                                                                      SizedBox(
                                                                                    height: 0,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                        const SizedBox(
                                                                          height: 10,
                                                                        ),
                                                                        Text(
                                                                          profileController.modal.value.data!
                                                                              .saveRecommandation![index].post!.title
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
                                                                        GestureDetector(
                                                                          onTap: () async {
                                                                            //output: Hello%20Flutter
                                                                            Uri mail = Uri.parse(
                                                                              "https://" +
                                                                                  profileController.modal.value.data!
                                                                                      .saveRecommandation![index].post!.link
                                                                                      .toString(),
                                                                            );
                                                                            if (await launchUrl(mail)) {
                                                                              //email app opened
                                                                            } else {
                                                                              //email app is not opened
                                                                            }
                                                                          },
                                                                          child: profileController
                                                                                      .modal
                                                                                      .value
                                                                                      .data!
                                                                                      .saveRecommandation![index]
                                                                                      .post!
                                                                                      .description !=
                                                                                  null
                                                                              ? Text(
                                                                                  profileController
                                                                                      .modal
                                                                                      .value
                                                                                      .data!
                                                                                      .saveRecommandation![index]
                                                                                      .post!
                                                                                      .description
                                                                                      .toString(),
                                                                                  style: GoogleFonts.mulish(
                                                                                      fontWeight: FontWeight.w300,
                                                                                      // letterSpacing: 1,
                                                                                      fontSize: 14,
                                                                                      color: const Color(0xFF6F7683)),
                                                                                )
                                                                              : SizedBox(),
                                                                        ),
                                                                        const SizedBox(
                                                                          height: 10,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )
                                                                : const Text("No data found "),
                                                            const SizedBox(
                                                              height: 15,
                                                            )
                                                          ],
                                                        );
                                                      }) : Padding(
                                                    padding: EdgeInsets.symmetric(vertical: Get.height / 5),
                                                    child: Center(child: Text('No Data Found', style: GoogleFonts.mulish(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 15,
                                                        color: Colors.black
                                                    ),)),
                                                  ),
                                                  const SizedBox(
                                                    height: 350,
                                                  )
                                                ],
                                              )
                                            : profileController.statusOfProfile.value.isError
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
                            ]),
                          ),
                        ],
                      )
                    : profileController.statusOfProfile.value.isError
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
          maxHeight: hieght * .7,
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
        backgroundColor: Colors.transparent,
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
        ),
        builder: (BuildContext context) {
          return  const CommentScreen();
        });
  }
}
