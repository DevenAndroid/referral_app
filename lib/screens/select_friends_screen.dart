import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:referral_app/resourses/api_constant.dart';
import 'package:referral_app/widgets/custome_textfiled.dart';

import '../controller/get_friend_controller.dart';
import '../widgets/app_theme.dart';


class SelectFriendsScreen extends StatefulWidget {
  const SelectFriendsScreen({super.key});

  @override
  State<SelectFriendsScreen> createState() => _SelectFriendsScreenState();
}

class _SelectFriendsScreenState extends State<SelectFriendsScreen> {

  final getFriendListController = Get.put(GetFriendListController(),permanent: true);

  @override
  void initState() {
    super.initState();
  //  getFriendListController.getFriendList();
    getFriendListController.selectedFriendIds.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAEEF1),
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
          "Select Friends",
          style: GoogleFonts.mulish(
              color: const Color(0xFF1D1D1D),
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
      ),
      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: CommonButton(title: 'Tag Friends',
            onPressed: (){
              print('Selected Friend IDs: ${getFriendListController.selectedFriendIds.join(',')}');
              print('Selected Friend IDs: ${ getFriendListController.selectedFriend.join(',')}');
              Get.back();
            }),
      ),
      body: Obx(() {
        return getFriendListController.isFriendLoad.value ?
        getFriendListController.getFriendListModel.value.data!= null && getFriendListController.getFriendListModel.value.data!.isNotEmpty ?
        ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          itemCount: getFriendListController.getFriendListModel.value.data!.length,
          itemBuilder: (context, index) {
            var item = getFriendListController.getFriendListModel.value.data![index];
            return
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      getFriendListController.getFriendListModel.value
                          .data![index].checkBoxValue = !
                      getFriendListController.getFriendListModel.value
                          .data![index].checkBoxValue;

                      if (getFriendListController.getFriendListModel.value.data![index].checkBoxValue) {
                        getFriendListController.selectedFriendIds.add(getFriendListController.getFriendListModel.value.data![index].id);
                        getFriendListController.selectedFriend.add(getFriendListController.getFriendListModel.value.data![index].checkBoxValue.toString());
                      }
                      else {getFriendListController.selectedFriendIds.remove(getFriendListController.getFriendListModel.value.data![index].id);
                      getFriendListController.selectedFriend.remove(getFriendListController.getFriendListModel.value.data![index].checkBoxValue.toString());
                      }

                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.fill,
                                  imageUrl: item.profileImage.toString(),
                                  errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red,)),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(item.name.toString(),
                              style: GoogleFonts.mulish(
                                  color: const Color(0xFF26282E),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                              ),
                            )
                          ],
                        ),
                        Transform.scale(
                          scale: 1.0,
                          child: Theme(
                            data: ThemeData(
                              checkboxTheme: CheckboxThemeData(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                            child: Checkbox(
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                value: getFriendListController.getFriendListModel.value.data![index].checkBoxValue,
                                activeColor: AppTheme.primaryColor,
                                side: const BorderSide(color: AppTheme.primaryColor),
                                visualDensity: VisualDensity.standard,
                                onChanged: (newValue) {
                                  setState(() {
                                    getFriendListController.getFriendListModel.value.data![index].checkBoxValue = newValue!;

                                    if (getFriendListController
                                        .getFriendListModel.value.data![index]
                                        .checkBoxValue) {
                                      getFriendListController.selectedFriendIds.add(getFriendListController.getFriendListModel.value.data![index].id);
                                      getFriendListController.selectedFriend.add(getFriendListController.getFriendListModel.value.data![index].checkBoxValue.toString());
                                    } else {
                                      getFriendListController.selectedFriendIds.remove(
                                          getFriendListController.getFriendListModel.value
                                              .data![index].id);
                                      getFriendListController.selectedFriend.remove(getFriendListController.getFriendListModel.value.data![index].checkBoxValue.toString());
                                    }

                                  });
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            );
          },
        ): const Center(child: Text('No Data Found',style: TextStyle(color: Colors.black),),) :const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
