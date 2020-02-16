import 'package:flutter/material.dart';
import 'package:news/src/widgets/comment.dart';
import '../blocs/comments_provider.dart';
import 'dart:async';
import '../model/item_model.dart';
class NewsDetail extends StatelessWidget {
  final int itemID;
  NewsDetail(this.itemID);
  Widget build(context) {
    final bloc = CommentProvider.of(context);
    return Scaffold(
        appBar: AppBar(title: Text('Detail')), body: buildBody(bloc));
  }

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder:(context,AsyncSnapshot<Map<int,Future<ItemModel>>> snapshot) {
        if(!snapshot.hasData) {
          return Text('Loading1');  
        }
        final itemFuture = snapshot.data[itemID];
        return FutureBuilder(
          future: itemFuture,
          builder: (context, AsyncSnapshot<ItemModel> itemSnapShot) {
            if(!itemSnapShot.hasData){
                return Text('Loading2');  
            }
            return buildList( itemSnapShot.data,snapshot.data);
           
          },
        );
      },
    );

  }
  Widget buildList(ItemModel item, Map<int,Future<ItemModel>> itemMap) {
    final children = <Widget>[];
    children.add(buildTitle(item));
    final commentsList = item.kids.map((kidId){
      return Comment(
        itemId:kidId,
        cache:itemMap,
        depth:1

      );
    }).toList();
    children.addAll(commentsList);
    return ListView(
      children:children,
    );
  }
  Widget buildTitle(ItemModel item ) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(20.0),
      child: Text(item.title,textAlign: TextAlign.center,style: TextStyle(fontSize: 20.0,color: Colors.redAccent,fontWeight: FontWeight.bold),),
    );
  }

}
