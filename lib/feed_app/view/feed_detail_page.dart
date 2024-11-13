import 'package:flutter/material.dart';
import 'package:flutter_feed_list_cubit/feed_app/feed_list.dart';

class FeedDetailPage extends StatelessWidget {
  const FeedDetailPage({super.key, required this.feed});
  final Feed feed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: CircleAvatar(
                radius: 32,
                child: Text(
                  feed.title.substring(0, 2).toUpperCase(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  feed.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            Center(
              child: Text(
                feed.body,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
