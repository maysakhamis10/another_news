import 'package:anothernews/models/itemmodel.dart';
import 'package:anothernews/resources/repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';

class NewsDatabaseProvider implements Source, Cache{

  Database db ;


  NewsDatabaseProvider(){
    init();
  }

  void init () async{
      // hena hyrg3 el document ely hastore feha el data
      Directory documentDirectory = await getApplicationDocumentsDirectory();
      //here path is the path of directory it self + items.db
      final path = join(documentDirectory.path,"items3.db");
      db= await openDatabase(path,
      version: 1,
      onCreate: (Database newDB , int version){
        newDB.execute("""CREATE TABLE Items
          (
            id INTEGER PRIMARY KEY ,
            type TEXT,
            by TEXT ,
            time INTEGER,
            text TEXT,
            parent INTEGER ,
            kids BLOB,
            dead INTEGER ,
            deleted INTEGER ,
            url TEXT,
            score INTEGER ,
            title TEXT,
            descendants INTEGER
        )""");
      });
    }


  Future<ItemModel> fetchItem(int id) async {
    final maps = await db.query(
        "Items",
        columns: null,
        where: "id = ?",
        whereArgs: [id]
    );

    //if he find the record will get it
    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }
    //if he not find that record will return null
    else {
      return null;
    }
  }

  Future<List<int>> fetchTopIds() {
    // TODO: implement fetchTopIds
    return null;
  }


  @override
  Future<int> addItems(ItemModel item) {

    print('OUR_ITEM$item');
    return
      db.insert("Items",
          item.toMap(),
          conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> clear(){
    return db.delete("Items");
  }

}

final NewsDatabaseProvider newsDatabaseProvider =  NewsDatabaseProvider();