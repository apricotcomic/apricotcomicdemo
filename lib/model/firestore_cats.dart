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
      gender: data?['birthday'],
      birthday: data?['birthday'],
      memo: data?['memo'],
      createdAt: data?['createdAt']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      if (name != null) "name": name,
      if (gender != null) "gender": gender,
      if (birthday != null) "birthday": birthday,
      if (memo != null) "memo": memo,
      if (createdAt != null) "createdAt": createdAt,
    };
  }
}