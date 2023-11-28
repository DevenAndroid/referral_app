import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({Key? key,   required this.onPressed, }) : super(key: key);
  // final bool isLiked;
  final VoidCallback onPressed;

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> with SingleTickerProviderStateMixin {
RxBool like = false.obs ;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: widget.onPressed,
        icon: Icon(
          like.value==true? Icons.favorite : Icons.favorite_border_rounded,
          color: like.value==true? Colors.red : Colors.grey.shade700,
        )
    );
  }
}