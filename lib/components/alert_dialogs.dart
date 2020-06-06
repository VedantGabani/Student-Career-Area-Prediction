import 'package:flutter/material.dart';

class AlertDialogs {
  final BuildContext context;
  final String heading;
  final String warning;
  final Function yesFunction;
  final Function noFunction;

  AlertDialogs(
      {@required this.context,
      @required this.yesFunction,
      @required this.noFunction,
      @required this.heading,
      @required this.warning});

  Future<bool> onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: Center(child: Text(heading)),
            backgroundColor: Colors.grey[850],
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Text(
                    warning,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[100],
                    ),
                  ),
                )
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: noFunction,
                child: new Text('No'),
                textColor: Colors.green,
              ),
              new FlatButton(
                onPressed: yesFunction,
                child: new Text('Yes'),
                textColor: Colors.red,
              ),
            ],
          ),
        ) ??
        false;
  }
}
