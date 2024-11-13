part of "feed_list_page.dart";

class FeedListView extends StatelessWidget {
  const FeedListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Light background for modern feel
      body: BlocBuilder<FeedListCubit, FeedListState>(
        builder: (context, state) {
          if (state is FeedListSuccess) {
            // Filter the visible feeds
            final visibleFeeds =
                state.feeds.where((feed) => !feed.hidden).toList();

            return Padding(
              padding: const EdgeInsets.all(
                  16.0), // Add some padding around the list
              child: ListView.builder(
                itemCount: visibleFeeds.length,
                itemBuilder: (context, index) {
                  final feed = visibleFeeds[index];

                  return Card(
                    elevation: 4, // Adds a shadow for the modern card look
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Rounded corners
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(
                          16), // Adds padding inside the card
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blueAccent,
                        child: Text(
                          feed.title.substring(0, 1).toUpperCase(),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      title: Text(
                        feed.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                      ),
                      subtitle: Text(
                        feed.body.length > 55
                            ? '${feed.body.substring(0, 55)}...'
                            : feed.body,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.black54,
                            ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FeedDetailPage(feed: feed),
                          ),
                        );
                      },
                      onLongPress: () {
                        // Call the Cubit method to hide/unhide the feed
                        context.read<FeedListCubit>().hideFeed(feed);
                      },
                    ),
                  );
                },
              ),
            );
          } else if (state is FeedListError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.errorMessage,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<FeedListCubit>().fetchFeed(),
                    child: const Text("Refresh"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent, // Modern button color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8), // Rounded corners
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is FeedListLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: ElevatedButton(
                onPressed: () => context.read<FeedListCubit>().fetchFeed(),
                child: const Text("Refresh"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.refresh),
        onPressed: () => context.read<FeedListCubit>().fetchFeed(),
      ),
    );
  }
}
