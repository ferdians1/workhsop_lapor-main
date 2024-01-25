import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lapor_workshop/models/komentars.dart';

class Utils {
  Utils._();

  static Future<void> post({
    required String laporanId,
    required String komentar,
  }) async {
    final auth = FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance;
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
          .collection('akun')
          .where('uid', isEqualTo: auth.currentUser!.uid)
          .limit(1)
          .get();

      String userId = '';
      String name = '';

      if (querySnapshot.docs.isNotEmpty) {
        var userData = querySnapshot.docs.first.data() as Map<String, dynamic>;

        userId = userData['uid'];
        name = userData['nama'];
      }

      // tambah komentar
      CollectionReference komentarReference =
          FirebaseFirestore.instance.collection('komentar');

      final id = komentarReference.doc().id;
      komentarReference.add({
        'id': id,
        'laporanId': laporanId,
        'userId': userId,
        'name': name,
        'komentar': komentar,
      });
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<Komentars>> getComentarList(String laporanId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('komentar')
              .where('laporanId', isEqualTo: laporanId)
              .get();

      final List<Komentars> results = [];

      for (var documents in querySnapshot.docs) {
        results.add(Komentars(documents['name'], documents['komentar']));
      }

      return results;
    } catch (e) {
      rethrow;
    }
  }
}
