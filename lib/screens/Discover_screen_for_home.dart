import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:referral_app/controller/homeController.dart';
import 'package:referral_app/screens/recommendation_single_page.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controller/get_comment_controller.dart';
import '../controller/get_recommendation_controller.dart';
import '../controller/profile_controller.dart';
import '../controller/wishlist controller.dart';
import '../models/all_recommendation_model.dart';
import '../models/categories_model.dart';
import '../models/home_page_model.dart';
import '../models/remove_reomeendation.dart';
import '../repositories/all_recommendation_repo.dart';
import '../repositories/categories_repo.dart';
import '../repositories/home_pafe_repo.dart';
import '../resourses/api_constant.dart';
import '../routers/routers.dart';
import '../widgets/app_theme.dart';
import '../widgets/common_error_widget.dart';


class DiscoverScreenHome extends StatefulWidget {
  const DiscoverScreenHome({super.key});

  @override
  State<DiscoverScreenHome> createState() => _DiscoverScreenHomeState();
}

class _DiscoverScreenHomeState extends State<DiscoverScreenHome> {
  final homeController = Get.put(HomeController());
  RxList<Discover> discoverList = <Discover>[].obs;
  final scrollController = ScrollController();
  RxBool isDataLoading = false.obs;
  RxBool loadMore = true.obs;
  Rx<RxStatus> statusOfCategories = RxStatus
      .empty()
      .obs;
  Rx<HomeModel> homeModel = HomeModel().obs;
  Rx<CategoriesModel> categories = CategoriesModel().obs;

  chooseCategories1() {
    getCategoriesRepo().then((value) {
      categories.value = value;

      if (value.status == true) {
        statusOfCategories.value = RxStatus.success();
      } else {
        statusOfCategories.value = RxStatus.error();
      }
      setState(() {});
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
    });
  }

  Rx<RxStatus> statusOfHome = RxStatus
      .empty()
      .obs;
  final wishListController = Get.put(WishListController());
  final getCommentController = Get.put(GetCommentController());
  final getRecommendationController = Get.put(GetRecommendationController());
  final profileController = Get.put(ProfileController(), permanent: true);

