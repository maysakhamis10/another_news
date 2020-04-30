import 'package:anothernews/resources/repository.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/itemmodel.dart';

final _root = 'https://hacker-news.firebaseio.com/v0';

class NewApiProvider implements Source{

  Client client = new Client();

  Future<ItemModel> fetchItem(int id ) async{
    print('$id');
    final detailsResponse = await client.get('$_root/item/$id.json');
    var status = detailsResponse.statusCode;
    print('status $status');
    final parsedJson =  json.decode(detailsResponse.body);
    return ItemModel.fromJson(parsedJson);
  }



  Future<List<int>> fetchTopIds() async{
    final response = await client.get('$_root/topstories.json');
    final ids = json.decode(response.body);
    var statuscode = response.statusCode ;
    print('IDS IS $statuscode');
    return ids.cast<int>() ;
  }



}