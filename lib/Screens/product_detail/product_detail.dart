import 'package:flutter/material.dart';
import 'package:inventory_management_system/Screens/add_product/product.dart';
import 'package:inventory_management_system/Screens/edit_product/edit_product.dart';
import 'package:inventory_management_system/db.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProductDetail extends StatelessWidget {
  static String routeName = "/productsdetail";
  @override
  Widget build(BuildContext context) {
    DatabaseService db = DatabaseService();
    String lol = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        actions: [
          StreamBuilder(
              stream: db.getProductById(lol),
              builder: (context, AsyncSnapshot<Product> snapshot) {
                return IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        EditProduct.routeName,
                        arguments: snapshot.data,
                      );
                    });
              }),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: db.getProductById(lol),
                builder: (context, AsyncSnapshot<Product> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Card(
                          child: Column(
                            children: [
                              Image.network(
                                snapshot.data.image,
                                height: 200,
                                width: double.infinity,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Name of the product - ${snapshot.data.name}",
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          "Specification - ${snapshot.data.specification}",
                          style: TextStyle(fontSize: 15),
                        ),
                        // Text(snapshot.data.companyName),
                        // Text(snapshot.data.dateOfPurchase.toString()),
                        // Text(snapshot.data.sellingDate.toString()),
                        QrImage(
                          data: snapshot.data.id,
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                      ],
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
