import 'dart:convert';
import '../model/item_model.dart';
import 'package:http/http.dart' show Client;
import './repository.dart';

final _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider  implements Source {
  Client client = Client();

  Future<List<int>> fetchTopIds() async {
    final res = await client.get('${_root}/topstories.json');
    final ids = jsonDecode(res.body);

    return ids.cast<int>();
  }

  Future<ItemModel> fetchItem(int id) async {
    final res = await client.get('${_root}/item/${id}.json');
    final parsedJson = jsonDecode(res.body);

    return ItemModel.fromJson(parsedJson);
  }
}
