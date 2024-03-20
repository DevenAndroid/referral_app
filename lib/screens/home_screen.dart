import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:referral_app/controller/homeController.dart';
import 'package:referral_app/screens/recommendation_single_page.dart';
import 'package:referral_app/widgets/app_assets.dart';
import 'package:referral_app/widgets/custome_textfiled.dart';
import 'package:share_plus/share_plus.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controller/bottomNav_controller.dart';
import '../controller/get_comment_controller.dart';
import '../controller/get_recommendation_controller.dart';
import '../controller/notification_count_controller.dart';
import '../controller/profile_controller.dart';
import '../controller/wishlist controller.dart';
import '../models/all_recommendation_model.dart';
import '../models/categories_model.dart';
import '../models/get_comment_model.dart';
import '../models/get_update_model.dart';
import '../models/home_page_model.dart';
import '../models/model_review_list.dart';
import '../models/remove_reomeendation.dart';
import '../repositories/add_comment_repo.dart';
import '../repositories/all_recommendation_repo.dart';
import '../repositories/categories_repo.dart';
import '../repositories/get_comment_repo.dart';
import '../repositories/get_update_repo.dart';
import '../repositories/home_pafe_repo.dart';
import '../repositories/remove_bookmark_repo.dart';
import '../repositories/repo_add_like.dart';
import '../repositories/repo_delete_recomm.dart';
import '../repositories/repo_review_list.dart';
import '../resourses/api_constant.dart';
import '../routers/routers.dart';
import '../widgets/app_theme.dart';
import '../widgets/common_error_widget.dart';
import 'Discover_screen_for_home.dart';
import 'comment_screen.dart';
import 'get_recommendation_ui.dart';
import 'notification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final homeController = Get.put(HomeController());
  RxList<Discover> discoverList = <Discover>[].obs;
  final scrollController = ScrollController();

  /*RxInt page = 1.obs;
  RxInt pagination = 10.obs;
  Rx<HomeModel> paginationModel = HomeModel().obs;*/
  RxBool isDataLoading = false.obs;

  // RxBool isPaginationLoading = true.obs;
  RxBool loadMore = true.obs;

