import 'format_view.dart';
import 'schedule_view.dart';
import 'ko_view.dart';
import 'pool_a_view.dart';
import 'pool_b_view.dart';
import 'sized_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(context) => Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Image(image: AssetImage('images/baca.jpeg')),
                ),
                ListTile(
                  title: Text("Format"),
                  onTap: () {
                    Get.toNamed(FormatView.route);
                  },
                ),
                ListTile(
                  title: Text("Schedule"),
                  onTap: () {
                    Get.toNamed(ScheduleView.route);
                  },
                ),

              ],
            ),
          ),
          appBar: AppBar(
            title: SizedText("BACA Rolling Trophy Tournament - July'21"),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  child: SizedText("Pool A",),),
                Tab(child: SizedText("Pool B",),),
                Tab(child: SizedText("KO",),),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              PoolAView(),
              PoolBView(),
              KOView(),
            ],
          ),
        ),
      ));
}
