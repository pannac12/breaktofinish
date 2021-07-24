import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_core/src/get_main.dart';

import 'leaderboard_model.dart';
import 'package:get/get.dart';


class LeaderboardView extends StatelessWidget {
  static const String route = '/leaderboard';
  String pool = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection(pool).doc("Leaderboard").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return LinearProgressIndicator();
        return _getData(context, snapshot.data);
      },
    );
  }

  Widget _getData(BuildContext context, DocumentSnapshot snapshot) {
    String ranks = "";
    if (snapshot.data().length > 0) {
      ranks = snapshot.data()['standings'];
    }

    List<Leaderboard> leaderboard = (json.decode(ranks) as List)
        .map((i) => Leaderboard.fromJson(i))
        .toList();

    return Scaffold(
        appBar: AppBar(
          title: Text("Leaderboard - " + pool),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 20,
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'Rank',
                ),
              ),
              DataColumn(
                label: Text(
                  'Name',
                ),
              ),
              DataColumn(
                label: Text(
                  'Points',
                ),
              ),
              DataColumn(
                label: Text(
                  'Opp Points',
                ),
              ),
              DataColumn(
                label: Text(
                  'Score diff',
                ),
              ),
            ],

            rows: List.generate(
                leaderboard.length, (index) => _getDataRow(leaderboard[index])),
          )
          ),
        );
  }

  DataRow _getDataRow(Leaderboard leader) {
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(leader.rank.toString())),
        DataCell(Text(leader.name)),
        DataCell(Text(leader.points.toString())),
        DataCell(Text(leader.opp.toString())),
        DataCell(Text(leader.diff.toString())),
      ],
    );
  }
}