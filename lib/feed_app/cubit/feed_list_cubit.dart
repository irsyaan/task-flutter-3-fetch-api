import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_feed_list_cubit/feed_app/feed_list.dart';

part "feed_list_state.dart";

class FeedListCubit extends Cubit<FeedListState> {
  FeedListCubit() : super(const FeedListState.initial());

   fetchFeed() async {
    try {
      emit(const FeedListState.loading());
      Dio dio = Dio();

      final res = await dio.get("https://jsonplaceholder.typicode.com/posts");

      if (res.statusCode == 200) {
        final List<Feed> feeds = res.data.map<Feed>((d) {
          return Feed.fromJson(d);
        }).toList();

        emit(FeedListState.success(feeds));
      } else {
        emit(FeedListState.error("Error loading data: ${res.data.toString()}"));
      }
    } catch (e) {
      emit(FeedListState.error("Error loading data: ${e.toString()}"));
    }
  }

  // This method removes a feed from the list
  removeData(Feed feed) {
    // We can get the current list from the state and remove the feed
    if (state is FeedListSuccess) {
      final currentFeeds = List<Feed>.from((state as FeedListSuccess).feeds);
      currentFeeds.remove(feed);

      // Emit the new state with the updated feed list
      emit(FeedListState.success(currentFeeds));
    }
  }

   hideFeed(Feed feed) {
    if (state is FeedListSuccess) {
      final currentFeeds = List<Feed>.from((state as FeedListSuccess).feeds);

      // Toggle the hidden property
      final feedIndex = currentFeeds.indexWhere((f) => f.id == feed.id);
      if (feedIndex != -1) {
        currentFeeds[feedIndex].hidden = !currentFeeds[feedIndex].hidden;
      }

      // Emit the updated list with the changed hidden status
      emit(FeedListState.success(currentFeeds));
    }
  }
}

