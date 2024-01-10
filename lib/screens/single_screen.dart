import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:referral_app/screens/recommendation_single_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/get_recommendation_controller.dart';
import '../controller/profile_controller.dart';
import '../models/delete_recomm.dart';
import '../repositories/add_comment_repo.dart';
import '../repositories/repo_delete_recomm.dart';
import '../resourses/api_constant.dart';
import '../routers/routers.dart';
import '../widgets/app_assets.dart';
import '../widgets/app_theme.dart';
import '../widgets/custome_textfiled.dart';

class SingleScreen extends StatefulWidget {
  const SingleScreen({super.key});

  @override
  State<SingleScreen> createState() => _SingleScreenState();
}

class _SingleScreenState extends State<SingleScreen> {
  var image = Get.arguments[0];
  var title = Get.arguments[1];
  var review = Get.arguments[2];
  var id = Get.arguments[3];
  var link = Get.arguments[4];

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showToast('Could not launch $url');
    }
  }


  final profileController = Get.put(ProfileController());
  final getRecommendationController = Get.put(GetRecommendationController());
  SampleItem? selectedMenu;

  @override
  void initState() {
    super.initState();
    getRecommendationController.getComments(id, 'recommandation');
  }

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
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0).copyWith(
            bottom: MediaQuery
                .of(context)
                .viewInsets
                .bottom + 16.0,
          ),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: const Color(0xFF070707).withOpacity(.06),
                borderRadius: BorderRadius.circular(44)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 12).copyWith(bottom: 0),
              child: CustomTextField(
                obSecure: false.obs,
                hintText: 'Type a message...'.obs,
                controller: getRecommendationController.commentController,
                suffixIcon: InkWell(
                    onTap: () {
                      addCommentRepo(context: context,
                          type: 'recommandation',
                          comment: getRecommendationController.commentController.text.trim(),
                          postId: id.toString()).then((value) {
                        if (value.status == true) {
                          showToast(value.message.toString());
                          FocusManager.instance.primaryFocus!.unfocus();
                          getRecommendationController.getComments(id, context);
                          getRecommendationController.getRecommendation(idForReco: getRecommendationController.idForReco
                              .toString());
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
                        Image.asset('assets/images/comment_send_icon.png', width: 35, height: 35,),
                      ],
                    )),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          title:  Text(
            "Add Your Recommendation",
            style:
            GoogleFonts.mulish(fontWeight: FontWeight.w700,
                fontSize: 16,
                color: const Color(0xFF3797EF)),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  PopupMenuButton<SampleItem>(
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
                          print("object");
                          Get.toNamed(MyRouters.addRecommendationScreen1, arguments: [id.toString()]);
                        },
                        child: InkWell(
                            onTap: () {
                              print("object");
                              Get.toNamed(MyRouters.addRecommendationScreen1, arguments: [id.toString()]);
                            },
                            child: Text('Edit')),
                      ),
                      PopupMenuItem<SampleItem>(
                        value: SampleItem.itemTwo,
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
                                        child: Text("Cancel ")),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          deleteRecommRepo(
                                            context: context,
                                            recommandation_id: id.toString(),
                                          ).then((value) async {
                                            if (value.status == true) {
                                              profileController.deleteRecommendation.value = value;
                                              profileController.getData();
                                              Get.back();
                                              Get.back();
                                              Get.back();
                                              print('wishlist-----');
                                              profileController.statusOfDelete.value = RxStatus.success();

                                              // like=true;
                                              showToast(value.message.toString());
                                            } else {
                                              profileController.statusOfDelete.value = RxStatus.error();
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
                                            child: Text("Cancel ")),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        InkWell(
                                            onTap: () {
                                              deleteRecommRepo(
                                                context: context,
                                                recommandation_id: id.toString(),
                                              ).then((value) async {
                                                if (value.status == true) {
                                                  profileController.deleteRecommendation.value = value;
                                                  profileController.getData();
                                                  Get.back();
                                                  Get.back();
                                                  Get.back();
                                                  print('wishlist-----');
                                                  profileController.statusOfDelete.value = RxStatus.success();

                                                  // like=true;
                                                  showToast(value.message.toString());
                                                } else {
                                                  profileController.statusOfDelete.value = RxStatus.error();
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
                            child: Text('Delete')),
                      ),
                    ],
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: Image.asset(
                            'assets/icons/popup_icon.png', width: 25, height: 25,color: Colors.black,)),
                  ),
                  GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        Get.back();
                        setState(() {});
                      },
                      child: const Icon(
                        Icons.clear,
                        size: 30,
                        color: Colors.black,
                      ))
                ],
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Obx(() {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
                child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  title.toString(),
                                  style: GoogleFonts.mulish(
                                      fontWeight: FontWeight.w600, fontSize: 20, color: Color(0xFF000000)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            review.toString(),
                            style: GoogleFonts.mulish(fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xFF162224)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              launchURL(
                                link.toString(),
                              );
                            },
                            child: Text(
                              link == '' ? '' : "Link",
                              style: GoogleFonts.mulish(fontWeight: FontWeight.w500, fontSize: 15, color: Color(0xFF3797EF)),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Container(
                            height: 250,
                            width: size.width,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(image),
                                )),
                            // child: Image.network(image,fit: BoxFit.fill,),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          getRecommendationController.getCommentModel.value.data != null &&
                              getRecommendationController.getCommentModel.value.data!.isNotEmpty ?
                          ListView.builder(
                            reverse: true,
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
                                        placeholder: (context, url) => const SizedBox(),
                                        errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
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
                          ) : Padding(
                            padding: EdgeInsets.symmetric(vertical: Get.height / 8),
                            child: const Center(child: Text('No Comments Available')),
                          ),
                          // SizedBox(
                          //     //height: heightt * .40,
                          //     //width: size.width,
                          //     child: Image.network(image,fit: BoxFit.cover,height: heightt * .40,width: size.width,))
                        ])));
          }),
        ));
  }
}
