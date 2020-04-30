import 'package:anothernews/models/itemmodel.dart';
import 'package:anothernews/bloc/myprovider.dart';
import 'package:anothernews/widgets/new_list_tile.dart';
import 'package:anothernews/widgets/refersh_container.dart';
import 'package:anothernews/bloc/stories_blocc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class NewsList extends StatelessWidget{

  Widget build(BuildContext context){
    final bloc = MyProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Top News'),
      ),
      body: buildList(bloc),
    );
  }


  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Center (
            child:  CircularProgressIndicator(),
          );
        }

        return Refresh(
           child : ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, int index) {
                bloc.fetchItem(snapshot.data[index]);
                return NewListTile(
                  itemId: snapshot.data[index],
                );

              },

            ),
        );

//        return ListView.builder(
//
//          itemCount: snapshot.data.length,
//          itemBuilder: (context, int index) {
//            bloc.fetchItem(snapshot.data[index]);
//            return NewListTile(
//              itemId: snapshot.data[index],
//
//         );
//
//          },
//
//        );
      },
    );
  }


}