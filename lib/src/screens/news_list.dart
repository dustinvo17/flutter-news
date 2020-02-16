import 'package:flutter/material.dart';
import 'package:news/src/widgets/news_list_tile.dart';
import '../blocs/stories_provider.dart';
import '../blocs/stories_bloc.dart';
import './refresh.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    bloc.fetchTopIds();
    return Scaffold(
      appBar: AppBar(
        title: Text('Top news'),
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Refresh(ListView.builder(
          itemCount: snapshot.data.length,
        
          itemBuilder: (context, index) {

            bloc.fetchItem(snapshot.data[index]);
            return NewsListTile(snapshot.data[index]);
          },
        ));
      },
    );
  }
}
