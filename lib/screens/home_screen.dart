// import 'dart:io';

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:referral_app/controller/homeController.dart';
import 'package:referral_app/widgets/app_assets.dart';
import 'package:referral_app/widgets/custome_textfiled.dart';
import 'package:referral_app/widgets/helper.dart';
import 'package:share_plus/share_plus.dart';
import '../controller/profile_controller.dart';
import '../controller/wishlist controller.dart';
import '../models/all_recommendation_model.dart';
import '../models/categories_model.dart';
import '../models/home_page_model.dart';
import '../models/model_review_list.dart';
import '../models/remove_reomeendation.dart';
import '../models/single_product_model.dart';
import '../repositories/all_recommendation_repo.dart';
import '../repositories/categories_repo.dart';
import '../repositories/home_pafe_repo.dart';
import '../repositories/remove_bookmark_repo.dart';
import '../repositories/repo_review_list.dart';
import '../repositories/single_produc_repo.dart';
import '../resourses/api_constant.dart';
import '../routers/routers.dart';
import '../widgets/app_theme.dart';
import '../widgets/common_error_widget.dart';

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

  Rx<RxStatus> statusOfCategories = RxStatus.empty().obs;
  Rx<HomeModel> homeModel = HomeModel().obs;
  Rx<CategoriesModel> categories = CategoriesModel().obs;
  Rx<RxStatus> statusOfSingle = RxStatus.empty().obs;
  Rx<SingleProduct> single = SingleProduct().obs;

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

  Rx<RxStatus> statusOfAllRecommendation = RxStatus.empty().obs;
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

  Rx<RxStatus> statusOfHome = RxStatus.empty().obs;
  final wishListController = Get.put(WishListController());
  final profileController = Get.put(ProfileController());

  Rx<RemoveRecommendationModel> modalRemove = RemoveRecommendationModel().obs;
  Rx<RxStatus> statusOfRemove = RxStatus.empty().obs;
  Rx<HomeModel> home = HomeModel().obs;
  bool like = false;
  RxString type = ''.obs;
  String? id;
  Rx<RxStatus> statusOfReviewList = RxStatus.empty().obs;
  Rx<ModelReviewList> modelReviewList = ModelReviewList().obs;

  reviewList(id) {
    // modelReviewList.value.data!.clear();
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

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      // homeController.page.value = homeController.page.value + 1;
      homeController.getPaginate();
      print("call");
    } else {
      print("Don't call");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('value>>>>>>>>>>>>>>${homeController.isDataLoading.value}');
    scrollController.addListener((_scrollListener));
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_tabListener);
    profileController.getData();
    /* homeController..getFeedBack().then((value) (value1){
        if(value1.)
    })*/
    homeController.getPaginate();
    homeController.getData();
    all();
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
  bool check = false;

  @override
  Widget build(BuildContext context) {
    //chooseCategories();
    var size = MediaQuery.of(context).size;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
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
                        child: ClipOval(
                          child: CachedNetworkImage(
                              height: 100,
                              fit: BoxFit.fill,
                              imageUrl: profileController.modal.value.data!.user!.profileImage.toString(),
                              errorWidget: (context, url, error) => const SizedBox()),
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
                Padding(
                  padding: const EdgeInsets.only(right: 14.0),
                  child: InkWell(
                      onTap: () {
                        Get.toNamed(MyRouters.searchScreen);
                      },
                      child: SvgPicture.asset(AppAssets.search)),
                )
              ],
              bottom: TabBar(
                controller: _tabController,

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
                    child: Text("Recco Feed",
                        style: currentDrawer == 0
                            ? GoogleFonts.mulish(
                                fontWeight: FontWeight.w700, letterSpacing: 1, fontSize: 15, color: const Color(0xFF3797EF))
                            : GoogleFonts.mulish(
                                fontWeight: FontWeight.w700, letterSpacing: 1, fontSize: 15, color: Colors.black)),
                  ),
                  Tab(
                    child: Text("Discover",
                        style: currentDrawer == 1
                            ? GoogleFonts.mulish(
                                fontWeight: FontWeight.w700, letterSpacing: 1, fontSize: 15, color: const Color(0xFF3797EF))
                            : GoogleFonts.mulish(
                                fontWeight: FontWeight.w700, letterSpacing: 1, fontSize: 15, color: Colors.black)),
                  ),
                ],
              ),
            ),
            body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(() {
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
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                Get.toNamed(MyRouters.allUserProfileScreen, arguments: [
                                                                  homeController
                                                                      .homeModel.value.data!.discover![index].userId!.id
                                                                      .toString()
                                                                ]);
                                                              },
                                                              child: ClipOval(
                                                                child: CachedNetworkImage(
                                                                  width: 30,
                                                                  height: 30,
                                                                  fit: BoxFit.cover,
                                                                  imageUrl: homeController.homeModel.value.data!
                                                                              .discover![index].userId ==
                                                                          null
                                                                      ? AppAssets.man
                                                                      : homeController.homeModel.value.data!.discover![index]
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
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  homeController.homeModel.value.data!.discover![index]
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
                                                                          homeController.homeModel.value.data!
                                                                              .discover![index].userId!.name
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
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(right: 8.0),
                                                              child: Obx(() {
                                                                return InkWell(
                                                                  onTap: () {
                                                                    // home.value.data!.discover![index].wishlist.toString();

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
                                                                );
                                                              }),
                                                            ),
                                                            const SizedBox(
                                                              width: 15,
                                                            ),
                                                            InkWell(
                                                                onTap: () {
                                                                  Share.share(
                                                                    homeController
                                                                        .homeModel.value.data!.discover![index].image
                                                                        .toString(),
                                                                  );
                                                                },
                                                                child: SvgPicture.asset(AppAssets.forward))
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
                                                                  fit: BoxFit.fill,
                                                                  imageUrl: homeController
                                                                      .homeModel.value.data!.discover![index].image
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
                                                          homeController.homeModel.value.data!.discover![index].title
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
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                reviewList(homeController
                                                                    .homeModel.value.data!.discover![index].id
                                                                    .toString());
                                                                showModalBottomSheet(
                                                                  enableDrag: true,
                                                                  isDismissible: true,
                                                                  constraints: BoxConstraints(
                                                                    maxHeight: context.getSize.height * .9,
                                                                  ),
                                                                  isScrollControlled: true,
                                                                  context: context,
                                                                  backgroundColor: Colors.white,
                                                                  elevation: 10,
                                                                  shape: const RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.only(
                                                                        topRight: Radius.circular(10),
                                                                        topLeft: Radius.circular(10)),
                                                                  ),
                                                                  builder: (BuildContext context) {
                                                                    // UDE : SizedBox instead of Container for whitespaces
                                                                    return SingleChildScrollView(
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.symmetric(
                                                                            horizontal: 12, vertical: 20),
                                                                        child: Column(
                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: <Widget>[
                                                                            Row(
                                                                              mainAxisAlignment:
                                                                                  MainAxisAlignment.spaceBetween,
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
                                                                                GestureDetector(
                                                                                    onTap: () {
                                                                                      Get.back();
                                                                                    },
                                                                                    child: const Icon(Icons.close)),
                                                                                SizedBox(
                                                                                  height: 10,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            statusOfReviewList.value.isSuccess
                                                                                ? SingleChildScrollView(
                                                                                    child: Obx(() {
                                                                                      return Column(
                                                                                        children: [
                                                                                          ListView.builder(
                                                                                            physics: const ScrollPhysics(),
                                                                                            itemCount: modelReviewList
                                                                                                .value.data!.length,
                                                                                            scrollDirection: Axis.vertical,
                                                                                            shrinkWrap: true,
                                                                                            itemBuilder: (context, index) {
                                                                                              return Padding(
                                                                                                padding:
                                                                                                    const EdgeInsets.only(
                                                                                                        left: 8.0, top: 10),
                                                                                                child: Row(
                                                                                                  mainAxisAlignment:
                                                                                                      MainAxisAlignment
                                                                                                          .start,
                                                                                                  crossAxisAlignment:
                                                                                                      CrossAxisAlignment
                                                                                                          .start,
                                                                                                  children: [
                                                                                                    ClipOval(
                                                                                                      child:
                                                                                                          CachedNetworkImage(
                                                                                                        width: 30,
                                                                                                        height: 30,
                                                                                                        fit: BoxFit.cover,
                                                                                                        imageUrl:
                                                                                                            modelReviewList
                                                                                                                .value
                                                                                                                .data![index]
                                                                                                                .user!
                                                                                                                .profileImage
                                                                                                                .toString(),
                                                                                                        placeholder: (context,
                                                                                                                url) =>
                                                                                                            const SizedBox(),
                                                                                                        errorWidget: (context,
                                                                                                                url,
                                                                                                                error) =>
                                                                                                            const SizedBox(),
                                                                                                      ),
                                                                                                    ),
                                                                                                    const SizedBox(
                                                                                                      width: 10,
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                      child: Container(
                                                                                                        padding:
                                                                                                            const EdgeInsets
                                                                                                                .symmetric(
                                                                                                                vertical: 10,
                                                                                                                horizontal:
                                                                                                                    10),
                                                                                                        decoration: const BoxDecoration(
                                                                                                            borderRadius: BorderRadius.only(
                                                                                                                bottomRight: Radius
                                                                                                                    .circular(
                                                                                                                        10),
                                                                                                                bottomLeft: Radius
                                                                                                                    .circular(
                                                                                                                        10),
                                                                                                                topRight: Radius
                                                                                                                    .circular(
                                                                                                                        10)),
                                                                                                            color: Color(
                                                                                                                0xffF0F0F0)),
                                                                                                        child: Column(
                                                                                                          crossAxisAlignment:
                                                                                                              CrossAxisAlignment
                                                                                                                  .start,
                                                                                                          children: [
                                                                                                            Row(
                                                                                                              children: [
                                                                                                                Text(
                                                                                                                  overflow:TextOverflow.ellipsis,
                                                                                                                  modelReviewList
                                                                                                                      .value
                                                                                                                      .data![
                                                                                                                          index]
                                                                                                                      .user!
                                                                                                                      .name
                                                                                                                      .toString(),
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
                                                                                                      
                                                                                                                  ),
                                                                                                      
                                                                                                                ),
                                                                                                                const SizedBox(
                                                                                                                  width: 10,
                                                                                                                ),
                                                                                                                Text(
                                                                                                                  modelReviewList
                                                                                                                      .value
                                                                                                                      .data![
                                                                                                                          index]
                                                                                                                      .date
                                                                                                                      .toString(),
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
                                                                                                                  ),
                                                                                                                ),
                                                                                                                const SizedBox(
                                                                                                                  width: 50,
                                                                                                                ),
                                                                                                                InkWell(
                                                                                                                    onTap: () {
                                                                                                                      // home.value.data!.discover![index].wishlist.toString();
                                                                                                                    },
                                                                                                                    child:
                                                                                                                        const Icon(
                                                                                                                      Icons
                                                                                                                          .favorite_outline,
                                                                                                                      color: Color(
                                                                                                                          0xff134563),
                                                                                                                    ))
                                                                                                              ],
                                                                                                            ),
                                                                                                            SizedBox(
                                                                                                              height:
                                                                                                                  size.height *
                                                                                                                      .02,
                                                                                                            ),
                                                                                                            Text(
                                                                                                              modelReviewList
                                                                                                                  .value
                                                                                                                  .data![index]
                                                                                                                  .review
                                                                                                                  .toString(),
                                                                                                              style:
                                                                                                                  GoogleFonts
                                                                                                                      .mulish(
                                                                                                                fontWeight:
                                                                                                                    FontWeight
                                                                                                                        .w600,
                                                                                                                // letterSpacing: 1,
                                                                                                                fontSize: 14,
                                                                                                                color: Colors
                                                                                                                    .black,
                                                                                                              ),
                                                                                                            )
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
                                                                                              Get.toNamed(MyRouters
                                                                                                  .addRecommendationScreen);
                                                                                            },
                                                                                            child: const CommonButton(
                                                                                                title:
                                                                                                    "Send Recommendation"),
                                                                                          ),
                                                                                          const SizedBox(
                                                                                            height: 20,
                                                                                          )
                                                                                        ],
                                                                                      );
                                                                                    }),
                                                                                  )
                                                                                : const Center(
                                                                                    child: Text('No Data Available')),
                                                                            const SizedBox(
                                                                              height: 20,
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              child: Container(
                                                                padding: const EdgeInsets.all(5),
                                                                width: size.width * .45,
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
                                                                      "Recommendation: ${homeController.homeModel.value.data!.discover![index].reviewCount.toString()}",
                                                                      style: GoogleFonts.mulish(
                                                                          fontWeight: FontWeight.w500,
                                                                          // letterSpacing: 1,
                                                                          fontSize: 11,
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
                                                                    homeController
                                                                            .homeModel.value.data!.discover![index].minPrice
                                                                            .toString()
                                                                            .isNotEmpty
                                                                        ? const Text("Min Price")
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
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    homeController
                                                                            .homeModel.value.data!.discover![index].maxPrice
                                                                            .toString()
                                                                            .isNotEmpty
                                                                        ? const Text("Max Price")
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
                                                  const SizedBox(
                                                    height: 15,
                                                  )
                                                ],
                                              );
                                            })
                                        // : statusOfHome.value.isError
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
                    SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      check = false;
                                      all();
                                      setState(() {});
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: height * .04),
                                      child: Container(
                                        decoration:
                                            BoxDecoration(border: Border.all(color: Colors.black), shape: BoxShape.circle),
                                        child: const CircleAvatar(
                                            radius: 35,
                                            backgroundColor: Colors.transparent,
                                            child: Text(
                                              'View All',
                                              style: TextStyle(color: Colors.black, fontSize: 14),
                                            )),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                      height: size.height * .15,
                                      child: Obx(() {
                                        return statusOfCategories.value.isSuccess &&
                                                profileController.statusOfProfile.value.isSuccess
                                            ? ListView.builder(
                                                itemCount: categories.value.data!.length,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.horizontal,
                                                /*  physics:
                                                    const AlwaysScrollableScrollPhysics(),*/
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Column(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            getSingleRepo(
                                                                    category_id: categories.value.data![index].id.toString())
                                                                .then((value) {
                                                              single.value = value;
                                                              if (value.status == true) {
                                                                statusOfSingle.value = RxStatus.success();
                                                                check = true;
                                                                setState(() {});
                                                              } else {
                                                                statusOfSingle.value = RxStatus.error();
                                                              }
                                                              setState(() {});
                                                              // showToast(value.message.toString());
                                                            });
                                                          },
                                                          child: ClipOval(
                                                            child: CachedNetworkImage(
                                                              width: 70,
                                                              height: 70,
                                                              fit: BoxFit.fill,
                                                              imageUrl: categories.value.data![index].image.toString(),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 2,
                                                        ),
                                                        Text(
                                                          categories.value.data![index].name.toString(),
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
                                            : statusOfCategories.value.isError
                                                ? CommonErrorWidget(
                                                    errorText: "",
                                                    onTap: () {},
                                                  )
                                                : const Center(child: CircularProgressIndicator());
                                      })),
                                ],
                              ),
                            ),
                            if (check == true)
                              statusOfSingle.value.isSuccess
                                  ? Column(
                                      children: [
                                        if (single.value.data!.isEmpty) const Text("No Record found"),
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
                                          itemCount: single.value.data!.length,
                                          // Total number of items
                                          itemBuilder: (BuildContext context, int index) {
                                            // You can replace the Container with your image widget
                                            return InkWell(
                                              onTap: () {
                                                print( "id:::::::::::::::::::::::::::::"+single.value.data![index].id.toString(),);
                                                Get.toNamed(
                                                  MyRouters.recommendationSingleScreen,
                                                  arguments: [
                                                    single.value.data![index].id.toString(),

                                                  ],
                                                );
                                                print("object");
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black),
                                                    borderRadius: BorderRadius.circular(10)),
                                                child: CachedNetworkImage(
                                                  imageUrl: single.value.data![index].image.toString(),
                                                  fit: BoxFit.fill,
                                                ),
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
                            if (check == false)
                              statusOfAllRecommendation.value.isSuccess
                                  ? GridView.builder(
                                      padding: EdgeInsets.zero,
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        // Number of columns
                                        crossAxisSpacing: 10.0,
                                        // Spacing between columns
                                        mainAxisSpacing: 10.0, // Spacing between rows
                                      ),
                                      itemCount: allRecommendation.value.data!.length,
                                      // Total number of items
                                      itemBuilder: (BuildContext context, int index) {
                                        // You can replace the Container with your image widget
                                        return InkWell(
                                          onTap: () {
                                            log("tgrhtr"+allRecommendation.value.data![index].wishlist.toString());
                                            Get.toNamed(
                                              MyRouters.recommendationSingleScreen,
                                              arguments: [
                                                allRecommendation.value.data![index].image.toString(),
                                                allRecommendation.value.data![index].title.toString(),
                                                allRecommendation.value.data![index].review.toString(),
                                                allRecommendation.value.data![index].id.toString(),
                                                allRecommendation.value.data![index].link.toString(),
                                                allRecommendation.value.data![index].wishlist,
                                              ],
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black),
                                                borderRadius: BorderRadius.circular(10)),
                                            child: CachedNetworkImage(
                                              imageUrl: allRecommendation.value.data![index].image.toString(),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : statusOfAllRecommendation.value.isError
                                      ? CommonErrorWidget(
                                          errorText: "",
                                          onTap: () {},
                                        )
                                      : const Center(child: CircularProgressIndicator()),
                          ],
                        ),
                      ),
                    ),
                  ]);
                }))));
  }
}
