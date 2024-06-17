class League {
  final String key;
  final String group;
  final String title;
  final String description;

  League({
    required this.key,
    required this.group,
    required this.title,
    required this.description,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      key: json['key'],
      group: json['group'],
      title: json['title'],
      description: json['description'],
    );
  }
}
