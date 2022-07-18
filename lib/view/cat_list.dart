import 'package:flutter/material.dart';
import 'package:apricotcomicdemo/model/cats.dart';
import 'package:apricotcomicdemo/model/db_helper.dart';
import 'package:apricotcomicdemo/view/cat_detail.dart';
import 'package:apricotcomicdemo/view/cat_detail_edit.dart';

// catテーブルの内容全件を一覧表示するクラス
class CatList extends StatefulWidget {
  const CatList({Key? key}) : super(key: key);

  @override
  _CatListPageState createState() => _CatListPageState();
}

class _CatListPageState extends State<CatList> {
  List<Cats> catList = [];  //catsテーブルの全件を保有する
  bool isLoading = false;   //テーブル読み込み中の状態を保有する

// Stateのサブクラスを作成し、initStateをオーバーライドすると、wedgit作成時に処理を動かすことができる。
// ここでは、初期処理としてCatsの全データを取得する。
  @override
  void initState() {
    super.initState();
    getCatsList();
  }

// initStateで動かす処理。
// catsテーブルに登録されている全データを取ってくる
  Future getCatsList() async {
    setState(() => isLoading = true);                   //テーブル読み込み前に「読み込み中」の状態にする
    catList = await DbHelper.instance.selectAllCats();  //catsテーブルを全件読み込む
    setState(() => isLoading = false);                  //「読み込み済」の状態にする
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('猫一覧')),
      body: isLoading                               //「読み込み中」だったら「グルグル」が表示される
          ? const Center(
              child: CircularProgressIndicator(),   // これが「グルグル」の処理
            )
          : SizedBox(
              child: ListView.builder(              // 取得したcatsテーブル全件をリスト表示する
                itemCount: catList.length,          // 取得したデータの件数を取得
                itemBuilder: (BuildContext context, int index) {
                  final cat = catList[index];       // 1件分のデータをcatに取り出す
                  return Card(                      // ここで1件分のデータを表示
                    child: InkWell(                 // cardをtapしたときにそのcardの詳細画面に遷移させる
                      child: Padding(               // cardのpadding設定
                        padding: const EdgeInsets.all(15.0),
                          child: Row(                 // cardの中身をRowで設定
                            children: <Widget>[               // Rowの中身を設定
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
                              Text(cat.name,style: const TextStyle(fontSize: 30),),     // catのnameを表示
                            ]
                          ),
                      ),
                      onTap: () async {                     // cardをtapしたときの処理を設定
                        await Navigator.of(context).push(   // ページ遷移をNavigatorで設定
                          MaterialPageRoute(
                            builder: (context) => CatDetail(id: cat.id!),   // cardのデータの詳細を表示するcat_detail.dartへ遷移
                          ),
                        );
                        getCatsList();    // データが更新されているかもしれないので、catsテーブル全件読み直し
                      },
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(                   // ＋ボタンを下に表示する
        child: const Icon(Icons.add),                               // ボタンの形を指定
        onPressed: () async {                                       // ＋ボタンを押したときの処理を設定
          await Navigator.of(context).push(                         // ページ遷移をNavigatorで設定
            MaterialPageRoute(
              builder: (context) => const CatDetailEdit()           // 詳細更新画面（元ネタがないから新規登録）を表示するcat_detail_edit.dartへ遷移
            ),
          );
          getCatsList();                                            // 新規登録されているので、catテーブル全件読み直し
        },
      ),
    );
  }
}