import 'dart:async';
import 'package:anothernews/models/itemmodel.dart';
import 'package:anothernews/widgets/loading_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Comment extends StatelessWidget{

  final int itemId  ;
  final int depth ;
  final Map<int  , Future<ItemModel>> itemMap ;
  Comment({this.itemId,this.itemMap, this.depth});

  Widget build(BuildContext context){
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context,  AsyncSnapshot<ItemModel> snapshot){
        if(!snapshot.hasData){
          return LoadingContainer();
        }
        else{
          final item = snapshot.data ;
          final children= <Widget>[
            ListTile(
              title: Text(item.text
                  .replaceAll('&#x27;', "'")
              .replaceAll('<p>', '\n\n')
              .replaceAll('</p>', '')
              ),

              subtitle: item.by == ''? Text('Deleted') : Text(item.by),
              contentPadding: EdgeInsets.only(
                right: 20.0 ,
                left: depth * 20.0
              ),

            ),
            Divider(),
          ];
          snapshot.data.kids.forEach((kidId){
           children.add(Comment(
              itemId: kidId,
              itemMap: itemMap,
             depth: depth +1,
            ));
          });
          return Column(
            children: children,
          );
        }
      },
    );
  }

}