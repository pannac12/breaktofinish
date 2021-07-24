class RRMatch {
  String player1;
  String player2;
  int score1;
  int score2;
  int boards;
  String livestream;

  RRMatch.empty() {
    this.player1 = '';
    this.player2 = '';
    this.score1 = 0;
    this.score2 = 0;
    this.boards = 0;
    this.livestream = '';
  }

  RRMatch({
    this.player1,
    this.player2,
    this.score1,
    this.score2,
    this.boards,
    this.livestream,
  });

  factory RRMatch.fromJson(Map<String, dynamic> parsedJson) {
    return RRMatch(
      player1: parsedJson["player1"] as String,
      player2: parsedJson["player2"] as String,
      score1: parsedJson["score1"] as int,
      score2: parsedJson["score2"] as int,
      boards: parsedJson["boards"] as int,
      livestream: parsedJson["livestream"] as String,
    );
  }

}