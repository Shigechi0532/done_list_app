import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'できたことノート',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const DoneListPage(),
    );
  }
}

class DoneListPage extends StatefulWidget {
  const DoneListPage({super.key});

  @override
  State<DoneListPage> createState() => _DoneListPageState();
}

class _DoneListPageState extends State<DoneListPage> {
  List<String> doneList = [];

  @override
  void initState() {
    super.initState();
    _loadDoneList();
  }

  // データを読み込む
  Future<void> _loadDoneList() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      doneList = prefs.getStringList('doneList') ?? [];
    });
  }

  // データを保存する
  Future<void> _saveDoneList() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('doneList', doneList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('できたことノート')),
      body: ListView.builder(
        itemCount: doneList.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(doneList[index]));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // ダイアログを表示して入力を待つ
          final newListText = await showDialog<String>(
            context: context,
            builder: (context) {
              String inputText = '';
              return AlertDialog(
                title: const Text('できたことを追加'),
                content: TextField(
                  onChanged: (value) {
                    inputText = value;
                  },
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('キャンセル'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, inputText),
                    child: const Text('追加'),
                  ),
                ],
              );
            },
          );

          // 入力があればリストに追加
          if (newListText != null && newListText.isNotEmpty) {
            setState(() {
              doneList.add(newListText);
            });
            _saveDoneList();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
