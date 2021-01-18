import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final String texto;
  final Color bgColor;
  final Color textColor;
  final VoidCallback onPressed;

  ButtonCustom(
      {@required this.texto,
      this.bgColor = Colors.white,
      this.onPressed,
      this.textColor});
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(
        this.texto,
        style: TextStyle(
          color: this.textColor,
        ),
      ),
      color: this.bgColor,
      onPressed: this.onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    );
  }
}
