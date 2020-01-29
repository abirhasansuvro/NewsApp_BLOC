import 'package:rxdart/rxdart.dart';
import 'package:rxdart/rxdart.dart' as prefix0;

import 'dart:async';

import '../models/item_model.dart';
import '../resources/repository.dart';

class Stories{
  final _repository=Repository();
  final _topIds=PublishSubject <List<int>>(); 
  final _itemsOutput=BehaviorSubject<Map<int,Future<ItemModel>>>();
  final _itemsFetcher=PublishSubject<int>();


  Observable<List<int>> get topIds=>_topIds.stream;
  Observable<Map<int,Future<ItemModel>>> get items=>_itemsOutput.stream;

  Stories(){
    _itemsFetcher.stream.transform(_itemTransformer()).pipe(_itemsOutput);
  }

  fetchTopIds() async{
    final _ids=await _repository.fetchIds();
    _topIds.sink.add(_ids);
  }

  Function(int) get fetchItm=>_itemsFetcher.sink.add;
  
  _itemTransformer(){
    return ScanStreamTransformer(
      (Map<int,Future<ItemModel>>cache,int id,index){
        cache[id]=_repository.fetchItem(id);
        return cache;
      },
      <int,Future<ItemModel>>{},
    );
  }

  clearCache(){
    return _repository.clearCache();
  }

  dispose(){
    _topIds.close();
    _itemsOutput.close();
    _itemsFetcher.close();
  }
}