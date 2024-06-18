class Game {
  final String id;
  final DateTime commenceTime;
  final String homeTeam;
  final String awayTeam;
  final DateTime lastUpdate;
  final String homePrice;
  final String awayPrice;
  final String drawPrice;
  final String sportTitle;
  final String sportKey;

  Game({
    required this.id,
    required this.commenceTime,
    required this.homeTeam,
    required this.awayTeam,
    required this.lastUpdate,
    required this.homePrice,
    required this.awayPrice,
    required this.drawPrice,
    required this.sportTitle,
    required this.sportKey,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      commenceTime: DateTime.parse(json['commence_time']),
      homeTeam: json['home_team'],
      awayTeam: json['away_team'],
      lastUpdate: DateTime.parse(json['last_update']),
      homePrice: json['home_price'],
      awayPrice: json['away_price'],
      drawPrice: json['draw_price'],
      sportTitle: json['sport_title'],
      sportKey: json['sport_key'],
    );
  }
}
