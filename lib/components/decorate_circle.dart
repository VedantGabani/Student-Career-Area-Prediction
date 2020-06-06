import 'package:flutter/material.dart';

class DecorateCircle extends StatelessWidget {
  final double bottoms, lefts, width, rights;
  final int colour;

  DecorateCircle(
      {this.bottoms, this.lefts, this.rights, this.width, this.colour});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottoms,
      left: lefts,
      right: rights,
      child: CircleAvatar(
        radius: width / 2,
        backgroundColor: Color(colour),
      ),
    );
  }
}
