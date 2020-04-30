import 'package:anothernews/bloc/comments_provider.dart';
import 'package:anothernews/bloc/myprovider.dart';
import 'package:anothernews/screens/news_details.dart';
import 'package:anothernews/screens/news_list.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  Widget build(BuildContext context) {
    return CommentsProvider(
      child: MyProvider(
        child: MaterialApp(
          title: 'News',
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings setting){
    if(setting.name == '/'){
      return MaterialPageRoute(
            builder: (context){
              final bloc = MyProvider.of(context);
              bloc.fetchTopIds();

              return NewsList();
            }
        );
    }
    else{
      return MaterialPageRoute(
            builder: (context){
              final commentBloc = CommentsProvider.of(context);
              final itemId = int.parse(setting.name.replaceFirst('/', ''));
              commentBloc.fetchItemWithComments(itemId);
              return StoryDetails(
                itemId : itemId ,
              );
            }
        );
    }

//    switch(setting.name){
//      case '/':
//        return MaterialPageRoute(
//            builder: (context){
//              return NewsList();
//            }
//        );
//        break;
//      case '' :
//        return MaterialPageRoute(
//            builder: (context){
//              return StoryDetails();
//            }
//        );
//        break;
//
//
//    }
  }

}

