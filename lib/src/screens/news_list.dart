import 'package:flutter/material.dart';

import 'package:news_abstract/src/blocs/stories_provider.dart';

class NewsList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final bloc=StoriesProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
    );
  }
}