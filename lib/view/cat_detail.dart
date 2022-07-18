import 'package:flutter/material.dart';
import 'package:apricotcomicdemo/model/cats.dart';
import 'package:apricotcomicdemo/model/db_helper.dart';
import 'package:apricotcomicdemo/view/cat_detail_edit.dart';

// catsテーブルの中の1件のデータに対する操作を行うクラス
class CatDetail extends StatefulWidget {
  final int id;

  const CatDetail({Key? key, required this.id}) : super(key: key);

  @override
  _CatDetailState createState() => _CatDetailState();
}

class _CatDetailState extends State<CatDetail> {
  late Cats cats;
  bool isLoading = false;
  static const int textExpandedFlex = 1; // 見出しのexpaded flexの比率
  static const int dataExpandedFlex = 4; // 項目のexpanede flexの比率


// Stateのサブクラスを作成し、initStateをオーバーライドすると、wedgit作成時に処理を動かすことができる。
// ここでは、渡されたidをキーとしてcatsテーブルからデータを取得する
  @override
  void initState() {
    super.initState();
    catData();
  }

// initStateで動かす処理
// catsテーブルから指定されたidのデータを1件取得する
  Future catData() async {
    setState(() => isLoading = true);
    cats = await DbHelper.instance.catData(widget.id);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('猫詳細'),
        actions: [
          IconButton(
            onPressed: () async {                          // 鉛筆のアイコンが押されたときの処理を設定
              await Navigator.of(context).push(            // ページ遷移をNavigatorで設定
                MaterialPageRoute(
                  builder: (context) => CatDetailEdit(    // 詳細更新画面を表示する
                    cats: cats,
                  ),
                ),
              );
              catData();                                  // 更新後のデータを読み込む
            },
            icon: const Icon(Icons.edit),                 // 鉛筆マークのアイコンを表示
          ),
          IconButton(
            onPressed: () async {                         // ゴミ箱のアイコンが押されたときの処理を設定
              await DbHelper.instance.delete(widget.id);  // 指定されたidのデータを削除する
              Navigator.of(context).pop();                // 削除後に前の画面に戻る
            },
            icon: const Icon(Icons.delete),               // ゴミ箱マークのアイコンを表示
          )
        ],
      ),
      body: isLoading                                     //「読み込み中」だったら「グルグル」が表示される
          ? const Center(
              child: CircularProgressIndicator(),         // これが「グルグル」の処理
            )
          : Column(
              children :[
                Container(                      // アイコンを表示
                  width: 80,height: 80,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,     // 丸にする
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/icon/dora.png')
                    )
                  )
                ),
                  Column(                                             // 縦並びで項目を表示
                    crossAxisAlignment: CrossAxisAlignment.stretch,   // 子要素の高さを合わせる
                    children: [
                      Row(children: [
                        const Expanded(                               // 見出しの設定
                          flex: textExpandedFlex,
                          child: Text('名前',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: dataExpandedFlex,
                          child: Container(                           // catsテーブルのnameの表示を設定
                            padding: const EdgeInsets.all(5.0),
                            child: Text(cats.name),
                          ),
                        ),
                      ],),
                      Row(children: [
                        const Expanded(                              // 見出しの設定（性別)
                          flex: textExpandedFlex,
                          child: Text('性別',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: dataExpandedFlex,
                          child: Container(                          // catsテーブルのgenderの表示を設定
                            padding: const EdgeInsets.all(5.0),
                            child: Text(cats.gender),
                          ),
                        ),
                      ],),
                      Row(children: [
                        const Expanded(           // 「誕生日」の見出し行の設定
                          flex: textExpandedFlex,
                          child: Text('誕生日',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: dataExpandedFlex,
                          child: Container(                                      // catsテーブルのbirthdayの表示を設定
                            padding: const EdgeInsets.all(5.0),
                            child: Text(cats.birthday),
                          ),
                        )
                      ],),
                      Row(children: [
                        const Expanded(     // 「メモ」の見出し行の設定
                          flex: textExpandedFlex,
                          child: Text('メモ',
                            textAlign: TextAlign.center,
                          )
                        ),
                        Expanded(
                          flex: dataExpandedFlex,
                          child: Container(                                      // catsテーブルのmemoの表示を設定
                            padding: const EdgeInsets.all(5.0),
                            child: Text(cats.memo),
                          ),
                        ),
                      ],),
                    ],
                  ),
              ],
          )
    );
  }
}