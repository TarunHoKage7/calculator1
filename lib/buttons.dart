import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final color;
  final String bText;
  final tapped;

  MyButton(this.bText,this.color,this.tapped);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapped,
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            color: color,
            child: Center(
              child: Text(bText),
            ),
          ),
        ),
      ),
    );
  }
}

class PageButtons extends StatelessWidget {
    final color;
    final String pText;
    final clicked;

  PageButtons({Key key, this.color, this.pText, this.clicked});
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: clicked,
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            color: color,
            child: Center(
              child: Text(pText),
            ),
          ),
        ),
      ),
    );
  }
}