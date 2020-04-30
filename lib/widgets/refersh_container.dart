import 'package:anothernews/bloc/myprovider.dart';
import 'package:flutter/material.dart';

class Refresh extends StatelessWidget{

  final Widget child ;

  Refresh({this.child});

  

  Widget build(BuildContext context){
    final bloc = MyProvider.of(context);
    return RefreshIndicator(
      child: child,
      onRefresh: () async{
         await  bloc.clearCache();
         await bloc.fetchTopIds();

         },
    );
  }

}