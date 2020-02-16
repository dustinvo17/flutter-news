import 'package:flutter/material.dart';
import 'package:news/src/screens/news_list.dart';
import '../model/item_model.dart';
import '../blocs/stories_provider.dart';
import 'dart:async';
import '../screens/loading_container.dart';
import '../screens/news_detail.dart';
class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile(this.itemId);

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    // TODO: implement build
    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }
        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return LoadingContainer();
            }
            return buildTile(itemSnapshot.data,context);
          },
        );
      },
    );
  }

  Widget buildTile(ItemModel item,BuildContext context) {
    return Column(children: <Widget>[
      ListTile(
        onTap: () {
          Navigator.pushNamed(context,'/${item.id}');
          
        },
        title: Text(item.title),
        subtitle: Text('${item.score} votes'),
        trailing: Column(
          children: <Widget>[Icon(Icons.comment), Text('${item.descendants}')],
        ),
      ),
      Divider(color: Colors.blueGrey,)
    ]);
  }
}
