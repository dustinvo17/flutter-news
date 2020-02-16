

import '../model/item_model.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import '../screens/loading_container.dart';
class Comment extends StatelessWidget {
  final int itemId;
  final Map<int,Future<ItemModel>> cache;
  final int depth;

  Comment({this.itemId,this.cache,this.depth});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:cache[itemId],
      builder:(context,AsyncSnapshot<ItemModel> snapshot){
        if(!snapshot.hasData) {
          return LoadingContainer();
        }
        final children = <Widget> [
          ListTile(
            contentPadding: EdgeInsets.only(left:16.0 * this.depth,right:16.0),
            title:buildText(snapshot.data),
            subtitle: Text(snapshot.data.by == '' ? 'Deleted' : snapshot.data.by),
          ),
          Divider(color: this.depth == 1 ? null : Colors.red,),


        ];
        snapshot.data.kids.forEach((kidComment) {
          children.add(Comment(itemId: kidComment,cache:cache,depth: this.depth + 1,));
          
        });
        return Column(
          children:children,
        );
      }
    );
  }
  Widget buildText(ItemModel item) {
   
    final text = item.text.replaceAll('&#x27;', " ' ").replaceAll('<p>', '\n\n').replaceAll('</p>', '');
    return Text(text);
  }
}