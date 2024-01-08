import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../resourses/api_constant.dart';
import '../../widgets/common_error_widget.dart';
import '../controller/profile_controller.dart';
import '../models/all_recommendation_model.dart';
import '../models/all_user_model.dart';
import '../models/search_model.dart';
import '../repositories/all_recommendation_repo.dart';
import '../repositories/all_useer_repo.dart';
import '../repositories/categories_repo.dart';
import '../repositories/search_repo.dart';
import '../routers/routers.dart';
import '../widgets/app_assets.dart';
import '../widgets/app_theme.dart';
import '../widgets/common_textfield.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Rx<RxStatus> statusOfAllRecommendation = RxStatus.empty().obs;
  Rx<AllRecommendationModel> allRecommendation = AllRecommendationModel().obs;
  Rx<RxStatus> statusOfUser = RxStatus.empty().obs;
  Rx<AllUserModel> userList = AllUserModel().obs;

  listUsers() {
    getUserRepo().then((value) {
      userList.value = value;

      if (value.status == true) {
        statusOfUser.value = RxStatus.success();
      } else {
        statusOfUser.value = RxStatus.error();
      }

      // showToast(value.message.toString());
    });
  }

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

  var currentDrawer = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listUsers();

    all();
  }

  final profileController = Get.put(ProfileController());

  // final controller = Get.put(registerController());
  final TextEditingController search1Controller = TextEditingController();
  final TextEditingController search2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: const Color(0xFFFFFFFF),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
                // color: AppTheme.primaryColor,
              ),
            ),
            centerTitle: true,
            title: Text(
              "Search",
              style: GoogleFonts.poppins(color: const Color(0xFF1D1D1D), fontSize: 20, fontWeight: FontWeight.w500),
            ),
            bottom: TabBar(
              labelColor:  const Color(0xFF3797EF),
              unselectedLabelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: AppTheme.primaryColor,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 15),
              // automaticIndicatorColorAdjustment: true,
              // onTap: (value) {
              //   currentDrawer = value;
              //   setState(() {});
              // },
              tabs: [
                Tab(
                  child: Text("Peoples",
                      style:  GoogleFonts.mulish(
                              fontWeight: FontWeight.w700, letterSpacing: 1, fontSize: 15)),
                ),
                Tab(
                  child: Text("Recommendation",
                      style: GoogleFonts.mulish(
                              fontWeight: FontWeight.w700, letterSpacing: 1, fontSize: 15)),
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextfield(
                      controller: search2Controller,
                      obSecure: false,
                      hintText: "Search for a Peoples",
                      prefix: Padding(padding: const EdgeInsets.all(13.0), child: Icon(Icons.search)),
                      onTap: () {
                        setState(() {});
                      },
                      onChanged: (gt) {
                        setState(() {});
                      },
                    ),
                    SingleChildScrollView(
                      child: Obx(() {
                        List<Data> searchData1 = [];
                        if (statusOfAllRecommendation.value.isSuccess && userList.value.data != null) {
                          String search = search2Controller.text.trim().toLowerCase();
                          // String search1 = search2Controller.text.trim().toLowerCase();
                          if (search.isNotEmpty) {
                            searchData1 = userList.value.data!.where((element) => element.name.toString().toLowerCase().contains(search)).toList();
                          } else {
                            searchData1 = userList.value.data!;
                          }
                        }
                        return statusOfUser.value.isSuccess
                            ? Column(
                                children: [
                                  if (searchData1.isEmpty)
                                    Center(
                                      child: Text(
                                        "No User Found",
                                        style: GoogleFonts.mulish(
                                            fontWeight: FontWeight.w400,
                                            // letterSpacing: 1,
                                            fontSize: 17,
                                            color: Colors.black),
                                      ),
                                    ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: searchData1.length,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        final item = searchData1[index];
                                        return Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Get.toNamed(MyRouters.allUserProfileScreen, arguments: [item.id.toString()]);
                                              },
                                              child: Container(
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
                                                child: Row(
                                                  children: [
                                                    ClipOval(
                                                      child: CachedNetworkImage(
                                                        width: 50,
                                                        height: 50,
                                                        fit: BoxFit.cover,
                                                        imageUrl: item.profileImage.toString(),
                                                        errorWidget: (_, __, ___) =>  Image.asset(
                                    AppAssets.man,
                                    color: Colors.grey.shade200,
                                  ),
                                  placeholder: (_, __) =>
                                      Image.asset(
                                        AppAssets.man,
                                        color: Colors.grey.shade200,
                                      ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    Text(
                                                      item.name.toString(),
                                                      style: GoogleFonts.mulish(
                                                          fontWeight: FontWeight.w400,
                                                          // letterSpacing: 1,
                                                          fontSize: 17,
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            )
                                          ],
                                        );
                                      }),
                                ],
                              )
                            : statusOfUser.value.isError
                                ? CommonErrorWidget(
                                    errorText: "",
                                    onTap: () {},
                                  )
                                : const Center(child: Center(child: CircularProgressIndicator()));
                      }),
                    )
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonTextfield(
                            controller: search1Controller,
                            obSecure: false,
                            hintText: "Search for a Recommendation",
                            prefix: const Padding(padding: EdgeInsets.all(13.0), child: Icon(Icons.search)),
                            onTap: () {
                              setState(() {});
                            },
                            onChanged: (gt) {
                              setState(() {});
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Obx(() {
                            List<AllRecommendation> searchData = [];
                            if (statusOfAllRecommendation.value.isSuccess && allRecommendation.value.data != null) {
                              String search = search1Controller.text.trim().toLowerCase();
                              if (search.isNotEmpty) {
                                searchData = allRecommendation.value.data!.where((element) => element.title.toString().toLowerCase().contains(search)).toList();
                                searchData = allRecommendation.value.data!.where((element) => element.review.toString().toLowerCase().contains(search)).toList();
                                searchData = allRecommendation.value.data!.where((element) => element.date.toString().toLowerCase().contains(search)).toList();
                                searchData = allRecommendation.value.data!.where((element) => element.link.toString().toLowerCase().contains(search)).toList();
                              } else {
                                searchData = allRecommendation.value.data!;
                              }
                            }
                            return statusOfAllRecommendation.value.isSuccess
                                ? Column(
                                    children: [
                                      if (searchData.isEmpty) Text("No data Found"),
                                      SingleChildScrollView(
                                        child: GridView.builder(
                                          physics: BouncingScrollPhysics(),
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            // Number of columns
                                            crossAxisSpacing: 10.0,
                                            // Spacing between columns
                                            mainAxisSpacing: 10.0, // Spacing between rows
                                          ),
                                          itemCount: searchData.length,
                                          // Total number of items
                                          itemBuilder: (BuildContext context, int index) {
                                            final item = searchData[index];
                                            // You can replace the Container with your image widget
                                            return GestureDetector(
                                              onTap: () {
                                                print(
                                                  "id:::::::::::::::::::::::::::::" +
                                                      item.id.toString(),
                                                );
                                                Get.toNamed(
                                                  MyRouters.recommendationSingleScreen,
                                                  arguments: [
                                                    item.id.toString(),
                                                    item.image.toString(),
                                                    item.title.toString(),
                                                    item.review.toString(),
                                                    item.link.toString(),
                                                  ],
                                                );
                                              },
                                              child: CachedNetworkImage(
                                                imageUrl: item.image.toString(),
                                                fit: BoxFit.fill,
                                                errorWidget: (context, url, error) => const Icon(Icons.error,color: Colors.red,),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                : statusOfAllRecommendation.value.isError
                                    ? CommonErrorWidget(
                                        errorText: "",
                                        onTap: () {},
                                      )
                                    : const Center(child: CircularProgressIndicator());
                          }),
    SizedBox(height: 50,),
                        ]))),
          ]),
        ));
  }
}
