import 'package:flutter/material.dart';
import 'package:news/src/blocs/stories_bloc.dart';
import 'screens/news_list.dart';
import '../src/blocs/stories_provider.dart';
import 'screens/news_detail.dart';
import '../src/blocs/comments_provider.dart';
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentProvider(child: StoriesProvider(
        child: MaterialApp(
      title: 'News!',
      onGenerateRoute: routes,

    )),);
  
  }
}

Route routes(RouteSettings settings) {
  if(settings.name == '/' ) {
       
     return MaterialPageRoute(builder: (context) {
        final bloc = StoriesProvider.of(context);
        bloc.fetchTopIds();
      return NewsList();
    });
  } else {
     return MaterialPageRoute(builder: (context) {
      final int id = int.parse(settings.name.replaceFirst('/', ''));
      final commetsBloc = CommentProvider.of(context);
      commetsBloc.fetchItemWithComment(id); 
      return NewsDetail(id);
    });
  }

 
}
