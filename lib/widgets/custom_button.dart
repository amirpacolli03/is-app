import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:is_app/utils/style.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color buttonColor;
  final Color textColor;

  CustomButton({
    this.onPressed,
    this.text,
    this.buttonColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: double.infinity,
      height: ScreenUtil().setHeight(150),
      child: RaisedButton(
        onPressed: onPressed,
        color: buttonColor ?? AppStyle.mainAppColor,
        disabledColor: AppStyle.mainAppColor.withOpacity(0.88),
        child: Text(
          text ?? "N/A",
          style: TextStyle(
              color: textColor ?? Colors.white,
              fontSize: ScreenUtil().setSp(55)),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
    );
  }
}
