import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final String texto;
  final Color bgColor;
  final Color textColor;
  final VoidCallback onPressed;

  ButtonCustom({
    @required this.texto,
    this.bgColor,
    this.onPressed,
    this.textColor = Colors.white,
  });
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.symmetric(vertical: 14),
      child: Text(
        this.texto,
        style: TextStyle(
          fontSize: 16,
          color: this.textColor,
        ),
      ),
      color: this.bgColor,
      splashColor: Colors.white24,
      onPressed: this.onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    );
  }
}
