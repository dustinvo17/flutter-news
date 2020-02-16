import 'dart:convert';

import 'package:news/src/resources/news_api_provider.dart';
import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart' ;


void main() {
  test('fetch top id return a list o ids',() async {
    final newsApi  = NewsApiProvider();
    newsApi.client = MockClient((request) async {
        return Response(jsonEncode([1,2,3,4]),200);
    });
    final ids =  await newsApi.fetchTopIds();
    expect(ids,[1,2,3,4]);
  });

  test('fetch item return item model', () async {
    final newsApi  = NewsApiProvider();
     newsApi.client = MockClient((request) async {
       final jsonMap = {'id':123};
        return Response(jsonEncode(jsonMap),200);
    });
    final item = await newsApi.fetchItem(999);
    expect(item.id,123);  

  });

}