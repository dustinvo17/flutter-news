import 'package:news/src/blocs/comments_provider.dart';
import 'package:rxdart/rxdart.dart';
import '../model/item_model.dart';
import '../resources/repository.dart';
import 'dart:async';

 class CommentsBloc {
   final _repository = Repository();
   final _commentsFetcher = PublishSubject<int>();
   final _commentsOutput = BehaviorSubject<Map<int,Future<ItemModel>>>();

   Stream<Map<int,Future<ItemModel>>> get itemWithComments => _commentsOutput.stream;

   Function(int) get fetchItemWithComment => _commentsFetcher.sink.add;

   CommentsBloc() {
     _commentsFetcher.stream.transform(_commentsTransformer()).pipe(_commentsOutput);
   }
   _commentsTransformer() {
     return ScanStreamTransformer<int,Map<int,Future<ItemModel>>>(
        (cache,currentID,index){
   
          cache[currentID] = _repository.fetchItem(currentID);
          cache[currentID].then((ItemModel result) {
            result.kids.forEach((kidId) => fetchItemWithComment(kidId));
          });
          return cache;   

        },<int,Future<ItemModel>> {}
     );
   }
   dispose() {
     _commentsFetcher.close();
     _commentsOutput.close();
   }
 }