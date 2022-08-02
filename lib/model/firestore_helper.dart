import 'package:apricotcomicdemo/model/firestore_cats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  // DbHelperをinstance化する
  static final FirestoreHelper instance = FirestoreHelper._createInstance();

  FirestoreHelper._createInstance();

  Future selectAllCats(String userId) {
    final db = FirebaseFirestore.instance;
    final docRef = db.collection("users").doc(userId).get().then(
          (DocumentSnapshot doc) {},
          onError: (e) => print("selectAllCats Error: $e"),
        );
    return docRef;
  }

  Future catData(String userId, String id) {
    final db = FirebaseFirestore.instance;
    final docRef = db
        .collection("users")
        .doc(userId)
        .collection("cats")
        .doc(id)
        .get()
        .then((DocumentSnapshot doc) {});
    return docRef;
  }

  Future delete(Cats cats, String userId) {
    final db = FirebaseFirestore.instance;
    return db
        .collection("users")
        .doc(userId)
        .collection("cats")
        .doc(cats.id)
        .delete();
  }

  // データをインサートする
  Future insert(Cats cats, String userId) async {
    final db = FirebaseFirestore.instance;
    final docRef = db
      .collection("users")
      .doc(userId)
      .collection("cats")
      .doc("1")
      .withConverter(
        fromFirestore: Cats.fromFirestore,
        toFirestore: (Cats cats, options) => cats.toFirestore(),
      );
    await docRef.set(cats);
  }
}
