import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/homeController.dart';
import '../models/categories_model.dart';
import '../models/home_page_model.dart';

import '../models/model_single_user.dart';
import '../models/model_user_profile.dart';
import '../models/remove_reomeendation.dart';
import '../models/single_user_repo.dart';
import '../repositories/all_recommendation_repo.dart';
import '../repositories/get_user_profile.dart';
import '../repositories/remove_bookmark_repo.dart';
import '../repositories/single_produc_repo.dart';
import '../resourses/api_constant.dart';
import '../routers/routers.dart';
import '../widgets/app_assets.dart';
import '../widgets/app_theme.dart';
import '../widgets/custome_textfiled.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class RecommendationSingleScreen extends StatefulWidget {
  const RecommendationSingleScreen({super.key});

  @override
  State<RecommendationSingleScreen> createState() => _RecommendationSingleScreenState();
}

class _RecommendationSingleScreenState extends State<RecommendationSingleScreen> {
  final homeController = Get.put(HomeController());

  // RxList<Recommandation> recommandationList = <Recommandation>[].obs;

  Rx<CategoriesModel> categories = CategoriesModel().obs;

  Rx<RxStatus> statusOfRemove = RxStatus.empty().obs;

  Rx<RemoveRecommendationModel> modalRemove = RemoveRecommendationModel().obs;

  String recommend = '';
  Rx<RxStatus> statusOfUser = RxStatus.empty().obs;

  Rx<ModelSingleUser> single = ModelSingleUser().obs;

  var id = Get.arguments[0];

  SampleItem? selectedMenu;

  UserProfile() {
    singleUserRepo(
      recommandation_id: id,
    ).then((value) {
      single.value = value;
      print(id);
      if (value.status == true) {
        statusOfUser.value = RxStatus.success();
      } else {
        statusOfUser.value = RxStatus.error();
      }

      // showToast(value.message.toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserProfile();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var heightt = MediaQuery.of(context).size.height;

    return Scaffold(body: Obx(() {
      return statusOfUser.value.isSuccess
          ? SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            PopupMenuButton<SampleItem>(
                              initialValue: selectedMenu,
                              // Callback that sets the selected popup menu item.
                              onSelected: (SampleItem item) {
                                setState(() {
                                  selectedMenu = item;
                                });
                              },
                              itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
                                const PopupMenuItem<SampleItem>(
                                  value: SampleItem.itemOne,
                                  child: Text('Edit'),
                                ),
                                const PopupMenuItem<SampleItem>(
                                  value: SampleItem.itemTwo,
                                  child: Text('Delete'),
                                ),
                              ],
                            ),
                            GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: const Icon(Icons.clear))
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              single.value.data!.recommandation!.title.toString(),
                              style: GoogleFonts.mulish(
                                  fontWeight: FontWeight.w600, fontSize: 20, color: const Color(0xFF000000)),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(MyRouters.userProfileScreen, arguments: [id]);
                              },
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.fill,
                                  imageUrl: single.value.data!.recommandation!.user!.profileImage.toString(),
                                ),
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
                            Text(
                              single.value.data!.recommandation!.review.toString(),
                              style: GoogleFonts.mulish(
                                  fontWeight: FontWeight.w400, fontSize: 12, color: const Color(0xFF162224)),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    bookmarkRepo(
                                      context: context,
                                      post_id: id,
                                      type: "recommandation",
                                    ).then((value) async {
                                      if (value.status == true) {
                                        recommend = value.message!;
                                        setState(() {});
                                        print('wishlist-----');
                                        statusOfRemove.value = RxStatus.success();
                                        showToast(value.message.toString());
                                      } else {
                                        statusOfRemove.value = RxStatus.error();
                                        showToast(value.message.toString());
                                      }
                                    });
                                    setState(() {
                                      if (single.value.data!.recommandation!.wishlist == false) {
                                        single.value.data!.recommandation!.wishlist = true;
                                      } else {
                                        single.value.data!.recommandation!.wishlist = false;
                                      }
                                    });
                                  },
                                  child: single.value.data!.recommandation!.wishlist == true
                                      ? SvgPicture.asset(
                                          AppAssets.bookmark1,
                                          height: 20,
                                        )

                                      : SvgPicture.asset(AppAssets.bookmark),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          single.value.data!.recommandation!.link.toString(),
                          style:
                              GoogleFonts.mulish(fontWeight: FontWeight.w500, fontSize: 12, color: const Color(0xFF3797EF)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 400,
                          width: size.width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: NetworkImage(
                              single.value.data!.recommandation!.image.toString(),
                            ),
                          )),
                          // child: Image.network(image,fit: BoxFit.fill,),
                        )
                      ])))
          : const Center(child: CircularProgressIndicator());
    }));
  }
}
