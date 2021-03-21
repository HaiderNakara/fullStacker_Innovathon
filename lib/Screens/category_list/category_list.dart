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
      appBar: AppBar(),
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
                    return Dismissible(
                      onDismissed: (value) =>
                          db.deleteProduct(snapshot.data[index].id),
                      background: Container(
                        child: Icon(Icons.delete),
                        color: Theme.of(context).primaryColor,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(
                          right: 20,
                        ),
                      ),
                      key: ValueKey(snapshot.data[index].id),
                      direction: DismissDirection.endToStart,
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, ProductDetail.routeName,
                              arguments: snapshot.data[index].id);
                        },
                        leading: Image.network(snapshot.data[index].image),
                        title: Text(snapshot.data[index].name),
                      ),
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
