import 'package:flutter/material.dart';
import 'package:inventory_management_system/Screens/add_category/add_category.dart';
import 'package:inventory_management_system/Screens/add_category/category.dart';
import 'package:inventory_management_system/Screens/add_product/add_product.dart';
import 'package:inventory_management_system/db.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/homeScreen";
  DatabaseService db = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Upload"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AddCategory.routeName,
                              );
                            },
                            child: Text("Add category"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AddProduct.routeName);
                            },
                            child: Text("Add product"),
                          ),
                        ],
                      );
                    });
              })
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
            stream: db.getCategoryStream(),
            builder: (context, AsyncSnapshot<List<Category>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data[index].name),
                    );
                  },
                );
              }
              return SizedBox.shrink();
            },
          ))
        ],
      ),
    );
  }
}
