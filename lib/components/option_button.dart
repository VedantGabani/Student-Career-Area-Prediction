import 'package:flutter/material.dart';

class RadioModel {
  bool isSelected;
  final String buttonText;
  RadioModel(this.isSelected, this.buttonText);
}

class OptionButton extends StatelessWidget {
  final RadioModel item;
  OptionButton({this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(bottom: 15.0),
      padding: EdgeInsets.fromLTRB(30, 7, 19, 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(width: 3.0, color: Color(0xFF22486F)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            item.buttonText,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          Icon(
            item.isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 32,
            color: item.isSelected ? Color(0xFF107FEB) : Color(0xFF22486F),
          ),
        ],
      ),
    );
  }
}
