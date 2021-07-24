import 'package:get_storage/get_storage.dart';

import 'rr_page.dart';
import 'sized_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'constants.dart';

class PoolAView extends StatefulWidget {
  static const String route = '/pool_a';

  @override
  _PoolAViewState createState() => _PoolAViewState();
}

class _PoolAViewState extends State<PoolAView>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  int _selectedIndex = 0;

  _buildSnackBar() {
    GetStorage box = GetStorage();
    if (box.read(Globals.showRefresh)) {
      Get.snackbar("The scores will update automatically",
          "Browser page refresh is not needed",
          colorText: Colors.red, snackPosition: SnackPosition.BOTTOM);
    }
    box.write(Globals.showRefresh, false);
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 5, vsync: this);
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
    });

    new Future.delayed(const Duration(seconds: 1))
        .then((_) => _buildSnackBar());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          toolbarHeight: 60, // Set this height
          bottom: TabBar(
            indicatorColor: Colors.white,
            controller: _controller,
            tabs: [
              Tab(child: SizedText(Round.round_1)),
              Tab(child: SizedText(Round.round_2)),
              Tab(child: SizedText(Round.round_3)),
              Tab(child: SizedText(Round.round_4)),
              Tab(child: SizedText(Round.round_5)),
            ],
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: <Widget>[
            RRPage(Pool.pool_a, Round.round_1),
            RRPage(Pool.pool_a, Round.round_2),
            RRPage(Pool.pool_a, Round.round_3),
            RRPage(Pool.pool_a, Round.round_4),
            RRPage(Pool.pool_a, Round.round_5),
          ],
        ),
      );
}
