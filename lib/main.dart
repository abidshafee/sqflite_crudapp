import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
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

class TextFieldItems {
  final int? id;
  final String name;
  final String address;

  TextFieldItems({this.id, required this.name, required this.address});

  factory TextFieldItems.fromMap(Map<String, dynamic> json) =>
      new TextFieldItems(
          id: json['id'], name: json['name'], address: json['address']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
    };
  }
}

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Dictionary documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'peoples.db'),
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }
}