  Rx<RemoveRecommendationModel> modalRemove = RemoveRecommendationModel().obs;
  Rx<HomeModel> home = HomeModel().obs;
  bool like = false;
  RxString type = ''.obs;
  String? id;

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showToast('Could not launch $url');
    }
  }

  SampleItem? selectedMenu;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('value>>>>>>>>>>>>>>${homeController.isDataLoading.value}');
    profileController.getData();
    profileController.check = false;
    all();
    homeController.getPaginate();
    homeController.getData();
    chooseCategories();
    chooseCategories1();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      body: Obx(() {
        if (profileController.refreshData1.value > 0) {}
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
                          Get.toNamed(MyRouters.categoryViewAllScreen);
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 58,
                              width: 58,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: AppTheme.primaryColor), shape: BoxShape.circle),
                              child: ClipOval(
                                child: Image.asset('assets/images/categoryList.png', width: 35,),
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
                      const SizedBox(
                        width: 18,
                      ),
                      GestureDetector(
                        onTap: () {
                          profileController.check = false;
                          all();
                          setState(() {});
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: height * .04),
                          child: Column(
                            children: [
                              Container(
                                height: 58,
                                width: 58,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: AppTheme.primaryColor), shape: BoxShape.circle),
                                child: ClipOval(
                                  child: Image.asset('assets/images/viewAll.png', width: 35,),
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
                        profileController.single.value.data != null ?
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipOval(
                              child: CachedNetworkImage(
                                width: 60,
                                height: 60,
                                fit: BoxFit.fill,
                                imageUrl: profileController.single.value.data!.categoryImage.toString(),
                                errorWidget: (context, url, error) => const Icon(Icons.error,color: Colors.red,),
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
                      //       return statusOfCategories.value.isSuccess &&
                      //               profileController.statusOfProfile.value.isSuccess
                      //           ? ListView.builder(
                      //               itemCount: categories.value.data!.length,
                      //               shrinkWrap: true,
                      //               scrollDirection: Axis.horizontal,
                      //               /*  physics:
                      //                   const AlwaysScrollableScrollPhysics(),*/
                      //               itemBuilder: (context, index) {
                      //                 return Padding(
                      //                   padding: const EdgeInsets.all(8.0),
                      //                   child: Column(
                      //                     children: [
                      //                       GestureDetector(
                      //                         onTap: () {
                      //                           print("id::::"+categories.value.data![index].id.toString(),);
                      //                          profileController.getSingleData(categoryId: categories.value.data![index].id.toString(),
                      //                              userId: profileController.modal.value.data!.user!.id.toString());
                      //
                      //                         },
                      //                         child: ClipOval(
                      //                           child: CachedNetworkImage(
                      //                             width: 70,
                      //                             height: 70,
                      //                             fit: BoxFit.fill,
                      //                             imageUrl: categories.value.data![index].image.toString(),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                       const SizedBox(
                      //                         height: 2,
                      //                       ),
                      //                       Text(
                      //                         categories.value.data![index].name.toString(),
                      //                         style: GoogleFonts.mulish(
                      //                             fontWeight: FontWeight.w300,
                      //                             // letterSpacing: 1,
                      //                             fontSize: 14,
                      //                             color: const Color(0xFF26282E)),
                      //                       )
                      //                     ],
                      //                   ),
                      //                 );
                      //               })
                      //           : statusOfCategories.value.isError
                      //               ? CommonErrorWidget(
                      //                   errorText: "",
                      //                   onTap: () {},
                      //                 )
                      //               : const Center(child: CircularProgressIndicator());
                      //     })),
                    ],
                  ),
                ),
                if ( profileController.check == true)
                  profileController.statusOfSingle.value.isSuccess
                      ? Column(
                    children: [
                      if (profileController.single.value.data!.details!.isEmpty) Padding(
                          padding: EdgeInsets.only(top: Get.height / 5), child: const Text("No Record found")),
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
                        itemCount: profileController.single.value.data!.details!.length,
                        // Total number of items
                        itemBuilder: (BuildContext context, int index) {
                          // You can replace the Container with your image widget
                          return GestureDetector(
                            onTap: () {
                              print(
                                "id:::::::::::::::::::::::::::::${profileController.single.value.data!
                                    .details![index].id}",
                              );
                              Get.toNamed(
                                MyRouters.recommendationSingleScreen,
                                arguments: [
                                  allRecommendation.value.data![index].id.toString(),
                                  allRecommendation.value.data![index].image.toString(),
                                  allRecommendation.value.data![index].title.toString(),
                                  allRecommendation.value.data![index].review.toString(),
                                  allRecommendation.value.data![index].link.toString(),
                                  allRecommendation.value.data![index].wishlist,
                                  allRecommendation.value.data![index].user!.id.toString(),
                                ],
                              );
                              print("object");
                            },
                            child: CachedNetworkImage(
                              errorWidget: (context, url, error) => const Icon(Icons.error,color: Colors.red,),
                              imageUrl: profileController.single.value.data!.details![index].image.toString(),
                              fit: BoxFit.fill,
                            ),
                          );
                        },
                      ),
                    ],
                  )
                      : profileController.statusOfSingle.value.isError
                      ? CommonErrorWidget(
                    errorText: "",
                    onTap: () {
                      print('object');
                    },
                  )
                      : const Center(child: SizedBox()),
                if ( profileController.check == false)
                  statusOfAllRecommendation.value.isSuccess
                      ?
                  // SizedBox(
                  //         height: 600,
                  //         child: GridView.custom(
                  //           gridDelegate: SliverWovenGridDelegate.count(
                  //             crossAxisCount: 2,
                  //             mainAxisSpacing: 8,
                  //             crossAxisSpacing: 8,
                  //             pattern: [
                  //               const WovenGridTile(1),
                  //               const WovenGridTile(
                  //                 5 / 7,
                  //                 crossAxisRatio: 0.9,
                  //                 alignment: AlignmentDirectional.centerEnd,
                  //               ),
                  //             ],
                  //           ),
                  //           childrenDelegate: SliverChildBuilderDelegate(
                  //             (context, index) => GestureDetector(
                  //               onTap: () {
                  //                 log("tgrhtr" + allRecommendation.value.data![index].wishlist.toString());
                  //                 Get.toNamed(
                  //                   MyRouters.recommendationSingleScreen,
                  //                   arguments: [
                  //                     allRecommendation.value.data![index].image.toString(),
                  //                     allRecommendation.value.data![index].title.toString(),
                  //                     allRecommendation.value.data![index].review.toString(),
                  //                     allRecommendation.value.data![index].id.toString(),
                  //                     allRecommendation.value.data![index].link.toString(),
                  //                     allRecommendation.value.data![index].wishlist,
                  //                   ],
                  //                 );
                  //               },
                  //               child: CachedNetworkImage(
                  //                 imageUrl: allRecommendation.value.data![index].image.toString(),
                  //                 placeholder: (context, url) => const SizedBox(),
                  //                 errorWidget: (context, url, error) => const SizedBox(),
                  //                 fit: BoxFit.fill,
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       )
                  GridView.builder(
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
                      return GestureDetector(
                        onTap: () {
                          log("tgrhtr" + allRecommendation.value.data![index].wishlist.toString());
                          print('idddd.............${allRecommendation.value.data![index].id.toString()}');
                          print('idddd.............${allRecommendation.value.data![index].user!.id.toString()}');
                          Get.toNamed(
                            MyRouters.recommendationSingleScreen,
                            arguments: [
                              allRecommendation.value.data![index].id.toString(),
                              allRecommendation.value.data![index].image.toString(),
                              allRecommendation.value.data![index].title.toString(),
                              allRecommendation.value.data![index].review.toString(),
                              allRecommendation.value.data![index].link.toString(),
                              allRecommendation.value.data![index].wishlist,
                              allRecommendation.value.data![index].user!.id.toString(),
                            ],
                          );
                        },
                        child: CachedNetworkImage(
                          imageUrl: allRecommendation.value.data![index].image.toString(),
                          placeholder: (context, url) => const SizedBox(),
                          errorWidget: (_, __, ___) =>
                          const Icon(
                            Icons.error_outline_outlined,
                            color: Colors.red,
                          ),
                          fit: BoxFit.fill,
                        ),
                      );
                    },
                  )
                      : statusOfAllRecommendation.value.isError
                      ? CommonErrorWidget(
                    errorText: "",
                    onTap: () {
                      print('object');
                    },
                  )
                      : const Center(child: CircularProgressIndicator()),
                const SizedBox(height: 40,)
              ],
            ),
          ),
        );
      }),
    );
  }
}
