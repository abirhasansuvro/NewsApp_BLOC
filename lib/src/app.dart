import 'package:flutter/material.dart';
import 'package:news_abstract/src/blocs/stories_bloc.dart';

import './screens/news_list.dart';
import './blocs/stories_provider.dart';
import './blocs/comments_provider.dart';
import './screens/news_detail.dart';

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
            child: StoriesProvider(
              child: MaterialApp(
                title: 'News App',
                onGenerateRoute: route,
              ),
            ),
    );
  }
  Route route(RouteSettings routeSettings){
    if(routeSettings.name=='/'){
      return MaterialPageRoute(
        builder: (context){
          final bloc=StoriesProvider.of(context);
          bloc.fetchTopIds();
          return NewsList();
        },
      );
    }
    return MaterialPageRoute(
      builder: (context){
        final itemId=int.parse(routeSettings.name.replaceFirst('/', ''));
        final commentsBloc=CommentsProvider.of(context);

        commentsBloc.fetchItemWithComments(itemId);
        return NewsDetail(
          itemId: itemId,
        );
      }
    );
          
  }
}