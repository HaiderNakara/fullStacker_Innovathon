import 'package:flutter/material.dart';
import 'package:inventory_management_system/Screens/add_category/category.dart';
import 'package:inventory_management_system/Screens/add_product/product.dart';
import 'package:inventory_management_system/Screens/product_detail/product_detail.dart';
import 'package:inventory_management_system/db.dart';

class CategoryList extends StatelessWidget {
  static String routeName = "/CategoryList";

  DatabaseService db = DatabaseService();
  @override
  Widget build(BuildContext context) {
    Category lol = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
            stream: db.getProductStream(lol.name),
            builder: (context, AsyncSnapshot<List<Product>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, ProductDetail.routeName,
                            arguments: snapshot.data[index]);
                      },
                      leading: Image.network(snapshot.data[index].image),
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
