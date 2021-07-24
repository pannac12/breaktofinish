class KORound {
  String round;
  String status;
  String endtime;
  String games;

  KORound.empty() {
    this.round = '';
    this.status = '';
    this.endtime = '';
    this.games = '';
  }

  KORound(String round, String status, String endtime, String games){
    this.round = round;
    this.status = status;
    this.endtime = endtime;
    this.games = games;
  }
}