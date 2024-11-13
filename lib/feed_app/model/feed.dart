class Feed {
  final int id;
  final String title;
  final String body;
  bool hidden; // Add the hidden property here

  Feed({
    required this.id,
    required this.title,
    required this.body,
    this.hidden = false, // Default value is false (not hidden)
  });

  // Method to create a Feed instance from JSON
  factory Feed.fromJson(Map<String, dynamic> json) {
    return Feed(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  // Method to convert a Feed instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }
}
