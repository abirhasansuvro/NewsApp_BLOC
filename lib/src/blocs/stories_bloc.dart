import 'package:rxdart/rxdart.dart';
import 'package:rxdart/rxdart.dart' as prefix0;

import 'dart:async';

import '../models/item_model.dart';
import '../resources/repository.dart';

class Stories{
  final _repository=Repository();
  final _topIds=PublishSubject <List<int>>(); 
  final _items=BehaviorSubject<int>();

  Observable<Map<int,Future<ItemModel>>> items;

  Observable<List<int>> get topIds=>_topIds.stream;

  Stories(){
    items=_items.stream.transform(_itemTransformer());
  }

  fetchTopIds() async{
    final _ids=await _repository.fetchIds();
    _topIds.sink.add(_ids);
  }

  Function(int) get fetchItm=>_items.sink.add;
  _itemTransformer(){
    return ScanStreamTransformer(
      (Map<int,Future<ItemModel>>cache,int id,index){
        cache[id]=_repository.fetchItem(id);
        return cache;
      },
      <int,Future<ItemModel>>{},
    );
  }

  dispose(){
    _topIds.close();
    _items.close();
  }
}