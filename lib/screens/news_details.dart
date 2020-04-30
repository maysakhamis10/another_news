import 'dart:async';
import 'package:anothernews/bloc/comments_provider.dart';
import 'package:anothernews/models/itemmodel.dart';
import 'package:anothernews/widgets/comments.dart';
import 'package:anothernews/widgets/loading_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class StoryDetails extends StatelessWidget {

  final int itemId;

  StoryDetails({this.itemId});

  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Details'),
      ),
      body: buildBody(bloc),
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemsWithComments,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }
        else {
          final itemFuture = snapshot.data[itemId];
          return FutureBuilder(
            future: itemFuture,
            builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
              if (!itemSnapshot.hasData) {
                return LoadingContainer();
              }
              else {
                return buildCommentsList(itemSnapshot.data, snapshot.data);
              }
            },
          );
        }
      },
    );
  }

  Widget buildTitle(ItemModel itemModel) {
    return Container(
      margin: EdgeInsets.all(10.0),
      alignment: Alignment.topCenter,
      child: Text(
        itemModel.title,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold
        ),
      ),

    );
  }

  //build commments list
  Widget buildCommentsList(ItemModel item,
      Map<int, Future<ItemModel>> topStoryCacheMap ) {

    final children = <Widget>[];
    children.add(buildTitle(item));
    //map de htrg3 elmenet element mn el list el kids
    //page el comment hat5od el id w ta5od el top cachemap
    //3shan tegb el comment ely be el id el mo3yn ely gwa list el kids
    final commentsList = item.kids.map((commentKidId){
      return Comment(
        itemId : commentKidId,
        itemMap: topStoryCacheMap,
        depth: 1,
      );
    }).toList();
    children.addAll(commentsList);
    return ListView(
      children: children,
    );
  }




}