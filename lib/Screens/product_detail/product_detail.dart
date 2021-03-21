import 'package:flutter/material.dart';
import 'package:inventory_management_system/Screens/add_product/product.dart';

class ProductDetail extends StatelessWidget {
  static String routeName = "/productdetail";
  @override
  Widget build(BuildContext context) {
    Product lol = ModalRoute.of(context).settings.arguments;
    return Scaffold(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
