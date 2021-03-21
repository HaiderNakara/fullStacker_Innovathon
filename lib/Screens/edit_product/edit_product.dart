import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventory_management_system/Screens/Home/home_screen.dart';
import 'package:inventory_management_system/Screens/add_category/category.dart';
import 'package:inventory_management_system/Screens/add_product/product.dart';
import 'package:inventory_management_system/db.dart';
import 'package:uuid/uuid.dart';

class EditProduct extends StatefulWidget {
  static String routeName = "/EditProduct";
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final ImagePicker _imagePicker = ImagePicker();

  String speccfication;

  String name;

  File _addProductImage;
  String companyName;

  var url;
  DateTime selectedPurDate = DateTime.now();
  DateTime selectedSellingDate = DateTime.now();
  String modelNumber;
  final _formKey = GlobalKey<FormState>();
  String valueCategory;
  var uuid = Uuid();

  Future<void> _pickImage(ImageSource source) async {
    PickedFile selected = await _imagePicker.getImage(source: source);
    setState(() {
      if (selected != null) {
        _addProductImage = File(selected.path);
      }
    });
  }

  uploadImage(var image) async {
    if (image != null) {
      final ref = FirebaseStorage.instance.ref().child(image.toString());
      await ref.putFile(image);
      return await ref.getDownloadURL();
      // await FirebaseFirestore.instance.collection("$subject").add({
      //   "image": url,
      //   "id": "image",
      // });
      // Navigator.pop(context);
    }
  }

  selectDateOfPurchace(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedPurDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedPurDate)
      setState(() {
        selectedPurDate = picked;
      });
  }

  selectDateOfSelling(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedSellingDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedSellingDate)
      setState(() {
        selectedPurDate = picked;
      });
  }

  DatabaseService db = DatabaseService();
  @override
  Widget build(BuildContext context) {
    Product lol = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _addProductImage == null
                  ? TextButton(
                      onPressed: () {
                        _pickImage(ImageSource.gallery);
                      },
                      child: Text("select image"),
                    )
                  : Image.file(
                      _addProductImage,
                      height: 400,
                    ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Name",
                  hintText: "Name of your product",
                ),
                onChanged: (value) {
                  setState(() => name = value);
                },
                validator: (value) =>
                    value.length > 5 ? null : "Enter a proper name",
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Specfication",
                  hintText: "Enter your Speccfication",
                  hintMaxLines: 3,
                ),
                onChanged: (value) {
                  setState(() => speccfication = value);
                },
                validator: (value) =>
                    value.length > 10 ? null : "Enter a valid Specfication",
                maxLines: 3,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Model Number",
                  hintText: "Enter Model Number",
                ),
                onChanged: (value) {
                  setState(() => modelNumber = value);
                },
                validator: (value) =>
                    value.length > 5 ? null : "Enter a valid Model Number",
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Company Name",
                  hintText: "Name of your product Company",
                ),
                onChanged: (value) {
                  setState(() => companyName = value);
                },
                validator: (value) =>
                    value.length > 5 ? null : "Enter a proper name",
              ),
              StreamBuilder(
                  stream: db.getCategoryStream(),
                  builder: (context, AsyncSnapshot<List<Category>> snapshot) {
                    if (snapshot.hasData) {
                      return DropdownButton(
                        hint: Text("Select Year"),
                        value: valueCategory,
                        onChanged: (e) {
                          setState(() {
                            valueCategory = e;
                          });
                        },
                        items: snapshot.data.map((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem.name,
                            child: Text(valueItem.name),
                          );
                        }).toList(),
                      );
                    }
                    return Text("loading");
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () => selectDateOfPurchace(context),
                      child:
                          Text("${selectedPurDate.toLocal()}".split(' ')[0])),
                  TextButton(
                      onPressed: () => selectDateOfSelling(context),
                      child: Text(
                          "${selectedSellingDate.toLocal()}".split(' ')[0])),
                ],
              ),
              TextButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      url = await uploadImage(_addProductImage);
                      if (url != null) {
                        var map = Product(
                          name: name,
                          specification: speccfication,
                          image: url,
                          dateOfPurchase: selectedPurDate.toLocal(),
                          sellingDate: selectedSellingDate.toLocal(),
                          modelNumber: modelNumber,
                          companyName: companyName,
                          category: valueCategory,
                          id: lol.id,
                        ).toJson();
                        await db.editProduct(map, lol.id).then((value) =>
                            Navigator.pushReplacementNamed(
                                context, HomeScreen.routeName));
                      }
                    }
                  },
                  child: Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
}
