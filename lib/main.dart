import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'できたことノート',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('できたことノート'),
      ),
      body: ListView.builder(
        itemCount: doneList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(doneList[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState((){
            doneList.add('新しいできたこと');
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}