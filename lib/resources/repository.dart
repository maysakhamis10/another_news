import 'dart:async';
import 'package:anothernews/models/itemmodel.dart';
import 'news_db_provider.dart';
import 'newapiprovider.dart';

class Repository {

  List<Source> sources  = <Source>[
    newsDatabaseProvider,
    NewApiProvider(),
  ];

  List<Cache> caches =  <Cache>[
    newsDatabaseProvider,
  ];
  //e7na 3amlna kda 3shan e7na 3mlen add aw hngeb el id from source 1 ely howa beta3 el API
  Future<List<int>> fetchTopIds() {
      return sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item ;
    Source source ;
    for(source in sources){
      item = await source.fetchItem(id);
      if(item != null){
        break ;
      }
      for(var cache in caches){
        if(cache!=source) {
          cache.addItems(item);
        }
      }
    }


    return item ;

  }

  clearCache() async {
    for (var cache in caches) {
     await cache.clear();
    }
  }


}

abstract class Source {

  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache{
  Future<int> clear();
  Future<int> addItems(ItemModel item);
}