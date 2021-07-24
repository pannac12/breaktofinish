import 'rr_round.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class RRController extends GetxController {
  final rounds = <RRRound>[].obs;
  String pool;

  RRController(String pool) {
    this.pool = pool;
  }

  @override
  void onInit() async {
    rounds.bindStream(fetchGames());
    super.onInit();
  }

  Stream<List<RRRound>> fetchGames() {
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance
        .collection(pool)
        .snapshots();

    return stream.map((snapshot) =>
        snapshot.docs
            .map((doc) =>
            RRRound(doc.id, doc.data()['status'], doc.data()['endtime'], doc.data()['games']))
            .toList()
    );
  }
}
