import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class ButtonWrapper extends StatelessWidget {

  final Function onPressed;
  final String text;
  final bool isClicked;
  final bool isLoading;
  final double height;
  final double width;
  final FocusNode focusNode;

  const ButtonWrapper({Key key, this.onPressed, this.text,
    this.isClicked = true, this.isLoading = false, this.height = 50,
    this.width, this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final textStyle = TextStyle(
        fontFamily: 'SF Pro Text',
        fontWeight: FontWeight.w600,
        fontSize: 13,
        color: isClicked ? AppColors.black : AppColors.greyText
    );

    final buttonStyle = ElevatedButton.styleFrom(
        primary: isClicked ? AppColors.white : AppColors.greyBg,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0))
    );

    final progressIndicator = SizedBox(
      width: 15,
      height: 15,
      child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.white)),
    );


    return Container(
      height: height,
      width: width ?? MediaQuery.of(context).size.width * .92,
      child: ElevatedButton(
        focusNode: focusNode,
        onPressed: onPressed,
        style: buttonStyle,
        child: isLoading ? progressIndicator : Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}