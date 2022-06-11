import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/list_helper.dart';
import 'package:sqflite_crudapp/models/products_model.dart';
import 'package:sqflite_crudapp/services/db_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DBService dbService = DBService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: const Text("SQFITE CRUD APP"),
      ),
      body: _fetchData(),
    );
  }

  _fetchData() {
    return FutureBuilder<List<ProductModel>>(
      future: dbService.getProducts(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductModel>> products) {
        if (products.hasData) {
          return _buildDataTable(products.data!);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  _buildDataTable(List<ProductModel> model) {
    return ListUtils.buildDataTable(
      context,
      ["Product Name", "Price", ""],
      ["productName", "price", ""],
      false,
      0,
      model,
      (ProductModel data) {},
      (ProductModel data) {},
      headingRowColor: Colors.lightGreen,
      isScrollable: true,
      columnTextFontSize: 14,
      columnTextBold: false,
      columnSpacing: 30,
      onSort: (columnIndex, columName, asc) {},
    );
  }
}
