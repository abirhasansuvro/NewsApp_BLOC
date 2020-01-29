import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget{
  @override
  Widget build(context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: generateContainer(),
          subtitle: generateContainer(),
        ),
        Divider(height: 8.0),
      ],
    );
  }
  Widget generateContainer(){
    return Container(
      color: Colors.grey[200],
      height: 25.0,
      width: 120.0,
      margin: EdgeInsets.only(
        top: 5.0,
        bottom: 5.0
      ),
    );
  }
}