import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  VoidCallback onPressed;
  Color borderColor;
  Color textColor;
  String text;
  MyButton(this.onPressed, this.borderColor, this.textColor, this.text,{Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        )),
        side: MaterialStateProperty.all(
            BorderSide(color: borderColor, width: 3.0)),
        backgroundColor: MaterialStateProperty.all(Colors.white),
        fixedSize: MaterialStateProperty.all(Size(200.0, 200.0)),
        elevation: MaterialStateProperty.all(4.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 25.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
