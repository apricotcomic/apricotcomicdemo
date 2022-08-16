import 'package:apricotcomicdemo/model/firestore_cats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// catsテーブルへのアクセスをまとめたクラス
class FirestoreHelper {
  // DbHelperをinstance化する
  static final FirestoreHelper instance = FirestoreHelper._createInstance();

  FirestoreHelper._createInstance();

  // catsテーブルのデータを全件取得する
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

// _idをキーにして1件のデータを読み込む
  catData(String userId, String name) async {     // catsのキーはnameに変更している
    final db = FirebaseFirestore.instance;
    final docRef = db
        .collection("users")
        .doc(userId)
        .collection("cats")
        .doc(name)
        .withConverter(
          fromFirestore: Cats.fromFirestore,
          toFirestore: (Cats cats, _) => cats.toFirestore(),
        );
    final catdata = await docRef.get();
    final cat = catdata.data();
    return cat;
  }

// データをinsertする
  Future insert(Cats cats, String userId) async {  // updateも同じ処理で行うことができるので、共用している
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

// データを削除する
  Future delete(String userId, String name) {
    final db = FirebaseFirestore.instance;
    return db
        .collection("users")
        .doc(userId)
        .collection("cats")
        .doc(name)
        .delete();
  }
}