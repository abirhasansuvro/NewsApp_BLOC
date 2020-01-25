import 'package:flutter/material.dart';

import './stories_bloc.dart';

class StoriesProvider extends InheritedWidget{
  final Stories bloc;

  StoriesProvider({Key key,Widget child}):
    bloc=Stories(),
    super(key:key,child:child);
  
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Stories of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(StoriesProvider) as StoriesProvider).bloc;
  }
  
}