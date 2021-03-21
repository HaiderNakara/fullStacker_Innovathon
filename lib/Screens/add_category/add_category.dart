import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventory_management_system/Screens/Home/home_screen.dart';
import 'package:inventory_management_system/Screens/add_category/category.dart';
import 'package:inventory_management_system/db.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class AddCategory extends StatefulWidget {
  static String routeName = "/AddSCategory";

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final ImagePicker _imagePicker = ImagePicker();
  String description;
  String name;
  File _image;
  var url;
  final _formKey = GlobalKey<FormState>();
  var uuid = Uuid();

  Future<void> _pickImage(ImageSource source) async {
    PickedFile selected = await _imagePicker.getImage(source: source);
    setState(() {
      if (selected != null) {
        _image = File(selected.path);
      }
    });
  }

  uploadImage(var image) async {
    if (image != null) {
      final ref = FirebaseStorage.instance.ref().child("lol");
      await ref.putFile(image);
      return await ref.getDownloadURL();
      // await FirebaseFirestore.instance.collection("$subject").add({
      //   "image": url,
      //   "id": "image",
      // });
      // Navigator.pop(context);
    }
  }

  DatabaseService db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _image == null
                  ? TextButton(
                      onPressed: () {
                        _pickImage(ImageSource.gallery);
                      },
                      child: Text("select image"),
                    )
                  : Image.file(
                      _image,
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
                  labelText: "Description",
                  hintText: "Enter your Description",
                  hintMaxLines: 3,
                ),
                onChanged: (value) {
                  setState(() => description = value);
                },
                validator: (value) =>
                    value.length > 10 ? null : "Enter a valid Description",
                maxLines: 3,
              ),
              TextButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      url = await uploadImage(_image);
                      if (url != null) {
                        var map = Category(
                                name: name,
                                description: description,
                                image: url,
                                id: uuid.v4())
                            .toJson();

                        await db.addCategory(map).then((value) =>
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
