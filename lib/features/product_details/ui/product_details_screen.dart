import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product =
        ModalRoute.of(context)!.settings.arguments as QueryDocumentSnapshot;
    return Scaffold(
      appBar: AppBar(
        title: Text(product["product_name"]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://hinacreates.com/wp-content/uploads/2021/06/dummy2.png',
                  height: 150,
                  width: 250,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              product["product_name"],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Price : \$ ${product["price"]}",
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Measurement : ${product["measurement"]}",
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 55,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  color: Colors.black12,
                  child: QrImageView(
                    data: product["product_name"],
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                  // child: , //Generated QR image
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
