import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:referral_app/screens/recommendation_single_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/bottomNav_controller.dart';
import '../controller/get_recommendation_controller.dart';
import '../controller/homeController.dart';
import '../controller/profile_controller.dart';
import '../repositories/repo_add_like.dart';
import '../repositories/repo_delete_recomm.dart';
import '../repositories/repo_review_list.dart';
import '../resourses/api_constant.dart';
import '../routers/routers.dart';
import '../widgets/app_assets.dart';
import '../widgets/custome_textfiled.dart';


class GetRecommendationScreen extends StatefulWidget {
  const GetRecommendationScreen({super.key});

  @override
  State<GetRecommendationScreen> createState() => _GetRecommendationScreenState();
}

class _GetRecommendationScreenState extends State<GetRecommendationScreen> {

  final getRecommendationController = Get.put(GetRecommendationController());
  final profileController = Get.put(ProfileController(), permanent: true);
  final homeController = Get.put(HomeController());

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showToast('Could not launch $url');
    }
  }

  reviewList(id) {
    // modelReviewList.value.data!.clear();
    print('id isss...${id.toString()}');
    getReviewListRepo(context: context, id: getRecommendationController.idForReco).then((value) {
      getRecommendationController.modelReviewList.value = value;
      print('api iss CALL');
      if (value.status == true) {
        getRecommendationController.statusOfGetReco.value = RxStatus.success();
      } else {
        getRecommendationController.statusOfGetReco.value = RxStatus.error();
      }
      setState(() {});
    });
  }

  SampleItem? selectedMenu;

  @override
  void initState() {
    super.initState();
    print('idddddd....${getRecommendationController.idForReco.toString()}');
    getRecommendationController.getRecommendation(idForReco: getRecommendationController.idForReco);
  }
  final bottomController = Get.put(BottomNavBarController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Recommendation List',
          style: GoogleFonts.mulish(
            fontWeight: FontWeight.w700,
            // letterSpacing: 1,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0).copyWith(left: 0),
            child: GestureDetector(
                onTap: () {
                  Get.back();
                  setState(() {});
                },
                child: const Icon(Icons.close,color: Colors.black,)),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(0.0).copyWith(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 12).copyWith(bottom: 0),
          child:  GestureDetector(
            onTap: () {
              Get.back();
              Get.toNamed(MyRouters.recommendationScreen,
                  arguments: [getRecommendationController.idForReco.toString()]);
            },
            child: const CommonButton(title: "Send Recommendation"),
          ),
        ),
      ),
      body: Obx(() {
        return getRecommendationController.statusOfGetReco.value.isSuccess
            ?  SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: [
                    getRecommendationController.modelReviewList.value.data != null &&
                        getRecommendationController.modelReviewList.value.data!.isNotEmpty ?
                    ListView.builder(
                      physics: const ScrollPhysics(),
                      itemCount: getRecommendationController.modelReviewList.value.data!.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: (){

                                  Get.back();
                                  getRecommendationController.modelReviewList.value.data![index].myAccount == false ?
                                  Get.toNamed(MyRouters.allUserProfileScreen, arguments: [
                                    getRecommendationController.modelReviewList.value.data![index].user!.id.toString()
                                  ]):
                                  bottomController.updateIndexValue(2);
                                },
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    width: 42,
                                    height: 42,
                                    fit: BoxFit.cover,
                                    imageUrl: getRecommendationController.modelReviewList.value.data![index].user!
                                        .profileImage.toString(),
                                    placeholder: (context, url) => const SizedBox(),
                                    errorWidget: (context, url, error) =>  Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration:
                                        BoxDecoration(border: Border.all(color: Colors.black), shape: BoxShape.circle),
                                        child: SvgPicture.asset('assets/icons/profile.svg'))
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      color: Colors.grey.withOpacity(0.2)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: (){
                                                  Get.back();
                                                  getRecommendationController.modelReviewList.value.data![index].myAccount == false ?
                                                  Get.toNamed(MyRouters.allUserProfileScreen, arguments: [
                                                    getRecommendationController.modelReviewList.value.data![index].user!.id.toString()
                                                  ]):
                                                  bottomController.updateIndexValue(2);
                                                },
                                                child: Text(
                                                  overflow: TextOverflow.ellipsis,
                                                  getRecommendationController.modelReviewList.value.data![index].user!.name
                                                      .toString(),
                                                  style: GoogleFonts.mulish(
                                                    fontWeight: FontWeight.w600,
                                                    // letterSpacing: 1,
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 3.0),
                                                child: Text(
                                                  getRecommendationController.modelReviewList.value.data![index].date
                                                      .toString(),
                                                  textAlign: TextAlign.start,
                                                  style: GoogleFonts.mulish(
                                                    fontWeight: FontWeight.w400,
                                                    // letterSpacing: 1,
                                                    fontSize: 11,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          getRecommendationController.modelReviewList.value.data![index].isEditable ==
                                              true ?
                                          PopupMenuButton<SampleItem>(
                                            padding: EdgeInsets.zero,
                                            initialValue: selectedMenu,
                                            onSelected: (SampleItem item) {
                                              setState(() {
                                                selectedMenu = item;
                                              });
                                            },
                                            itemBuilder: (BuildContext context) =>
                                            <PopupMenuEntry<SampleItem>>[
                                              PopupMenuItem<SampleItem>(
                                                value: SampleItem.itemOne,
                                                onTap: () {
                                                  Get.back();
                                                  print("object${getRecommendationController.modelReviewList.value
                                                      .data![index].id.toString()}");
                                                  Get.toNamed(MyRouters.addRecommendationScreen1, arguments: [
                                                    getRecommendationController.modelReviewList.value.data![index].id
                                                        .toString(),
                                                    getRecommendationController.idForAskReco.toString()
                                                  ]);
                                                },
                                                child: const Text('Edit'),
                                              ),
                                              PopupMenuItem<SampleItem>(
                                                value: SampleItem.itemTwo,
                                                onTap: () {
                                                  showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext context) =>
                                                        AlertDialog(
                                                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                                                          title: const Text(
                                                            'Are you sure to delete recommendation',
                                                            style: TextStyle(fontSize: 16),
                                                          ),
                                                          actions: <Widget>[
                                                            InkWell(
                                                                onTap: () {
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
                                                                    recommandation_id: getRecommendationController
                                                                        .modelReviewList.value.data![index].id
                                                                        .toString(),
                                                                  ).then((value) async {
                                                                    if (value.status == true) {
                                                                      profileController.deleteRecommendation.value =
                                                                          value;
                                                                      profileController.getData();
                                                                      homeController.getData();
                                                                      Get.back();
                                                                      Get.back();
                                                                      Get.back();
                                                                      print('wishlist-----');
                                                                      profileController.statusOfDelete.value =
                                                                          RxStatus.success();

                                                                      // like=true;
                                                                      showToast(value.message.toString());
                                                                    } else {
                                                                      profileController.statusOfDelete.value =
                                                                          RxStatus.error();
                                                                      // like=false;
                                                                      showToast(value.message.toString());
                                                                    }
                                                                  });
                                                                },
                                                                child: const Padding(
                                                                  padding: EdgeInsets.all(15.0),
                                                                  child: Text('OK'),
                                                                )),
                                                          ],
                                                        ),
                                                  );
                                                },
                                                child: InkWell(
                                                    onTap: () {
                                                      showDialog<String>(
                                                        context: context,
                                                        builder: (BuildContext context) =>
                                                            AlertDialog(
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
                                                                        recommandation_id: homeController.homeModel.value
                                                                            .data!.recommandation![index].id.toString(),
                                                                      ).then((value) async {
                                                                        if (value.status == true) {
                                                                          profileController.deleteRecommendation.value =
                                                                              value;
                                                                          profileController.getData();
                                                                          Get.back();
                                                                          Get.back();
                                                                          Get.back();
                                                                          print('wishlist-----');
                                                                          profileController.statusOfDelete.value =
                                                                              RxStatus.success();

                                                                          // like=true;
                                                                          showToast(value.message.toString());
                                                                        } else {
                                                                          profileController.statusOfDelete.value =
                                                                              RxStatus.error();
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
                                            child: Container(
                                                alignment: Alignment.centerRight,
                                                child: Image.asset(
                                                    'assets/icons/popup_icon.png', width: 25, height: 25)),
                                          ) : const SizedBox(),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  getRecommendationController.modelReviewList.value.data![index].title
                                                      .toString(),
                                                  style: GoogleFonts.mulish(
                                                    fontWeight: FontWeight.w700,
                                                    // letterSpacing: 1,
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                          Text(
                                            getRecommendationController.modelReviewList.value.data![index].review
                                                .toString(),
                                            style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w400,
                                              // letterSpacing: 1,
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(
                                        height: 13,
                                      ),
                                      getRecommendationController.modelReviewList.value.data![index].link == ""
                                          ? const SizedBox()
                                          : GestureDetector(
                                        onTap: () {
                                          launchURL(
                                            getRecommendationController.modelReviewList.value.data![index].link
                                                .toString(),
                                          );
                                        },
                                        child: Text(
                                          'Link',
                                          style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                              color: const Color(0xFF3797EF)),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      getRecommendationController.modelReviewList.value.data![index].image == ""
                                          ? const SizedBox()
                                          : Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                                width: size.width,
                                                height: 200,
                                                fit: BoxFit.contain,
                                                imageUrl: getRecommendationController.modelReviewList.value.data![index]
                                                    .image.toString(),
                                                placeholder: (context, url) =>
                                                const SizedBox(
                                                  height: 0,
                                                ),
                                                errorWidget: (context, url, error) =>
                                                const Icon(Icons.error, color: Colors.red,)
                                            ),
                                          ),
                                          Positioned(
                                              top: 4,
                                              right: 4,
                                              child: Container(
                                                padding: const EdgeInsets.all(10),
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle
                                                ),
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                        onTap: () {
                                                          addRemoveLikeRepo(
                                                            context: context,
                                                            recommended_id: getRecommendationController.modelReviewList
                                                                .value.data![index].id
                                                                .toString(),
                                                          ).then((value) async {
                                                            // userProfile.value = value;
                                                            if (value.status == true) {
                                                              // print('wishlist-----');
                                                              getRecommendationController.statusOfRemove.value =
                                                                  RxStatus.success();
                                                              reviewList(
                                                                  getRecommendationController.idForReco.toString());
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
                                                        child: getRecommendationController.modelReviewList.value
                                                            .data![index].isLike == true
                                                            ? SvgPicture.asset(
                                                          AppAssets.heart,
                                                          height: 26,
                                                        )
                                                            : const Image(
                                                          image: AssetImage(
                                                              'assets/icons/1814104_favorite_heart_like_love_icon 3.png'),
                                                          height: 25,
                                                        )),
                                                    Text(getRecommendationController.modelReviewList.value.data![index]
                                                        .likeCount.toString()),
                                                  ],
                                                ),
                                              )
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 18,
                                      ),
                                      getRecommendationController.modelReviewList.value.data![index].image == "" ?
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                getRecommendationController.getComments(getRecommendationController.modelReviewList.value.data![index].id.toString(),context);
                                                getRecommendationController.postId =
                                                    getRecommendationController.modelReviewList.value.data![index].id.toString();
                                                print('Id Is....${getRecommendationController.modelReviewList.value
                                                    .data![index].id.toString()}');
                                                getRecommendationController.commentBottomSheetReco(context);
                                                setState(() {});
                                              },
                                              child: Text(
                                                "Comments:   ${ getRecommendationController.modelReviewList.value
                                                    .data![index].commentCount.toString()}",
                                                style: GoogleFonts.mulish(
                                                    fontWeight: FontWeight.w600,
                                                    // letterSpacing: 1,
                                                    fontSize: 16,
                                                    color: const Color(0xFF3797EF)),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      addRemoveLikeRepo(
                                                        context: context,
                                                        recommended_id: getRecommendationController.modelReviewList.value
                                                            .data![index].id
                                                            .toString(),
                                                      ).then((value) async {
                                                        // userProfile.value = value;
                                                        if (value.status == true) {
                                                          // print('wishlist-----');
                                                          getRecommendationController.statusOfRemove.value =
                                                              RxStatus.success();
                                                          reviewList(getRecommendationController.idForReco.toString());
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
                                                    child: getRecommendationController.modelReviewList.value.data![index]
                                                        .isLike == true
                                                        ? SvgPicture.asset(
                                                      AppAssets.heart,
                                                      height: 26,
                                                    )
                                                        : const Image(
                                                      image: AssetImage(
                                                          'assets/icons/1814104_favorite_heart_like_love_icon 3.png'),
                                                      height: 25,
                                                    )),
                                                Text(getRecommendationController.modelReviewList.value.data![index]
                                                    .likeCount.toString()),
                                              ],
                                            ),
                                          ]
                                      ) :
                                      InkWell(
                                        onTap: () {
                                          getRecommendationController.getComments(getRecommendationController.modelReviewList.value.data![index].id.toString(),context);
                                          getRecommendationController.postId =
                                              getRecommendationController.modelReviewList.value.data![index].id.toString();
                                          print('Id Is....${getRecommendationController.modelReviewList.value
                                              .data![index].id.toString()}');
                                          getRecommendationController.commentBottomSheetReco(context);
                                          setState(() {});
                                        },
                                        child: Text(
                                          "Comments:   ${ getRecommendationController.modelReviewList.value.data![index]
                                              .commentCount.toString()}",
                                          style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w600,
                                              // letterSpacing: 1,
                                              fontSize: 16,
                                              color: const Color(0xFF3797EF)),
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
                    ) : const Center(child: Text('No Data Available')),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ): const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
