import 'package:flutter/material.dart';
import 'stories_blocc.dart';

class MyProvider extends InheritedWidget{

  final StoriesBloc bloc ;

  MyProvider({Key  key , Widget child}) :
        bloc = StoriesBloc (), super(key:key , child:child);


  bool updateShouldNotify(_)=> true;


  static StoriesBloc of (BuildContext context){

    return (context.inheritFromWidgetOfExactType(MyProvider) as MyProvider).bloc ;

  }



}