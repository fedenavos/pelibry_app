import 'package:flutter/material.dart';
import 'package:watchyapp/constants.dart';

class AlertDialogWidget extends StatelessWidget {
  AlertDialogWidget({this.title, this.subTitle, this.onTapText, this.onTap});

  final String title;
  final String subTitle;
  final String onTapText;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: headlineTextStyle.copyWith(color: primaryColor),
      ),
      content: Text(subTitle),
      elevation: 8,
      actions: <Widget>[
        TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(primaryColor)
          ),
          child: Text(
            onTapText,
            style: TextStyle(color: Colors.white),
          ),
          onPressed: onTap,
        )
      ],
    );
  }
}
