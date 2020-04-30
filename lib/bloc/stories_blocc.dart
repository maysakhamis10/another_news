import 'package:anothernews/models/itemmodel.dart';
import 'package:anothernews/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class StoriesBloc {

  final _repo = Repository();
  /////type of stream controller bs like el broadcast el fr22 eno byreturn obeservable bdl el stream
  final _topIds = PublishSubject<List<int>>();
  ///type of stream controller a5er wa7ed bygelo bytl3o lel listener 3l eno first one
  final _itemsOutput = BehaviorSubject<Map<int,Future<ItemModel>>>();
  final _itemFetcher = PublishSubject<int>();

  //getter to streams
  Observable<List<int>>  get topIds => _topIds.stream;
  Observable<Map<int,Future<ItemModel>>> get items => _itemsOutput.stream ;



  //getter to sinks for each item
  Function (int) get fetchItem => _itemFetcher.sink.add;

  //constructor
  StoriesBloc(){
//    iteems =  _items.stream.transform(_itemsTransformers());
  //pipe method take every output event from that stream and
    // it automatically forwards to it on it to some target destination
  _itemFetcher.stream.transform(_itemsTransformers()).pipe(_itemsOutput);
  }


  //get all top idss
  fetchTopIds() async {
     final ids = await _repo.fetchTopIds();
    _topIds.sink.add(ids);

  }

clearCache(){
  return  _repo.clearCache();
}


  //cache is our map that store ids for streambuilder its reference for map
  // id is the id that we need to get
  //not care about _ right now
  _itemsTransformers(){
    return ScanStreamTransformer((Map<int,Future<ItemModel>> cache, int id , index){
      //benfetch item from repo and  store it in cache
      cache[id] = _repo.fetchItem(id);
      return cache;
    },
    <int, Future<ItemModel>>{},
    );

  }

   dispose(){
    _topIds.close();
    _itemFetcher.close();
    _itemsOutput.close();
  }

}