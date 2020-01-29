import 'package:flutter/material.dart';

import 'package:news_abstract/src/blocs/stories_provider.dart';

import '../widgets/news_list_tile.dart';
import '../widgets/refresh.dart';

class NewsList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final bloc=StoriesProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: buildNews(bloc),
    );
  }

  Widget buildNews(Stories bloc){
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (BuildContext context,AsyncSnapshot<List<int>> snapshot){
        if(!snapshot.hasData)return Center(
          child: CircularProgressIndicator(),
        );
        return Refresh(
              child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context,int index){
                bloc.fetchItm(snapshot.data[index]);
                return NewsListTile(itemId: snapshot.data[index]);
              },
            ),
        );
      },
    );
  }
}