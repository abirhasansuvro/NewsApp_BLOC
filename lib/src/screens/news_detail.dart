import 'package:flutter/material.dart';

import 'dart:async';

import '../blocs/comments_provider.dart';
import '../models/item_model.dart';
import '../widgets/comment.dart';

class NewsDetail extends StatelessWidget{
  final int itemId;

  NewsDetail({this.itemId});
  @override
  Widget build(BuildContext context) {
    final bloc=CommentsProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: buildBody(bloc),
    );
  }

  Widget buildBody(CommentsBloc bloc){
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (context,AsyncSnapshot<Map<int,Future<ItemModel>>> snapshot){
        if(!snapshot.hasData){
          return Text('Still not fetched');
        }
        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (context,AsyncSnapshot<ItemModel> itemSnapshot){
            if(!itemSnapshot.hasData){
              return Text('No Core Item');
            }
            return buildList(itemSnapshot.data,snapshot.data);
          },
        );
      },
    );
  }

  Widget buildList(ItemModel item,Map<int,Future<ItemModel>>cache){
    final childList=<Widget>[];
    childList.add(buildTitle(item.title));
    final comment_list=item.kids.map((kidId){
      return Comment(
        itemId: kidId,
        itemMap: cache,
        depth:0
      );
    });
    childList.addAll(comment_list);
    return ListView(
      children: childList,
    );
  }

  Widget buildTitle(String title){
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(
        10.0
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}