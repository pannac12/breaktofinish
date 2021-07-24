import 'package:breaktofinish/leaderboard_view.dart';

import 'format_view.dart';
import 'ko_controller.dart';
import 'ko_view.dart';
import 'rr_controller.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'constants.dart';
import 'pool_a_view.dart';
import 'pool_b_view.dart';
import 'schedule_view.dart';
import 'main_view.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  await initializeGlobals();

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainView(),
      unknownRoute: GetPage(name: '/notfound', page: () => PoolAView()),
      getPages: [
        GetPage(name: PoolAView.route, page: () => PoolAView()),
        GetPage(name: PoolBView.route, page: () => PoolBView()),
        GetPage(name: KOView.route, page: () => KOView()),
        GetPage(name: ScheduleView.route, page: () => ScheduleView()),
        GetPage(name: FormatView.route, page: () => FormatView()),
        GetPage(name: LeaderboardView.route, page: () => LeaderboardView()),
      ],
    );
  }
}

initializeGlobals() async {
  Get.put(RRController(Pool.pool_a), tag: Pool.pool_a);
  Get.put(RRController(Pool.pool_b), tag: Pool.pool_b);
  Get.put(KOController(Pool.pool_ko), tag: Pool.pool_ko);

  GetStorage box = GetStorage();
  box.write(Globals.showRefresh, true);
}

