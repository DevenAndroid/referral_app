import 'package:flutter/material.dart';
import 'package:referral_app/widgets/custome_textfiled.dart';

import '../resourses/size.dart';

class CommonErrorWidget extends StatelessWidget {
  final String errorText;
  final VoidCallback onTap;

  const CommonErrorWidget(
      {Key? key, required this.errorText, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorText,
          ),
          const SizedBox(
            height: 20,
          ),
          CommonButton(
            title: "Refresh",
            onPressed: onTap,
          )
        ],
      ),
    );
  }
}
