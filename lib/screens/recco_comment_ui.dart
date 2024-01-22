import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/bottomNav_controller.dart';
import '../controller/get_recommendation_controller.dart';
import '../controller/homeController.dart';
import '../repositories/add_comment_repo.dart';
import '../resourses/api_constant.dart';
import '../routers/routers.dart';
import '../widgets/custome_textfiled.dart';


class ReccoCommentScreen extends StatefulWidget {
  const ReccoCommentScreen({super.key});

  @override
  State<ReccoCommentScreen> createState() => _ReccoCommentScreenState();
}

class _ReccoCommentScreenState extends State<ReccoCommentScreen> {

  final getRecommendationController = Get.put(GetRecommendationController());
  final homeController = Get.put(HomeController());
  final bottomController = Get.put(BottomNavBarController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Comments List',
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
                    addCommentRepo(context: context,type: 'recommandation',comment: getRecommendationController.commentController.text.trim(),postId: getRecommendationController.postId.toString()).then((value) {
                      if (value.status == true) {
                        showToast(value.message.toString());
                        getRecommendationController.getComments(getRecommendationController.postId.toString(),context);
                        homeController.getData();
                        getRecommendationController.getRecommendation(idForReco:getRecommendationController.idForReco.toString());
                        // reviewList(post.toString());
                        // Get.back();
                        setState(() {
                          getRecommendationController.commentController.clear();
                        });
                      }
                      else {
                        showToast(value.message.toString());
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
      body: Obx(() {
        return getRecommendationController.statusOfGetComment.value.isSuccess
            ? SingleChildScrollView(
          child: Obx(() {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20).copyWith(
                  bottom: MediaQuery.of(context).viewInsets.bottom
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
                            GestureDetector(
                              onTap: (){
                                Get.back();
                                getRecommendationController.getCommentModel.value.data![index].myAccount == false ?
                                Get.toNamed(MyRouters.allUserProfileScreen, arguments: [
                                  getRecommendationController.getCommentModel.value.data![index].userId!.id.toString()
                                ]):  bottomController.updateIndexValue(2);
                              },
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.cover,
                                  imageUrl: item.profileImage.toString(),
                                  placeholder: (context, url) => const SizedBox(),
                                  errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
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
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            Get.back();
                                            getRecommendationController.getCommentModel.value.data![index].myAccount == false ?
                                            Get.toNamed(MyRouters.allUserProfileScreen, arguments: [
                                              getRecommendationController.getCommentModel.value.data![index].userId!.id.toString()
                                            ]):  bottomController.updateIndexValue(2);
                                          },
                                          child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            item.name.toString(),
                                            style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w600,
                                              // letterSpacing: 1,
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
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
                  ) :  const Center(child: Text('No Data Available')),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            );
          }),
        ) : const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
