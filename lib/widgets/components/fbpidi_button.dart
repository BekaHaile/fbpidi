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
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: width * ratio,
        height: 60.0,
        child: SizedBox.expand(
          child: ElevatedButton(
            key: Key('raised'),
            style: ElevatedButton.styleFrom(
              onPrimary: Theme.of(context).buttonColor.withOpacity(0.3),
              primary: Theme.of(context).buttonColor,
              padding: padding,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(13)),
              ),
            ),
            onPressed: onPressed,
            child: Text(
              label,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
