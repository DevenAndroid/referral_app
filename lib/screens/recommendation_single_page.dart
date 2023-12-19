import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/homeController.dart';
import '../models/categories_model.dart';
import '../models/delete_recomm.dart';
import '../models/home_page_model.dart';

import '../models/model_single_user.dart';
import '../models/model_user_profile.dart';
import '../models/remove_reomeendation.dart';
import '../models/single_user_repo.dart';
import '../repositories/all_recommendation_repo.dart';
import '../repositories/get_user_profile.dart';
import '../repositories/remove_bookmark_repo.dart';
import '../repositories/repo_delete_recomm.dart';
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
  State<RecommendationSingleScreen> createState() =>
      _RecommendationSingleScreenState();
}

class _RecommendationSingleScreenState extends State<RecommendationSingleScreen> {

  final homeController = Get.put(HomeController());

  // RxList<Recommandation> recommandationList = <Recommandation>[].obs;

  Rx<CategoriesModel> categories = CategoriesModel().obs;
  Rx<ModelDeleteRecomm> deleteRecommendation = ModelDeleteRecomm().obs;

  Rx<RxStatus> statusOfDelete = RxStatus
      .empty()
      .obs;
  Rx<RxStatus> statusOfRemove = RxStatus
      .empty()
      .obs;

  Rx<RemoveRecommendationModel> modalRemove = RemoveRecommendationModel().obs;

  String recommend = '';
  Rx<RxStatus> statusOfUser = RxStatus
      .empty()
      .obs;

  Rx<ModelSingleUser> single = ModelSingleUser().obs;

  var id = Get.arguments[0];

  SampleItem? selectedMenu;

  UserProfile() {
    singleUserRepo(recommandation_id: id,).then((value) {
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

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showToast('Could not launch $url') ;
    }}

    @override
    Widget build(BuildContext context) {
      var size = MediaQuery
          .of(context)
          .size;
      var heightt = MediaQuery
          .of(context)
          .size
          .height;

      return Scaffold(
          body: Obx(() {
            return statusOfUser.value.isSuccess ?

            SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 25,
                          ),
                          Row(mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              PopupMenuButton<SampleItem>(
                                initialValue: selectedMenu,
                                // Callback that sets the selected popup menu item.
                                onSelected: (SampleItem item) {
                                  setState(() {
                                    selectedMenu = item;
                                  });
                                },
                                itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<SampleItem>>[
                                  const PopupMenuItem<SampleItem>(
                                    value: SampleItem.itemOne,
                                    child: Text('Edit'),
                                  ),
                                  PopupMenuItem<SampleItem>(
                                    value: SampleItem.itemTwo,
                                    child: InkWell(
                                        onTap: () {
                                          deleteRecommRepo(
                                            context: context,
                                            recommandation_id: single.value.data!.recommandation!.id.toString(),
                                          ).then((value) async {
                                            if (value.status == true) {
                                              deleteRecommendation.value = value;
                                              Get.toNamed(MyRouters.bottomNavbar);
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
                                        child: Text('Delete')),
                                  ),


                                ],
                              ),
                              InkWell(
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
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: const Color(0xFF000000)),
                              ),
                              InkWell(onTap: () {
                                Get.toNamed(MyRouters.userProfileScreen, arguments: [id]);
                              },
                                child: const Image(
                                    height: 40,
                                    width: 40,
                                    image: AssetImage(
                                        'assets/icons/chat.png')

                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  single.value.data!.recommandation!.review.toString(),
                                  style: GoogleFonts.mulish(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: const Color(0xFF162224)),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: InkWell(
                                    onTap: () {
                                      // home.value.data!.discover![index].wishlist.toString();
                                      bookmarkRepo(
                                        context: context,
                                        post_id: id,
                                        type: "recommandation",
                                      ).then((value) async {
                                        if (value.status == true) {
                                          recommend = value.message!;
                                          getAllRepo();
                                          setState(() {

                                          });
                                          print('wishlist-----');
                                          statusOfRemove.value = RxStatus.success();

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
                                    child: single.value.data!.recommandation!.wishlist == true
                                        ? SvgPicture.asset(
                                      AppAssets.bookmark,
                                      height: 20,
                                    )
                                        : SvgPicture.asset(AppAssets.bookmark),
                                  )
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              launchURL(single.value.data!.recommandation!.link.toString(),);
                            },
                            child: Text(
                              single.value.data!.recommandation!.link.toString(),
                              style: GoogleFonts.mulish(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: const Color(0xFF3797EF)),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          Container(
                            height: 400,
                            width: size.width,
                            decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage(single.value.data!.recommandation!.image
                                    .toString(),),)
                            ),
                            // child: Image.network(image,fit: BoxFit.fill,),
                          )
                        ]))) : Center(child: CircularProgressIndicator());
          }));
    }
  }
