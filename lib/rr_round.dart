import 'package:breaktofinish/rr_match.dart';

class RRRound {
  String round;
  String status;
  String endtime;
  String games;

  RRRound.empty() {
    this.round = '';
    this.status = '';
    this.endtime = '';
    this.games = '';
  }

  RRRound(String round, String status, String endtime, String games){
    this.round = round;
    this.status = status;
    this.endtime = endtime;
    this.games = games;
  }
}