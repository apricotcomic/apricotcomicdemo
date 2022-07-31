import 'package:flutter/material.dart';
import 'package:apricotcomicdemo/model/firestore_cats.dart';
import 'package:apricotcomicdemo/model/db_helper.dart';
import 'package:apricotcomicdemo/model/firestore_helper.dart';

class CatDetailEdit extends StatefulWidget {
  final Cats? cats;

  const CatDetailEdit({Key? key, this.cats}) : super(key: key);

  @override
  _CatDetailEditState createState() => _CatDetailEditState();
}

class _CatDetailEditState extends State<CatDetailEdit> {
  late String id;
  late String name;
  late String birthday;
  late String gender;
  late String memo;
  late DateTime createdAt;
  final List<String> _list = <String>['男の子', '女の子', '不明']; // 性別のDropdownの項目を設定
  late String _selected; // Dropdownの選択値を格納するエリア
  String value = '不明'; // Dropdownの初期値
  static const int textExpandedFlex = 1; // 見出しのexpaded flexの比率
  static const int dataExpandedFlex = 4; // 項目のexpanede flexの比率

// Stateのサブクラスを作成し、initStateをオーバーライドすると、wedgit作成時に処理を動かすことができる。
// ここでは、各項目の初期値を設定する
  @override
  void initState() {
    super.initState();
    id = widget.cats?.id ?? '';
    name = widget.cats?.name ?? '';
    birthday = widget.cats?.birthday ?? '';
    gender = widget.cats?.gender ?? '';
    _selected = widget.cats?.gender ?? '不明';
    memo = widget.cats?.memo ?? '';
    createdAt = widget.cats?.createdAt ?? DateTime.now();
  }

// Dropdownの値の変更を行う
  void _onChanged(String? value) {
    setState(() {
      _selected = value!;
      gender = _selected;
    });
  }

// 詳細編集画面を表示する
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('猫編集'),
        actions: [
          buildSaveButton(), // 保存ボタンを表示する
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Row(children: [
            // 名前の行の設定
            const Expanded(
              // 見出し（名前）
              flex: textExpandedFlex,
              child: Text(
                '名前',
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              // 名前入力エリアの設定
              flex: dataExpandedFlex,
              child: TextFormField(
                maxLines: 1,
                initialValue: name,
                decoration: const InputDecoration(
                  hintText: '名前を入力してください',
                ),
                validator: (name) => name != null && name.isEmpty
                    ? '名前は必ず入れてね'
                    : null, // validateを設定
                onChanged: (name) => setState(() => this.name = name),
              ),
            ),
          ]),
          // 性別の行の設定
          Row(children: [
            const Expanded(
              // 見出し（性別）
              flex: textExpandedFlex,
              child: Text(
                '性別',
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              // 性別をドロップダウンで設定
              flex: dataExpandedFlex,
              child: DropdownButton(
                items: _list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                value: _selected,
                onChanged: _onChanged,
              ),
            ),
          ]),
          Row(children: [
            const Expanded(
              // 見出し（誕生日）
              flex: textExpandedFlex,
              child: Text(
                '誕生日',
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              // 誕生日入力エリアの設定
              flex: dataExpandedFlex,
              child: TextFormField(
                maxLines: 1,
                initialValue: birthday,
                decoration: const InputDecoration(
                  hintText: '誕生日を入力してください',
                ),
                onChanged: (birthday) =>
                    setState(() => this.birthday = birthday),
              ),
            ),
          ]),
          Row(children: [
            const Expanded(
                // 見出し（メモ）
                flex: textExpandedFlex,
                child: Text(
                  'メモ',
                  textAlign: TextAlign.center,
                )),
            Expanded(
              // メモ入力エリアの設定
              flex: dataExpandedFlex,
              child: TextFormField(
                maxLines: 1,
                initialValue: memo,
                decoration: const InputDecoration(
                  hintText: 'メモを入力してください',
                ),
                onChanged: (memo) => setState(() => this.memo = memo),
              ),
            ),
          ]),
        ]),
      ),
    );
  }

// 保存ボタンの設定
  Widget buildSaveButton() {
    final isFormValid = name.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        child: const Text('保存'),
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? Colors.redAccent : Colors.grey.shade700,
        ),
        onPressed: createOrUpdateCat, // 保存ボタンを押したら実行する処理を指定する
      ),
    );
  }

// 保存ボタンを押したとき実行する処理
  void createOrUpdateCat() async {
    final isUpdate = (widget.cats != null); // 画面が空でなかったら

    if (isUpdate) {
      await updateCat(); // updateの処理
    } else {
      await createCat(); // insertの処理
    }

    Navigator.of(context).pop(); // 前の画面に戻る
  }

  // 更新処理の呼び出し
  Future updateCat() async {
    final cat = Cats(
      // 画面の内容をcatにセット
      id: id,
      name: name,
      birthday: birthday,
      gender: gender,
      memo: memo, createdAt: null,
    );

    await FirestoreHelper.instance.insert(cat, "1"); // catの内容で更新する
  }

  // 追加処理の呼び出し
  Future createCat() async {
    final cat = Cats(
      // 入力された内容をcatにセット
      id: id,
      name: name,
      birthday: birthday,
      gender: gender,
      memo: memo,
      createdAt: createdAt,
    );
    await FirestoreHelper.instance.insert(cat, "1"); // catの内容で追加する
  }
}
