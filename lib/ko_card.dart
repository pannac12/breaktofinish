import 'ko_match.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class KOCard extends StatelessWidget {
  KOMatch match = KOMatch.empty();

  KOCard(KOMatch match) {
    this.match = match;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellow.shade50,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(16),
      elevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
          child: Column(
            children: [
              Table(columnWidths: {
                0: FlexColumnWidth(20),
                1: FlexColumnWidth(5),
                2: FlexColumnWidth(5),
                3: FlexColumnWidth(5),
                4: FlexColumnWidth(5),
                5: FlexColumnWidth(5),
                6: FlexColumnWidth(5),
              }, children: [
                TableRow(children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _playerName(match.player1),
                        _playerName(match.player2),
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _score(match.game1_score1, match.game1_score2),
                        _score(match.game1_score2, match.game1_score1),
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _boards(match.game1_boards.toString()),
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _score(match.game2_score1, match.game2_score2),
                        _score(match.game2_score2, match.game2_score1),
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _boards(match.game2_boards.toString()),
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _score(match.game3_score1, match.game3_score2),
                        _score(match.game3_score2, match.game3_score1),
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _boards(match.game3_boards.toString()),
                      ]),
                ])
              ]),
              Divider(
                thickness: 1,
              ),
              Row(
                children: [
                  _livestream(match.livestream),
                ],
              )
            ],
          )),
    );
  }

  Widget _playerName(String playerName) {
    return Text(
      playerName,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    );
  }

  Widget _score(int score, int otherScore) {
    Color scoreColor = Colors.green;
    if (score < otherScore) {
      scoreColor = Colors.red;
    }

    return Text(
      score.toString(),
      style: TextStyle(color: scoreColor, fontWeight: FontWeight.bold),
    );
  }

  Widget _boards(String boards) {
    return Text(
      '(' + boards + ')',
      style: TextStyle(color: Colors.black),
    );
  }

  Widget _livestream(String link) {
    return InkWell(
        splashColor: Colors.red,
        onTap: () {
          _launchVideo(link);
        },
        child: _isLivestream(link));
  }

  Widget _isLivestream(String link) {
    if (link.length > 0) {
      return Text(
        "Livestream",
        style:
            TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.bold),
      );
    } else {
      return Text("");
    }
  }

  _launchVideo(String url) {
    launch(url, enableJavaScript: true);
  }
}
