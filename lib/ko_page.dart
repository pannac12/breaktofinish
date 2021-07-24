import 'dart:async';
import 'dart:convert';
import 'constants.dart';
import 'ko_card.dart';
import 'ko_controller.dart';
import 'ko_match.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class KOPage extends StatefulWidget {
  String pool;
  String roundNumber;
  String status;

  KOPage(String pool, String roundNumber) {
    this.pool = pool;
    this.roundNumber = roundNumber;
    status = Round.notStarted;
  }

  @override
  _KOPageState createState() => _KOPageState();
}

class _KOPageState extends State<KOPage> {
  List<KOMatch> matches = <KOMatch>[].obs;

  String _timeRemaining = "";
  String endtime = "";
  Timer _timer;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        _timeRemaining = _timeLeft();
      });
    });
  }

  @override
  void _deactivate() {
    if (_timer != null) {
      _timer.cancel();
    }
    super.deactivate();
  }

  Widget build(BuildContext context) {
    KOController controller = Get.find(tag: widget.pool);

    return GetX<KOController>(
      tag: widget.pool,
      autoRemove: false,
      init: controller,
      builder: (_) => ListView.builder(
        itemCount: roundsToMatches(controller).length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return _topCard();
          }
          index -= 1;
          return KOCard(roundsToMatches(controller)[index]);
        },
      ),
    );
  }

  List<KOMatch> roundsToMatches(KOController controller) {
    for (final round in controller.rounds) {
      if (round.round == widget.roundNumber) {
        widget.status = round.status;
        endtime = round.endtime;
        matches = (json.decode(round.games) as List)
            .map((i) => KOMatch.fromJson(i))
            .toList();
      }
    }
    return matches;
  }

  Widget _topCard() {
    Color statusColor = Colors.white;
    if (widget.status == Round.hasCompleted) {
      statusColor = Colors.grey.shade400;
    } else if (widget.status == Round.inProgress) {
      statusColor = Colors.lightGreen;
    }

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(8),
      elevation: 16,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Text(_timeRemaining,
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            trailing: Icon(Ionicons.trophy, size: 50, color: Colors.amber),
            title: Text(widget.pool + ' ' + _statusText()),
            subtitle: Text(widget.status),
            tileColor: statusColor,
          ),
        ],
      ),
    );
  }

  String _statusText() {
    var statusMap = {
      Round.qf: 'Quarter Final',
      Round.sf_a: 'Semi Final - Group A',
      Round.sf_b: 'Semi Final - Group B',
      Round.f_a: 'Final - Group A',
      Round.f_b: 'Final - Group B',
      Round.a_3: '3rd Place - Group A',
      Round.b_3: '3rd Place - Group B',
    };
    return statusMap[widget.roundNumber];
  }

  String _timeLeft() {
    const String zeroTime = "0.00";
    Duration remaining;

    if (endtime == null) {
      return zeroTime;
    }
    if (endtime.length == 0) {
      return zeroTime;
    }
    try {
      remaining = DateTime.parse(endtime).difference(DateTime.now());
    } catch (e) {
      return zeroTime;
    }

    if (remaining.inSeconds < 0) {
      return zeroTime;
    } else {
      String minutes = "${remaining.inMinutes.remainder(60)}";
      String seconds = "${remaining.inSeconds.remainder(60)}";
      minutes = minutes.padLeft(2, '0');
      seconds = seconds.padLeft(2, '0');
      return minutes + ":" + seconds;
    }
  }
}

