import 'package:flutter/material.dart';
import 'package:inventory_management_system/Screens/add_product/product.dart';
import 'package:inventory_management_system/Screens/edit_product/edit_product.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProductDetail extends StatelessWidget {
  static String routeName = "/productsdetail";
  @override
  Widget build(BuildContext context) {
    Product lol = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  EditProduct.routeName,
                  arguments: lol,
                );
              }),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Card(
                    child: Column(
                      children: [
                        Image.network(
                          lol.image,
                          height: 200,
                        ),
                        Text(
                          lol.name,
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  Text(lol.specification),
                  Text(lol.companyName),
                  Text(lol.dateOfPurchase.toString()),
                  Text(lol.sellingDate.toString()),
                  QrImage(
                    data: lol.id,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
