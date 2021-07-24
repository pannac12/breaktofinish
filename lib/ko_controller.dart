import 'ko_round.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class KOController extends GetxController {
  final rounds = <KORound>[].obs;
  String pool;

  KOController(String pool) {
    this.pool = pool;
  }

  @override
  void onInit() async {
    rounds.bindStream(fetchGames());
    super.onInit();
  }

  Stream<List<KORound>> fetchGames() {
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance
        .collection(pool)
        .snapshots();

    return stream.map((snapshot) =>
        snapshot.docs
            .map((doc) =>
            KORound(doc.id, doc.data()['status'], doc.data()['endtime'], doc.data()['games']))
            .toList()
    );
  }
}
