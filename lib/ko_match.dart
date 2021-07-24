class KOMatch {
  String player1;
  String player2;
  int game1_score1;
  int game1_score2;
  int game1_boards;
  int game2_score1;
  int game2_score2;
  int game2_boards;
  int game3_score1;
  int game3_score2;
  int game3_boards;
  String livestream;

  KOMatch.empty() {
    this.player1 = '';
    this.player2 = '';
    this.game1_score1 = 0;
    this.game1_score2 = 0;
    this.game1_boards = 0;
    this.game2_score1 = 0;
    this.game2_score2 = 0;
    this.game2_boards = 0;
    this.game3_score1 = 0;
    this.game3_score2 = 0;
    this.game3_boards = 0;
    this.livestream = '';
  }

  KOMatch({
    this.player1,
    this.player2,
    this.game1_score1,
    this.game1_score2,
    this.game1_boards,
    this.game2_score1,
    this.game2_score2,
    this.game2_boards,
    this.game3_score1,
    this.game3_score2,
    this.game3_boards,
    this.livestream,
  });

  factory KOMatch.fromJson(Map<String, dynamic> parsedJson) {
    return KOMatch(
      player1: parsedJson["player1"] as String,
      player2: parsedJson["player2"] as String,
      game1_score1: parsedJson["game1_score1"] as int,
      game1_score2: parsedJson["game1_score2"] as int,
      game1_boards: parsedJson["game1_boards"] as int,
      game2_score1: parsedJson["game2_score1"] as int,
      game2_score2: parsedJson["game2_score2"] as int,
      game2_boards: parsedJson["game2_boards"] as int,
      game3_score1: parsedJson["game3_score1"] as int,
      game3_score2: parsedJson["game3_score2"] as int,
      game3_boards: parsedJson["game3_boards"] as int,
      livestream: parsedJson["livestream"] as String,
    );
  }

}