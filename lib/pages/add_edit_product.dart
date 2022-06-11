import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:sqflite_crudapp/models/products_model.dart';
import 'package:sqflite_crudapp/services/db_services.dart';

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
  late DBService dbService;

  @override
  void initState() {
    super.initState();
    dbService = DBService();
    model = ProductModel(productName: "", categoryId: -1);

    if (widget.isEditMode) {
      model = widget.model!;
    }

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
      bottomNavigationBar: SizedBox(
        height: 110,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FormHelper.submitButton(
              "Save",
              () {
                if (validateAndSave()) {
                  if (widget.isEditMode) {
                    dbService.updateProduct(model).then(
                      (value) {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          "SQFLITE",
                          "Data Modified Successfully",
                          "OK",
                          () {
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  } else {
                    dbService.addProduct(model).then(
                      (value) {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          "SQFLITE",
                          "Data Added Successfully",
                          "OK",
                          () {
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  }
                }
              },
              borderRadius: 10,
              btnColor: Colors.green,
              borderColor: Colors.greenAccent,
            ),
            FormHelper.submitButton(
              "Cancel",
              () {},
              borderRadius: 10,
              btnColor: Colors.red,
              borderColor: Colors.redAccent,
            ),
          ],
        ),
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
                    (onChanged) {
                      model.categoryId = int.parse(onChanged);
                    },
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
          ),
          const SizedBox(
            height: 10,
          ),
          FormHelper.inputFieldWidgetWithLabel(
            context,
            "productDesc",
            "Product Description",
            "",
            (onValidate) {
              if (onValidate.isEmpty) {
                return "* Required";
              }
              return null;
            },
            (onSaved) {
              model.productDesc = onSaved.toString().trim();
            },
            initialValue: model.productDesc ?? "",
            borderRadius: 10,
            contentPadding: 15,
            fontSize: 14,
            paddingLeft: 0,
            paddingRight: 0,
            prefixIconPaddingLeft: 10,
            isMultiline: true,
            multilineRows: 5,
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
