import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

main() => runApp(SqfliteCrudApp());

class SqfliteCrudApp extends StatefulWidget {
  const SqfliteCrudApp({Key? key}) : super(key: key);

  @override
  State<SqfliteCrudApp> createState() => _SqfliteCrudAppState();
}

class _SqfliteCrudAppState extends State<SqfliteCrudApp> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Sqflite App"),
        ),
        body: const customTxtFlf(),
      ),
    );
  }
}

class customTxtFlf extends StatelessWidget {
  const customTxtFlf({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(15),
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User Name',
                hintText: 'Enter Your Name'),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(15),
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Address',
                hintText: 'Enter Your Address'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Save'),
          ),
        ),
      ],
    );
  }
}
