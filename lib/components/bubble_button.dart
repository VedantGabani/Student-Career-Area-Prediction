import 'package:career_mentor/components/decorate_circle.dart';
import 'package:flutter/material.dart';

class BubbleButton extends StatelessWidget {
  final double buttonWidth;
  final String title;
  final Widget buttonImage;
  final double textPadding;
  final double textSize;
  final Function buttonFunction;
  final double buttonHeight;

  BubbleButton({
    this.buttonHeight,
    this.buttonWidth,
    this.title,
    this.buttonImage,
    this.textPadding,
    this.textSize,
    this.buttonFunction,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      //splashColor: Colors.transparent,
      //highlightColor: Colors.transparent,
      onPressed: buttonFunction,
      constraints: BoxConstraints(
        maxWidth: buttonWidth,
      ),
      child: Container(
        height: (buttonHeight == null) ? 60.0 : buttonHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: Color(0xFF127FEB),
        ),
        child: Stack(
          children: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: buttonImage,
                    height: 50.0,
                    padding: EdgeInsets.all(3.0),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              (textPadding == null) ? 0.0 : textPadding),
                      child: Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: (textSize == null) ? 25.0 : textSize,
                          fontFamily: 'FredokaOne',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            DecorateCircle(
                bottoms: 30.0, lefts: 28.0, width: 50.0, colour: 0x25FFFFFF),
            DecorateCircle(
                bottoms: 8.0, lefts: 30.0, width: 18.0, colour: 0x25FFFFFF),
            DecorateCircle(
                bottoms: -30.0, rights: 18.0, width: 70.0, colour: 0x25FFFFFF),
          ],
        ),
      ),
    );
  }
}
