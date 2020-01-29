import 'package:flutter/material.dart';

import 'dart:async';

import '../models/item_model.dart';
import './loading_container.dart';

class Comment extends StatelessWidget{
  final int itemId;
  final Map<int,Future<ItemModel>> itemMap;
  final int depth;
  Comment({this.itemId,this.itemMap,this.depth});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context,AsyncSnapshot<ItemModel> snapshot){
        final item=snapshot.data;
        if(!snapshot.hasData){
          return LoadingContainer();
        }
        final comment_list=<Widget>[
          ListTile(
            title: cleanText(item.text),
            subtitle:item.by==''?Text('Deleted') : Text(item.by),
            contentPadding: EdgeInsets.only(
              right: 16.0,
              left: 16.0+depth*16.0
            ),
          ),
          Divider(),
        ];
        item.kids.forEach((kidId){
          comment_list.add(
            Comment(
              itemId: kidId,
              itemMap: this.itemMap,
              depth: depth+1,
            )
          );
        });
        return Column(
          children: comment_list,
        );
      },
    );
  }
  Widget cleanText(String str){
    String nt=str.replaceAll('<p>', '\n\n')
    .replaceAll('</p>', '')
    .replaceAll('&#x27;', "'");
    return Text(nt);
  }
}