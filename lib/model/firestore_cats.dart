import 'package:cloud_firestore/cloud_firestore.dart';

// catsテーブルの定義
class Cats {
  String id;
  String name;
  String gender;
  String birthday;
  String memo;
  DateTime? createdAt;

  Cats({
    required this.id,
    required this.name,
    required this.gender,
    required this.birthday,
    required this.memo,
    required this.createdAt,
  });

  factory Cats.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Cats(
        id: data?['id'],
        name: data?['name'],
        gender: data?['gender'],
        birthday: data?['birthday'],
        memo: data?['memo'],
        createdAt: data?['createdAt'].toDate());
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "name": name,
      "gender": gender,
      "birthday": birthday,
      "memo": memo,
      "createdAt": createdAt,
    };
  }
}
