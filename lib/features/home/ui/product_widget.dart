import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key, this.onTap, required this.doc});
  final void Function()? onTap;
  final QueryDocumentSnapshot<Map<String, dynamic>>? doc;

  @override
  Widget build(BuildContext context) {
    return 
    InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.amber.shade200,
            borderRadius: BorderRadius.circular(13)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://hinacreates.com/wp-content/uploads/2021/06/dummy2.png',
                  height: 100,
                  width: 130,
                  fit: BoxFit.cover,
                ),
                // Icon(
                //   Icons.shop,
                //   size: 100,
                // ),
              ],
            ),
            Text(
              doc?["product_name"]??'',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "Price : \$ ${doc?["price"]??''}",
              style: const TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
            ),
            Text(
              "Measurement : ${doc?["measurement"]??''}",
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  
  }
}
