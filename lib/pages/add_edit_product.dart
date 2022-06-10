import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:sqflite_crudapp/models/products_model.dart';

class AddEditProductPage extends StatefulWidget {
  const AddEditProductPage({Key? key, this.model, this.isEditMode = false})
      : super(key: key);
  final ProductModel? model;
  final bool isEditMode;

  @override
  State<AddEditProductPage> createState() => _AddEditProductPageState();
}

class _AddEditProductPageState extends State<AddEditProductPage> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late ProductModel model;
  List<dynamic> categories = [];

  @override
  void initState() {
    super.initState();
    model = ProductModel(productName: "", categoryId: -1);

    categories.add({"id": "1", "name": "T-Shirt"});
    categories.add({"id": "2", "name": "Shirt"});
    categories.add({"id": "3", "name": "Jeans"});
    categories.add({"id": "4", "name": "Trouser"});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        automaticallyImplyLeading: true,
        title: Text(widget.isEditMode ? 'Edit Product' : 'Add Product'),
      ),
      body: Form(
        key: globalKey,
        child: _formUI(),
      ),
    );
  }

  _formUI() {
    return SingleChildScrollView(
      child: Column(
        children: [
          FormHelper.inputFieldWidgetWithLabel(
            context,
            "productName",
            "Product Name",
            "",
            (onValidate) {
              if (onValidate.isEmpty) {
                return "* Required";
              }
              return null;
            },
            (onSaved) {
              model.productName = onSaved.toString().trim();
            },
            initialValue: model.productName,
            showPrefixIcon: true,
            prefixIcon: const Icon(Icons.text_fields),
            borderRadius: 10,
            contentPadding: 15,
            fontSize: 14,
            paddingLeft: 0,
            paddingRight: 0,
            prefixIconPaddingLeft: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Flexible(
                flex: 1,
                child: FormHelper.inputFieldWidgetWithLabel(
                  context,
                  "productPrice",
                  "Product Price",
                  "",
                  (onValidate) {
                    if (onValidate.isEmpty) {
                      return "* Required";
                    }
                    return null;
                  },
                  (onSaved) {
                    model.price = double.parse(onSaved.trim());
                  },
                  initialValue: model.productName,
                  showPrefixIcon: true,
                  prefixIcon: const Icon(Icons.currency_bitcoin),
                  borderRadius: 10,
                  contentPadding: 15,
                  fontSize: 14,
                  paddingLeft: 0,
                  paddingRight: 0,
                  prefixIconPaddingLeft: 10,
                  isNumeric: true,
                ),
              ),
              Flexible(
                  flex: 1,
                  child: FormHelper.dropDownWidgetWithLabel(
                    context,
                    "Product Category",
                    "--Select Category--",
                    model.categoryId,
                    categories,
                    (onChanged) {},
                    (onValidate) {},
                    borderRadius: 10,
                    labelFontSize: 14,
                    paddingLeft: 0,
                    paddingRight: 0,
                    hintFontSize: 14,
                    prefixIcon: const Icon(Icons.category),
                    showPrefixIcon: true,
                    prefixIconPaddingLeft: 10,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
