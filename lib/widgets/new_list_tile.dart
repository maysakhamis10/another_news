import 'package:anothernews/models/itemmodel.dart';
import 'package:anothernews/widgets/loading_container.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../bloc/myprovider.dart';


class NewListTile extends StatelessWidget{

  final int itemId;
  NewListTile({this.itemId});


  Widget build(BuildContext context){
    final bloc = MyProvider.of(context);
    return  StreamBuilder(
      stream:  bloc.items,
      builder: (context, AsyncSnapshot<Map<int,Future<ItemModel>>> snapshot) {
      if (!snapshot.hasData) {
          return LoadingContainer();
      }
      else {
        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return LoadingContainer();
            }
            return buildTile(context, itemSnapshot.data);
          },
        );
      }
    } ,
    );
  }

  Widget buildTile(BuildContext context ,  ItemModel itemModel){
    return Column(
      children:[
      ListTile(
        onTap: (){
          print('${itemModel.id} was tapped !!!!!!!');
          Navigator.pushNamed(context, '/${itemModel.id}');
        },
      title: Text(itemModel.title),
      subtitle: Text('${itemModel.score} points'),
      trailing: Column(
        children: [
          Icon(Icons.comment),
          Text('${itemModel.descendants}')
        ],
      ),
    ),
        Divider(
          height: 15.0,
          color: Colors.black12,
        )
      ],
    );
  }


}