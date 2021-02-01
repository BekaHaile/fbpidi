import 'package:flutter/material.dart';

class FbpidiButton extends StatelessWidget {
  final onPressed;
  final String label;
  final color;
  final padding;
  final textColor;
  final ratio;

  FbpidiButton(
      {this.onPressed,
      this.label,
      this.color,
      this.padding,
      this.textColor,
      this.ratio});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
    );
  }
}
