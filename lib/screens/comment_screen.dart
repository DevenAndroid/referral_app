import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:referral_app/screens/recommendation_single_page.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controller/bottomNav_controller.dart';
import '../controller/get_comment_controller.dart';
import '../controller/homeController.dart';
import '../repositories/add_comment_repo.dart';
import '../repositories/addblock_remove_repo.dart';
import '../repositories/delete_comment_repo.dart';
import '../resourses/api_constant.dart';
import '../routers/routers.dart';
import '../widgets/custome_textfiled.dart';


class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {

  final getCommentController = Get.put(GetCommentController());
  String post = '';
  final homeController = Get.put(HomeController());
  final formKey6 = GlobalKey<FormState>();
  final bottomController = Get.put(BottomNavBarController());
  SampleItem? selectedMenu;
  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showToast('Could not launch $url');
    }
  }
  @override
  void initState() {
    super.initState();
    getCommentController.getComment(type: getCommentController.type,id: getCommentController.id);
  }
  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 25),
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
              controller: getCommentController.commentController,
              suffixIcon: InkWell(
                  onTap: (){
                      addCommentRepo(context: context,type: 'askrecommandation',comment: getCommentController.commentController.text.trim(),postId: getCommentController.id).then((value) {
                        if (value.status == true) {
                          showToast(value.message.toString());
                          homeController.getData();
                          FocusManager.instance.primaryFocus!.unfocus();
                          getCommentController.getComment(type: getCommentController.type,id: getCommentController.id);
                          // Get.back();
                          setState(() {
                            getCommentController.commentController.clear();
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
        return getCommentController.statusOfGetComment.value.isSuccess
            ? SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Obx(() {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  getCommentController.getCommentModel.value.data != null && getCommentController.getCommentModel.value.data!.isNotEmpty?
                  ListView.builder(
                    physics: const ScrollPhysics(),
                    itemCount: getCommentController.getCommentModel.value.data!.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var item1 = getCommentController.getCommentModel.value.data![index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if(getCommentController.getCommentModel.value.data![index].userId!=null)
                            GestureDetector(
                              onTap: (){
                                Get.back();
                                getCommentController.getCommentModel.value.data![index].myAccount == false ?
                                Get.toNamed(MyRouters.allUserProfileScreen, arguments: [
                                  getCommentController.getCommentModel.value.data![index].userId!.id.toString()
                                ]):  bottomController.updateIndexValue(2);
                              },  child: ClipOval(
                                child: CachedNetworkImage(
                                  width: 42,
                                  height: 42,
                                  fit: BoxFit.cover,
                                  imageUrl: item1.userId!.profileImage.toString(),
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
                                    if(getCommentController.getCommentModel.value.data![index].userId!=null)
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            Get.back();
                                            getCommentController.getCommentModel.value.data![index].myAccount == false ?
                                            Get.toNamed(MyRouters.allUserProfileScreen, arguments: [
                                              getCommentController.getCommentModel.value.data![index].userId!.id.toString()
                                            ]):  bottomController.updateIndexValue(2);
                                          },
                                          child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            item1.userId!.name.toString(),
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
                                    const SizedBox(
                                      height: 16,
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
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        getCommentController.getCommentModel.value.data![index].myAccount == true ||   getCommentController.getCommentModel.value.data![index].myComment == true?
                                        TextButton(
                                            onPressed: (){
                                              deleteCommentRepo(deleteId: item1.id.toString(), context: context).then((value) {
                                                if (value.status == true) {
                                                  showToast(value.message.toString());
                                                  getCommentController.getComment(type: getCommentController.type,id: getCommentController.id);
                                                }
                                                else {
                                                  showToast(value.message.toString());
                                                }
                                              });
                                            },
                                            child: const Text('Delete')) : const SizedBox(),
                                        getCommentController.getCommentModel.value.data![index].myAccount == false ||   getCommentController.getCommentModel.value.data![index].myComment == false?
                                        TextButton(
                                            onPressed: () {
                                              reportRepo(deleteId: item1.id.toString(), context: context).then((value) async {
                                                if (value.status == true) {
                                                  String email = Uri.encodeComponent("stewartsherpa1@gmail.com");
                                                  String subject = Uri.encodeComponent("");
                                                  String body = Uri.encodeComponent("");
                                                  //output: Hello%20Flutter
                                                  Uri mail = Uri.parse(
                                                      "mailto:$email?subject=$subject&body=$body");
                                                  if (await launchUrl(mail)) {

                                                } else {
                                                }
                                                  showToast(value.message.toString());
                                                }
                                                else {
                                                  showToast(value.message.toString());
                                                }
                                              });
                                            },
                                            child: const Text('Report',
                                              style: TextStyle(
                                                color: Colors.red
                                              ),
                                            )): SizedBox(),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ) :  Padding(padding: EdgeInsets.symmetric(vertical: Get.height/5),child: const Center(child: Text('No Data Available',style: TextStyle(color: Colors.black),))),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
            );
          }),
        ) : const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
