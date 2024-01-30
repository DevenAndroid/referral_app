import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:referral_app/widgets/custome_size.dart';
import '../controller/bottomNav_controller.dart';
import '../controller/get_comment_controller.dart';
import '../controller/get_notification_controller.dart';
import '../controller/get_recommendation_controller.dart';
import '../controller/homeController.dart';
import '../routers/routers.dart';
import '../widgets/app_theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {

  final getNotificationController = Get.put(GetNotificationController());
  final homeController = Get.put(HomeController());
  final bottomController = Get.put(BottomNavBarController());
  final getRecommendationController = Get.put(GetRecommendationController());
  final getCommentController = Get.put(GetCommentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              homeController.getData();
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
            "Notifications",
            style: GoogleFonts.mulish(
                color: const Color(0xFF1D1D1D),
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
        ),
        body: Obx(() {
          return  getNotificationController.statusOfGetNotification.value.isSuccess ?
            SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: 10),
            child:
            getNotificationController.getNotificationModel.value.data!.notificationData!=null && getNotificationController.getNotificationModel.value.data!.notificationData!.isNotEmpty
                ? ListView.builder(
                itemCount: getNotificationController.getNotificationModel.value.data!.notificationData!.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = getNotificationController.getNotificationModel.value.data!.notificationData![index];
                  return GestureDetector(
                    onTap: (){
                      switch (item.title) {
                        case 'New Follow':
                          Get.toNamed(MyRouters.allUserProfileScreen, arguments: [item.postId.toString()]);
                          break;
                        case 'Tag':
                          Get.back();
                          bottomController.updateIndexValue(0);
                          break;
                        case 'Recommendation':
                        case 'Like':
                          getRecommendationController.idForReco = item.parentId.toString();
                          getRecommendationController.idForAskReco = item.parentId.toString();
                          getRecommendationController.settingModalBottomSheet(context);
                          break;
                        case 'New Comment':
                          if (item.postType == 'askrecommandation') {
                            getCommentController.id = item.postId.toString();
                            getCommentController.type = 'askrecommandation';
                            getRecommendationController.commentBottomSheet(context);
                          } else if (item.postType == 'recommandation') {
                            getRecommendationController.getComments(item.postId.toString(), context);
                            getRecommendationController.postId = item.postId.toString();
                            getRecommendationController.commentBottomSheetReco(context);
                          }
                          break;
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(11),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              width: 5,
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppTheme.primaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                           CircleAvatar(
                            maxRadius: 20,
                            minRadius: 20,
                            backgroundColor: AppTheme.primaryColor,
                            child: SvgPicture.asset('assets/icons/rec.svg')
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                           Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.time.toString(),
                                  style: const TextStyle(color: AppTheme.primaryColor, fontSize: 12, fontWeight: FontWeight.normal),
                                ),
                                addHeight(5),
                                Text(
                                  item.title.toString(),
                                  style: const TextStyle(color: Color(0xff384953), fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                                addHeight(3),
                                Text(
                                  item.body.toString(),
                                  style: const TextStyle(color: Color(0xff384953), fontSize: 12, fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }):  Padding(
                  padding:  EdgeInsets.symmetric(vertical: Get.height/3),
                  child: const Center(
                    child: Text("No Notification Found",style: TextStyle(
                    color: Colors.black,
                      fontSize: 17
                                ),),
                  ),
                ),
          ) : const Center(child: CircularProgressIndicator());
        })
    );
  }

}