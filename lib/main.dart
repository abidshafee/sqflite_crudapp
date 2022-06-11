import 'package:flutter/material.dart';
import 'package:sqflite_crudapp/pages/add_edit_product.dart';
import 'package:sqflite_crudapp/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const AddEditProductPage(),
      home: const HomePage(),
    );
  }
}
