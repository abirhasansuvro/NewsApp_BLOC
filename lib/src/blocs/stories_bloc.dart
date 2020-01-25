import 'package:rxdart/rxdart.dart';

import '../models/item_model.dart';
import '../resources/repository.dart';

class Stories{
  final _repository=Repository();
  final _topIds=PublishSubject <List<int>>(); 

  Observable<List<int>> get topIds=>_topIds.stream;

  fetchTopIds() async{
    final _ids=await _repository.fetchIds();
    _topIds.sink.add(_ids);
  }

  dispose(){
    _topIds.close();
  }
}