/* Future<dynamic> chooseCategories({
    isFirstTime = false,
  }) async {
    if (isFirstTime) {
      page.value = 1;
    }
    if (isPaginationLoading.value && loadMore.value) {
      isPaginationLoading.value = false;
    }




   getHomeRepo().then((value) {
     // loadMore.value = false;
     home.value = value;
      isPaginationLoading.value = true;
      if (value.data != null ) {
     //   loadMore.value = true;
        if(home.value.data!.discover!.isNotEmpty){
          discoverList.addAll(home.value.data!.discover!);
        }

        statusOfHome.value = RxStatus.success();
        page.value++;
        loadMore.value = value.link!.next ?? false;
     //   home.value.data!.discover!.clear();
      } else {
        statusOfHome.value = RxStatus.error();
      }
    });
  }*/
  /*
  Future<HomeModel> getFeedBack() async {
    HomeModel kk = await
  }
*/

  Rx<RxStatus> statusOfCategories = RxStatus
      .empty()
      .obs;
  Rx<HomeModel> homeModel = HomeModel().obs;
  Rx<CategoriesModel> categories = CategoriesModel().obs;

  // Rx<RxStatus> statusOfSingle = RxStatus.empty().obs;
  // Rx<SingleProduct> single = SingleProduct().obs;

  chooseCategories1() {
    getCategoriesRepo().then((value) {
      categories.value = value;

      if (value.status == true) {
        statusOfCategories.value = RxStatus.success();
      } else {
        statusOfCategories.value = RxStatus.error();
      }
      setState(() {});
      // showToast(value.message.toString());
    });
  }

  chooseCategories() {
    getHomeRepo(page: 1, pagination: 10).then((value) {
      homeModel.value = value;

      if (value.status == true) {
        statusOfCategories.value = RxStatus.success();
      } else {
        statusOfCategories.value = RxStatus.error();
      }
      setState(() {});
      // showToast(value.message.toString());
    });
  }

  Rx<RxStatus> statusOfAllRecommendation = RxStatus
      .empty()
      .obs;
  Rx<AllRecommendationModel> allRecommendation = AllRecommendationModel().obs;

  all() {
    getAllRepo().then((value) {
      allRecommendation.value = value;

      if (value.status == true) {
        statusOfAllRecommendation.value = RxStatus.success();
      } else {
        statusOfAllRecommendation.value = RxStatus.error();
      }

      // showToast(value.message.toString());
    });
  }

  Rx<RxStatus> statusOfHome = RxStatus
      .empty()
      .obs;
  final wishListController = Get.put(WishListController());
  final getCommentController = Get.put(GetCommentController());
  final getRecommendationController = Get.put(GetRecommendationController());
  final getcount = Get.put(NotificationCountController());
  final profileController = Get.put(ProfileController(), permanent: true);

  Rx<RemoveRecommendationModel> modalRemove = RemoveRecommendationModel().obs;
  Rx<HomeModel> home = HomeModel().obs;
  bool like = false;
  RxString type = ''.obs;
  String? id;

  // Rx<GetCommentModel> getCommentModel = GetCommentModel().obs;

  // reviewList(id) {
  //   // modelReviewList.value.data!.clear();
  //   print('id isss...${id.toString()}');
  //   getReviewListRepo(context: context, id: id).then((value) {
  //     getRecommendationController.modelReviewList.value = value;
  //     print('api iss CALL');
  //     if (value.status == true) {
  //       getRecommendationController.statusOfGetReco.value = RxStatus.success();
  //     } else {
  //       getRecommendationController.statusOfGetReco.value = RxStatus.error();
  //     }
  //     setState(() {});
  //   });
  // }

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


  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      // homeController.page.value = homeController.page.value + 1;
      homeController.getPaginate();
      print("call");
    } else {
      print("Don't call");
    }
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showToast('Could not launch $url');
    }
  }

  SampleItem? selectedMenu;



  Rx<RxStatus> statusOfGetUpdate = RxStatus
      .empty()
      .obs;
  Rx<GetUpdateModel> getUpdateModel = GetUpdateModel().obs;
  String currentVersion = '';
  String latestVersion = '';
  Future<void> checkVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      currentVersion = packageInfo.version;
    });

    // Replace 'YOUR_APP_ID' with your app's ID on the App Store
    final response = await http.get(
        Uri.parse("https://itunes.apple.com/lookup?bundleId=com.referralApp.referralApp"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['results'].isNotEmpty) {
        final appData = data['results'][0];
        final String latestVersion1 = appData['version'];

        setState(() {
          print("version>>>>>"+latestVersion1);
          latestVersion = latestVersion1;
          getUpdateVersion(version: latestVersion1.toString(),type: "ios").then((value) {
            getUpdateModel.value = value;
            print("object");
            if (value.data!.isUpdated == false) {
              print("api");
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('New Version Available'),
                      content: Text('A new version is available. Would you like to update?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            if(Platform.isAndroid){
                              // _launchPlayStore();
                            }
                            else if (Platform.isIOS){_launchAppStore();}

                          },
                          child: Text('Update Now'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Later'),
                        ),
                      ],
                    );
                  });
              statusOfGetUpdate.value = RxStatus.success();
            } else {
              statusOfGetUpdate.value = RxStatus.error();
            }
            setState(() {});
            // showToast(value.message.toString());
          });


        });
      }
    }
  }
  version() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform( );
    String appVersion = packageInfo.version;
    print('app version is${appVersion.toString()}');






  }
  _launchAppStore() async {
    const url =
        'https://apps.apple.com/in/app/recs/id6473147636'; // Replace this with your App Store link
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchPlayStore() async {
    final String packageName = 'com.chickenway.moka'; // Replace with your app's package name
    final url = 'market://details?id=$packageName';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      final fallbackUrl = 'https://play.google.com/store/apps/details?id=$packageName';
      await launch(fallbackUrl);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('value>>>>>>>>>>>>>>${homeController.isDataLoading.value}');
    checkVersion();

    scrollController.addListener((_scrollListener));
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_tabListener);
    // version();

    profileController.getData();
    getcount.getNotification();
    profileController.check = false;
    all();
    /* homeController..getFeedBack().then((value) (value1){
        if(value1.)
    })*/
    // reviewList(id);
    homeController.getPaginate();
    homeController.getData();
    chooseCategories();
    chooseCategories1();
  }

  late TabController _tabController;
  final key = GlobalKey<ScaffoldState>();

  void _tabListener() {
    setState(() {
      showFloatingActionButton = _tabController.index == 1; // 1 corresponds to "My recommendations"
    });
  }

  var currentDrawer = 0;
  bool showFloatingActionButton = false;

  // String selectedValue = 'friends';

  String post = "";
  String postId = "";

  final bottomController = Get.put(BottomNavBarController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return DefaultTabController(
        length: 2,
        child: UpgradeAlert(

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
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: Obx(() {
                  return profileController.statusOfProfile.value.isSuccess
                      ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        // Get.toNamed(MyRouters.profileScreen);
                        bottomController.updateIndexValue(2);
                      },
                      child: ClipOval(
                        child: CachedNetworkImage(
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                            imageUrl: profileController.modal.value.data!.user!.profileImage.toString(),
                          errorWidget: (context, url, error) =>  Container(
                              padding: const EdgeInsets.all(6),
                              decoration:
                              BoxDecoration(border: Border.all(color: Colors.black), shape: BoxShape.circle),
                              child: SvgPicture.asset('assets/icons/profile.svg')),),
                      ),
                    ),
                  )
                      : profileController.statusOfProfile.value.isError
                      ? const SizedBox()
                      : const Center(child: CircularProgressIndicator());
                }),
                title: Text(
                  "Home",
                  style: GoogleFonts.monomaniacOne(
                      fontWeight: FontWeight.w400, letterSpacing: 1, fontSize: 25, color: const Color(0xFF262626)),
                ),
                centerTitle: true,
                actions: [
                  Obx(() {
                    return Padding(
                      padding: const EdgeInsets.only(right: 14.0),
                      child: GestureDetector(
                          onTap: () {
                            Get.to(() => const NotificationScreen(), transition: Transition.fade);
                          },
                          child: homeController.homeModel.value.data!.notification == 'false' ? Image.asset(AppAssets.notification, height: 22,
                            width: 22,):
                          Image.asset(AppAssets.notification1, height: 22, width: 22,) ),
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.only(right: 14.0),
                    child: GestureDetector(
                        onTap: () {
                          Get.toNamed(MyRouters.searchScreen);
                        },
                        child: SvgPicture.asset(AppAssets.search)),
                  ),
                ],
                bottom: TabBar(
                  controller: _tabController,
                  labelColor: const Color(0xFF3797EF),
                  unselectedLabelColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: AppTheme.primaryColor,
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: 15),
                  // automaticIndicatorColorAdjustment: true,
                  onTap: (value) {
                    currentDrawer = value;
                    setState(() {});
                  },
                  tabs: [
                    Tab(
                      child: Text("Recs Feed",
                        style: GoogleFonts.mulish(
                          fontWeight: FontWeight.w700, fontSize: 15,
                        ),
                        // style: currentDrawer == 0
                        //     ? GoogleFonts.mulish(fontWeight: FontWeight.w700, fontSize: 15, color: const Color(0xFF3797EF))
                        //     : GoogleFonts.mulish(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black)
                      ),),
                    Tab(
                      child: Text("Discover",
                        style: GoogleFonts.mulish(
                          fontWeight: FontWeight.w700, fontSize: 15,
                        ),
                        // style: currentDrawer == 1
                        //     ? GoogleFonts.mulish(
                        //         fontWeight: FontWeight.w700, letterSpacing: 1, fontSize: 15, color: const Color(0xFF3797EF))
                        //     : GoogleFonts.mulish(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black)
                      ),
                    ),
                  ],
                ),
              ),
              body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(() {
                    if (profileController.refreshData1.value > 0) {}
                    return TabBarView(controller: _tabController, children: [
                      homeController.isDataLoading.value
                          ? SingleChildScrollView(
                        controller: scrollController,
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() {
                                if (homeController.refreshInt.value > 0) {}
                                return homeController.isDataLoading.value
                                    ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: homeController.paginationWorking
                                        ? homeController.homeModel.value.data!.discover!.length + 1
                                        : homeController.homeModel.value.data!.discover!.length,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      if (index == homeController.homeModel.value.data!.discover!.length) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
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
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: GestureDetector(
                                                        onTap: (){
                                                          homeController
                                                              .homeModel.value.data!.discover![index].userId!.myAccount == true ? bottomController.updateIndexValue(2)
                                                              : Get.toNamed(MyRouters.allUserProfileScreen, arguments: [
                                                            homeController
                                                                .homeModel.value.data!.discover![index].userId!.id
                                                                .toString(),
                                                          ]);
                                                        },
                                                        child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: (){
                                                                homeController
                                                                    .homeModel.value.data!.discover![index].userId!.myAccount == true ? bottomController.updateIndexValue(2)
                                                                    : Get.toNamed(MyRouters.allUserProfileScreen, arguments: [
                                                                  homeController
                                                                      .homeModel.value.data!.discover![index].userId!.id
                                                                      .toString(),
                                                                ]);
                                                              },
                                                              child:ClipOval(
                                                                child: CachedNetworkImage(
                                                                  height: 40,
                                                                  width: 40,
                                                                  fit: BoxFit.cover,
                                                                  imageUrl:  homeController.homeModel.value.data!
                                                                      .discover![index].userId ==
                                                                      null
                                                                      ? AppAssets.man
                                                                      : homeController.homeModel.value.data!.discover![index]
                                                                      .userId!.profileImage
                                                                      .toString(),
                                                                  errorWidget: (context, url, error) =>  Container(
                                                                      padding: const EdgeInsets.all(6),
                                                                      decoration:
                                                                      BoxDecoration(border: Border.all(color: Colors.black), shape: BoxShape.circle),
                                                                      child: SvgPicture.asset('assets/icons/profile.svg')),),
                                                              ),
          
          
          
          
                                                              // ClipOval(
                                                              //   child: CachedNetworkImage(
                                                              //     width: 40,
                                                              //     height: 40,
                                                              //     fit: BoxFit.cover,
                                                              //     imageUrl: homeController.homeModel.value.data!
                                                              //         .discover![index].userId ==
                                                              //         null
                                                              //         ? AppAssets.man
                                                              //         : homeController.homeModel.value.data!.discover![index]
                                                              //         .userId!.profileImage
                                                              //         .toString(),
                                                              //     errorWidget: (_, __, ___) =>
                                                              //         Image.asset(
                                                              //           AppAssets.man,
                                                              //           color: Colors.grey.shade200,
                                                              //         ),
                                                              //     placeholder: (_, __) =>
                                                              //         Image.asset(
                                                              //           AppAssets.man,
                                                              //           color: Colors.grey.shade200,
                                                              //         ),
                                                              //   ),
                                                              // ),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Flexible(
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  if(homeController.homeModel.value.data!.discover![index].userId != null)
                                                                  homeController.homeModel.value.data!.discover![index].userId
                                                                      ?.name ==
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
                                                                    homeController.homeModel.value.data!.discover![index].userId!.name.toString(),
                                                                    overflow: TextOverflow.fade,
                                                                    style: GoogleFonts.mulish(
                                                                        fontWeight: FontWeight.w700,
                                                                        // letterSpacing: 1,
                                                                        fontSize: 14,
                                                                        color: Colors.black),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 15,
                                                              width: 20,
                                                              child: VerticalDivider(
                                                                color: Color(0xffD9D9D9),
                                                              ),
                                                            ),
                                                            Text(
                                                              homeController
                                                                  .homeModel.value.data!.discover![index].date!.capitalizeFirst
                                                                  .toString(),
                                                              style: GoogleFonts.mulish(
                                                                fontWeight: FontWeight.w300,
                                                                // letterSpacing: 1,
                                                                fontSize: 12,
                                                                color: const Color(0xff878D98),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Obx(() {
                                                      return Padding(
                                                        padding: const EdgeInsets.symmetric(vertical: 6.0).copyWith(
                                                            bottom: 0
                                                        ),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            bookmarkRepo(
                                                              context: context,
                                                              post_id: homeController
                                                                  .homeModel.value.data!.discover![index].id
                                                                  .toString(),
                                                              type: "askrecommandation",
                                                            ).then((value) async {
                                                              modalRemove.value = value;
                                                              if (value.status == true) {
                                                                print('wishlist-----');
                                                                homeController.getData();
                                                                getRecommendationController.statusOfRemove.value =
                                                                    RxStatus.success();
                                                                //homeController.getPaginate();
          
                                                                // like=true;
                                                                showToast(value.message.toString());
                                                              } else {
                                                                getRecommendationController.statusOfRemove.value =
                                                                    RxStatus.error();
                                                                // like=false;
                                                                showToast(value.message.toString());
                                                              }
                                                            });
                                                            setState(() {});
                                                          },
                                                          child: homeController.homeModel.value.data!
                                                              .discover![index].wishlist ==
                                                              true
                                                              ? SvgPicture.asset(
                                                            AppAssets.bookmark1,
                                                            height: 20,
                                                          )
                                                              : SvgPicture.asset(AppAssets.bookmark),
                                                        ),
                                                      );
                                                    }),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(vertical: 4.0).copyWith(
                                                          bottom: 0
                                                      ),
                                                      child: GestureDetector(
                                                          onTap: () {
                                                            Share.share(
                                                              homeController
                                                                  .homeModel.value.data!.discover![index].image
                                                                  .toString()+" Description:- "+homeController
                                                                  .homeModel.value.data!.discover![index].description
                                                                  .toString(),
                                                            );
                                                          },
                                                          child: SvgPicture.asset(AppAssets.forward)),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                homeController.homeModel.value.data!.discover![index].image == ""
                                                    ? const SizedBox()
                                                    : ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: CachedNetworkImage(
                                                    width: size.width,
                                                    height: 200,
                                                    fit: BoxFit.contain,
                                                    imageUrl: homeController
                                                        .homeModel.value.data!.discover![index].image
                                                        .toString(),
                                                    placeholder: (context, url) =>
                                                    const SizedBox(
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
                                                  homeController.homeModel.value.data!.discover![index].title
                                                      .toString()
                                                      .capitalize
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
                                                  homeController.homeModel.value.data!.discover![index].description
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
                                                    homeController
                                                        .homeModel.value.data!.discover![index].minPrice
                                                        .toString()
                                                        .isNotEmpty
                                                        ? const Text("Min Price :")
                                                        : const Text('No Budget'),
                                                    homeController
                                                        .homeModel.value.data!.discover![index].minPrice
                                                        .toString()
                                                        .isNotEmpty
                                                        ? Text(
                                                      homeController.homeModel.value.data!
                                                          .discover![index].minPrice
                                                          .toString(),
                                                    )
                                                        : const SizedBox(),
                                                    const SizedBox(
                                                      width: 30,
                                                    ),
                                                    homeController
                                                        .homeModel.value.data!.discover![index].maxPrice
                                                        .toString()
                                                        .isNotEmpty
                                                        ? const Text("Max Price :")
                                                        : const SizedBox(),
                                                    homeController
                                                        .homeModel.value.data!.discover![index].maxPrice
                                                        .toString()
                                                        .isNotEmpty
                                                        ? Text(
                                                      homeController.homeModel.value.data!
                                                          .discover![index].maxPrice
                                                          .toString(),
                                                    )
                                                        : const SizedBox(),
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
                                                          //  getReviewListRepo(
                                                          //      context: context,
                                                          //      id: homeController
                                                          //          .homeModel.value.data!.discover![index].id
                                                          //          .toString())
                                                          //      .then((value) async {
                                                          //    modelReviewList.value = value;
                                                          //
                                                          //    if (value.status == true) {
                                                          //     await homeController.getData();
                                                          //      statusOfReviewList.value = RxStatus.success();
                                                          //      post = homeController
                                                          //          .homeModel.value.data!.discover![index].id
                                                          //          .toString();
                                                          //      print('Id Is....${homeController.homeModel.value.data!
                                                          //          .discover![index].id}');
                                                          //      _settingModalBottomSheet(context);
                                                          //    } else {
                                                          //      statusOfReviewList.value = RxStatus.error();
                                                          //    }
                                                          //    setState(() {});
                                                          //  });
                                                          // setState(() {});
                                                          setState(() {
                                                            getRecommendationController.idForReco =
                                                                homeController.homeModel.value.data!.discover![index].id
                                                                    .toString();
                                                            getRecommendationController.idForAskReco =
                                                                homeController.homeModel.value.data!.discover![index].id
                                                                    .toString();
                                                            getRecommendationController.settingModalBottomSheet(context);
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
                                                                    "Recommendation: ${homeController.homeModel.value.data!
                                                                        .discover![index].reviewCount.toString()}",
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
                                                            getCommentController.id = homeController
                                                                .homeModel.value.data!.discover![index].id
                                                                .toString();
                                                            getCommentController.type = 'askrecommandation';
                                                            getRecommendationController.commentBottomSheet(context);
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
                                                                "Comments:   ${homeController.homeModel.value.data!
                                                                    .discover![index].commentCount.toString()}",
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
                                            height: 15,
                                          )
                                        ],
                                      );
                                    }) // : statusOfHome.value.isError
                                /* ? CommonErrorWidget(
                                        errorText: "",
                                        onTap: () {},
                                      )*/
                                    : const Center(child: CircularProgressIndicator());
                              })
                            ],
                          ),
                        ),
                      )
                          : const Center(child: CircularProgressIndicator()),
                      const DiscoverScreenHome()
                    ]);
                  }))),
        ));
  }
}
