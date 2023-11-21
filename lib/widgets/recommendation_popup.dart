import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:referral_app/widgets/app_theme.dart';

import '../controller/profile_controller.dart';


class RecommendationPopup extends StatefulWidget {
  const RecommendationPopup({Key? key}) : super(key: key);

  @override
  State<RecommendationPopup> createState() => _RecommendationPopupState();
}

class _RecommendationPopupState extends State<RecommendationPopup> {

  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Dialog(

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        // insetPadding: EdgeInsets.symmetric(),
       insetPadding:  EdgeInsets.symmetric(horizontal: 10, vertical: MediaQuery.of(context).size.height*.3),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Text('Who can see your post?',
                style: GoogleFonts.mulish(
                    fontWeight: FontWeight.w600,

                    fontSize: 16,
                    color:  Colors.black
                ),),
SizedBox(height: 20,),
              RadioListTile<String>(
                activeColor: AppTheme.secondaryColor,
                title: Text('Friends Only',
                  style: GoogleFonts.mulish(
                      fontWeight: FontWeight.w600,

                      fontSize: 16,
                      color:  Colors.black
                  ),),
                value: 'Friends Only',
                groupValue:profileController.selectedValue.value,
                onChanged: (value) {
                  setState(() {
                    profileController.selectedValue.value = value!;
                  });
                  Get.back();
                },
              ),
              RadioListTile<String>(
                title: Text('Public',
                  style: GoogleFonts.mulish(
                      fontWeight: FontWeight.w600,

                      fontSize: 16,
                      color:  Colors.black
                  ),),
                value: 'Public',
                activeColor: AppTheme.secondaryColor,
                groupValue: profileController. selectedValue.value,
                onChanged: (value) {
                  setState(() {
                    profileController.selectedValue.value = value!;
                  });
                  Get.back();
                },
              ),
              RadioListTile<String>(
                title: Text('Select Friends',
                  style: GoogleFonts.mulish(
                      fontWeight: FontWeight.w600,

                      fontSize: 16,
                      color:  Colors.black
                  ),),
                value: 'Select Friends',
                activeColor: AppTheme.secondaryColor,
                groupValue: profileController.selectedValue.value,
                onChanged: (value) {
                  setState(() {
                    profileController.selectedValue.value = value!;
                    Get.back();
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
