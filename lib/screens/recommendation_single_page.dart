import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/bottomNav_controller.dart';
import '../controller/get_recommendation_controller.dart';
import '../controller/homeController.dart';
import '../models/categories_model.dart';
import '../models/delete_recomm.dart';
import '../models/home_page_model.dart';

import '../models/model_single_user.dart';
import '../models/model_user_profile.dart';
import '../models/remove_reomeendation.dart';
import '../models/single_user_repo.dart';
import '../repositories/add_comment_repo.dart';
import '../repositories/all_recommendation_repo.dart';
import '../repositories/get_user_profile.dart';
import '../repositories/remove_bookmark_repo.dart';
import '../repositories/repo_add_like.dart';
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
  State<RecommendationSingleScreen> createState() => _RecommendationSingleScreenState();
}

class _RecommendationSingleScreenState extends State<RecommendationSingleScreen> {
  final homeController = Get.put(HomeController());

  // RxList<Recommandation> recommandationList = <Recommandation>[].obs;

  Rx<CategoriesModel> categories = CategoriesModel().obs;
  Rx<ModelDeleteRecomm> deleteRecommendation = ModelDeleteRecomm().obs;

  Rx<RxStatus> statusOfDelete = RxStatus.empty().obs;
  Rx<RxStatus> statusOfRemove = RxStatus.empty().obs;

  Rx<RemoveRecommendationModel> modalRemove = RemoveRecommendationModel().obs;

  String recommend = '';
  Rx<RxStatus> statusOfUser = RxStatus.empty().obs;

  Rx<ModelSingleUser> single = ModelSingleUser().obs;

  var id = Get.arguments[0];
  var userIdUser = Get.arguments[6];

  SampleItem? selectedMenu;

