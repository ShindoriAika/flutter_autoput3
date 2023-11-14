import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: const FirstScreen(),);
  }
}

class FirstScreen extends StatelessWidget {
  static List<BookItem> bookList = [
    BookItem('浮雲', '二葉亭四迷', true),
    BookItem('舞姫', '森鴎外', true),
    BookItem('五重塔', '幸田露伴', true),
    BookItem('たけくらべ', '樋口一葉', true),
    BookItem('若菜集', '島崎藤村', true),
    BookItem('歌よみに与ふる書', '正岡子規', true),
    BookItem('みだれ髪', '与謝野晶子', true),
    BookItem('我が輩は猫である', '夏目漱石', true)
  ];
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('アウトプット3'),
      ),
      body: ListView.builder(
        itemCount: bookList.length, //一覧の行数を指定
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text('${index+1}'),
            title: Text(bookList[index].title),
            subtitle: Text(bookList[index].author),
            trailing: Visibility(
              visible: bookList[index].purchase,
              child:ElevatedButton(
                child: const Text('購入'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:(context) => SecondScreen(index, bookList[index].title, bookList[index].author)
                    )
                  );
                },
              )
            )
          );
        },
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  final int _no;
  final String _title;
  final String _author;

  const SecondScreen(this._no, this._title, this._author, {super.key});

  void purchase(no){
    FirstScreen.bookList[no].purchase = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('アウトプット3'),
      ),
      body: Container(
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.all(0),
        width: double.infinity,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20.0),
              width: double.infinity,
              child: Text(
                '${_title}（${_author}）',
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20.0, top: 0, right: 20.0, bottom: 0),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 0, top: 0, right: 5.0, bottom: 0),
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      child: const Text('キャンセル'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5.0, top: 0, right: 0, bottom: 0),
                    child: ElevatedButton(
                      onPressed: (){
                        purchase(_no);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder:(context) => FirstScreen()
                            )
                        );
                      },
                      child: const Text('購入'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}

class BookItem {
  String title;
  String author;
  bool purchase;
  BookItem(this.title, this.author, this.purchase);
}