import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feed_list_cubit/feed_app/feed_list.dart';
import 'package:flutter_feed_list_cubit/feed_app/view/feed_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "feed_list_view.dart";

class FeedListPage extends StatelessWidget {
  const FeedListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedListCubit(),
      child: const FeedListView(),
    );
  }
}
