class Leaderboard {
  int rank;
  String name;
  int points;
  int opp;
  int diff;

  Leaderboard.empty() {
    this.rank = 0;
    this.name = '';
    this.points = 0;
    this.opp = 0;
    this.diff = 0;
  }

  Leaderboard({
    this.rank,
    this.name,
    this.points,
    this.opp,
    this.diff,
  });

  factory Leaderboard.fromJson(Map<String, dynamic> parsedJson) {
    return Leaderboard(
      rank: parsedJson["rank"] as int,
      name: parsedJson["name"] as String,
      points: parsedJson["points"] as int,
      opp: parsedJson["opp"] as int,
      diff: parsedJson["diff"] as int,
    );
  }

}