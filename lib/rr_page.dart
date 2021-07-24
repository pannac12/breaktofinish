import 'dart:async';
import 'dart:convert';

import 'package:breaktofinish/rr_match.dart';

import 'constants.dart';
import 'leaderboard_view.dart';
import 'rr_card.dart';
import 'rr_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RRPage extends StatefulWidget {
  String pool;
  String roundNumber;

  RRPage(String pool, String roundNumber) {
    this.pool = pool;
    this.roundNumber = roundNumber;
  }

  @override
  _RRPageState createState() => _RRPageState();
}

class _RRPageState extends State<RRPage> {
  List<RRMatch> matches = <RRMatch>[].obs;
  String status = Round.notStarted;
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
    RRController controller = Get.find(tag: widget.pool);

    return GetX<RRController>(
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
          return RRCard(roundsToMatches(controller)[index]);
        },
      ),
    );
  }

  List<RRMatch> roundsToMatches(RRController controller) {
    for (final round in controller.rounds) {
      if (round.round == widget.roundNumber) {
        status = round.status;
        endtime = round.endtime;
        matches = (json.decode(round.games) as List)
            .map((i) => RRMatch.fromJson(i))
            .toList();
      }
    }
    return matches;
  }

  Widget _topCard() {
    Color statusColor = Colors.white;
    if (status == Round.hasCompleted) {
      statusColor = Colors.grey.shade400;
    } else if (status == Round.inProgress) {
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
            title: Text(widget.pool + ' ' + widget.roundNumber),
            subtitle: Text(status),
            trailing: IconButton(
              icon: const Icon(Icons.list, color: Colors.blue),
              tooltip: 'Leaderboard',
              iconSize: 40.0,
              onPressed: () {
                Get.toNamed(LeaderboardView.route, arguments: widget.pool);
              },
            ),
            tileColor: statusColor,
          ),
        ],
      ),
    );
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
