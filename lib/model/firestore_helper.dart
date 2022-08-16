import 'package:apricotcomicdemo/model/firestore_cats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  // DbHelperをinstance化する
  static final FirestoreHelper instance = FirestoreHelper._createInstance();

  FirestoreHelper._createInstance();

  selectAllCats(String userId) async {
    final db = FirebaseFirestore.instance;
    final snapshot =
        db.collection("users").doc(userId).collection("cats").withConverter(
              fromFirestore: Cats.fromFirestore,
              toFirestore: (Cats cats, _) => cats.toFirestore(),
            );
    final cats = await snapshot.get();
    return cats.docs;
  }

  catData(String userId, String id) async {
    final db = FirebaseFirestore.instance;
    final docRef = db
        .collection("users")
        .doc(userId)
        .collection("cats")
        .doc(id)
        .withConverter(
          fromFirestore: Cats.fromFirestore,
          toFirestore: (Cats cats, _) => cats.toFirestore(),
        );
    final catdata = await docRef.get();
    final cat = catdata.data();
    return cat;
  }

  Future delete(String userId, String name) {
    final db = FirebaseFirestore.instance;
    return db
        .collection("users")
        .doc(userId)
        .collection("cats")
        .doc(name)
        .delete();
  }

  // データをインサートする
  Future insert(Cats cats, String userId) async {
    final db = FirebaseFirestore.instance;
    final docRef = db
        .collection("users")
        .doc(userId)
        .collection("cats")
        .doc(cats.name)
        .withConverter(
          fromFirestore: Cats.fromFirestore,
          toFirestore: (Cats cats, options) => cats.toFirestore(),
        );
    await docRef.set(cats);
  }
}
