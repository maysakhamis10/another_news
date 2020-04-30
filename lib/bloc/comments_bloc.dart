import 'package:anothernews/models/itemmodel.dart';
import 'package:anothernews/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class CommentsBloc {

  final _repo = Repository();

  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  final _commentsFetcher = PublishSubject<int>();

  Observable<Map<int, Future<ItemModel>>> get itemsWithComments => _commentsOutput.stream;

  Function(int ) get fetchItemWithComments  => _commentsFetcher.sink.add;

  CommentsBloc(){

    _commentsFetcher.stream.
    transform(_commentsTransformers()).pipe(_commentsOutput);

  }

  //cache is our map that store ids for streambuilder its reference for map
  // id is the id that we need to get
  //not care about _ right now

  _commentsTransformers(){
    
    return ScanStreamTransformer((Map<int,Future<ItemModel>> cache, int id , index){
      //benfetch item from repo and  store it in cache
      cache[id] = _repo.fetchItem(id);
      print('$index');
      //recrusive
      cache[id].then((ItemModel item ){
        item.kids.forEach((kidId) => fetchItemWithComments(kidId));
      });
      return cache;
    },
      <int, Future<ItemModel>>{},
    );

  }

  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }

}