  UserProfile() {
    singleUserRepo(
      recommandation_id: id,
    ).then((value) {
      single.value = value;
      print('idisssss....${id}');
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
    getRecommendationController.getComments(id,'recommandation');
    UserProfile();
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showToast('Could not launch $url');
    }
  }

  final getRecommendationController = Get.put(GetRecommendationController());
  final bottomController = Get.put(BottomNavBarController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var heightt = MediaQuery.of(context).size.height;

    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0).copyWith(
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
          ),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: const Color(0xFF070707).withOpacity(.06),
                borderRadius: BorderRadius.circular(44)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 12).copyWith(bottom: 0),
              child: CustomTextField(
                obSecure: false.obs,
                hintText: 'Type a message...'.obs,
                controller: getRecommendationController.commentController,
                suffixIcon: InkWell(
                    onTap: (){
                      addCommentRepo(context: context,type: 'recommandation',comment: getRecommendationController.commentController.text.trim(),postId: id.toString()).then((value) {
                        if (value.status == true) {
                          showToast(value.message.toString());
                          FocusManager.instance.primaryFocus!.unfocus();
                          getRecommendationController.getComments(id,context);
                          getRecommendationController.getRecommendation(idForReco:getRecommendationController.idForReco.toString());
                          // reviewList(post.toString());
                          // Get.back();
                          setState(() {
                            getRecommendationController.commentController.clear();
                          });
                        }
                        else {
                          showToast(value.message.toString());
                          FocusManager.instance.primaryFocus!.unfocus();
                        }
                      });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/comment_send_icon.png',width: 35,height: 35,),
                      ],
                    )),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.0),
              child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(Icons.clear,size: 30,color: Colors.black,)),
            ),
          ],
        ),
        body: SafeArea(
          child: Obx(() {
                return statusOfUser.value.isSuccess
            ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                       
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  single.value.data!.recommandation!.title.toString(),
                                  style: GoogleFonts.mulish(
                                      fontWeight: FontWeight.w600, fontSize: 20, color: const Color(0xFF000000)),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.back();
                                  single.value.data!.myAccount == false ?
                                  Get.toNamed(MyRouters.allUserProfileScreen, arguments: [userIdUser.toString()]):
                                  bottomController.updateIndexValue(2);
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.fill,
                                    imageUrl: single.value.data!.recommandation!.user!.profileImage.toString(),
                                    placeholder: (context, url) => const SizedBox(
                                      height: 0,
                                    ),
                                      errorWidget: (context, url, error) =>  Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration:
                                          BoxDecoration(border: Border.all(color: Colors.black), shape: BoxShape.circle),
                                          child: SvgPicture.asset('assets/icons/profile.svg'))
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  single.value.data!.recommandation!.review.toString(),
                                  style: GoogleFonts.mulish(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15, color: const Color(0xFF162224)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Obx(() {
                                  return GestureDetector(
                                    onTap: () {
                                      // home.value.data!.discover![index].wishlist.toString();
          
                                      bookmarkRepo(
                                        context: context,
                                        post_id: id.toString(),
                                        type: "recommandation",
                                      ).then((value) async {
                                        modalRemove.value = value;
                                        if (value.status == true) {
                                          print('wishlist-----');
                                          homeController.getData();
                                          statusOfRemove.value = RxStatus.success();
                                          //homeController.getPaginate();
                                          UserProfile();
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
                                            AppAssets.bookmark1,
                                            height: 20,
                                          )
                                        : SvgPicture.asset(AppAssets.bookmark),
                                  );
                                }),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              launchURL(
                                single.value.data!.recommandation!.link.toString(),
                              );
                            },
                            child: Text(
                              'Link',
                              style: GoogleFonts.mulish(
                                  fontWeight: FontWeight.w500, fontSize: 15, color: const Color(0xFF3797EF)),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 250,
                                width: size.width,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                  image: NetworkImage(
                                    single.value.data!.recommandation!.image.toString(),
                                  ),
                                )),
                                // child: Image.network(image,fit: BoxFit.fill,),
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
                                                recommended_id: id.toString(),
                                              ).then((value) async {
                                                if (value.status == true) {
                                                  statusOfRemove.value = RxStatus.success();
                                                  UserProfile();
                                                  showToast(value.message.toString());
                                                } else {
                                                  statusOfRemove.value =
                                                      RxStatus.error();
                                                  // like=false;
                                                  showToast(value.message.toString());
                                                }
                                              });
                                              setState(() {});
                                            },
                                            child: single.value.data!.recommandation!.isLike == true
                                                ? SvgPicture.asset(
                                              AppAssets.heart,
                                              height: 26,
                                            )
                                                : const Image(
                                              image: AssetImage(
                                                  'assets/icons/1814104_favorite_heart_like_love_icon 3.png'),
                                              height: 25,
                                            )),
                                        Text(single.value.data!.recommandation!.likeCount.toString()),
                                      ],
                                    ),
                                  )
                              )

                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          getRecommendationController.getCommentModel.value.data != null && getRecommendationController.getCommentModel.value.data!.isNotEmpty ?
                          ListView.builder(
                            physics: const ScrollPhysics(),
                            itemCount: getRecommendationController.getCommentModel.value.data!.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var item = getRecommendationController.getCommentModel.value.data![index].userId!;
                              var item1 = getRecommendationController.getCommentModel.value.data![index];
                              return Padding(
                                padding: const EdgeInsets.only(left: 8.0, top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipOval(
                                      child: CachedNetworkImage(
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.cover,
                                        imageUrl: item.profileImage.toString(),
                                        errorWidget: (context, url, error) =>  Container(
                                            padding: const EdgeInsets.all(6),
                                            decoration:
                                            BoxDecoration(border: Border.all(color: Colors.black), shape: BoxShape.circle),
                                            child: SvgPicture.asset('assets/icons/profile.svg'))
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
                                              children: [
                                                Text(
                                                  overflow: TextOverflow.ellipsis,
                                                  item.name.toString(),
                                                  style: GoogleFonts.mulish(
                                                    fontWeight: FontWeight.w600,
                                                    // letterSpacing: 1,
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Text(
                                                  item1.date.toString(),
                                                  style: GoogleFonts.mulish(
                                                    fontWeight: FontWeight.w400,
                                                    // letterSpacing: 1,
                                                    fontSize: 10,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: size.height * .01,
                                            ),
                                            Text(
                                              item1.comment.toString(),
                                              style: GoogleFonts.mulish(
                                                fontWeight: FontWeight.w400,
                                                // letterSpacing: 1,
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ) :  Padding(
                            padding:  EdgeInsets.symmetric(vertical: Get.height/8),
                            child: const Center(child: Text('No Comments Available')),
                          ),

                        ])))
            : const Center(child: CircularProgressIndicator());
              }),
        ));
  }
}
