import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:terefbooking/data/constants.dart';
import 'package:terefbooking/presentation/screens/productDetailsScreen.dart';

class ProductsScreen extends StatelessWidget {
  final products;
  final turfId;

  const ProductsScreen({super.key, required this.products,required this.turfId});
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Products for Rent',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: appthemeColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 35,
              child: CupertinoSearchTextField(),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  childAspectRatio: 0.8,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctxt) =>
                                  ProductDetailsScreen(product: product,turfid:turfId ,)));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Image Placeholder
                            Expanded(
                              child: Container(
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        '$baseUrl/${product['image']}',
                                      ),
                                      fit: BoxFit.fill),
                                  color: Colors.green.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.green),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Product Name
                            Text(
                              product['productname'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Row(
                              children: [
                                Text('Size: '),
                                Text(
                                  product['category'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 3),
                            // Product Rent
                            Text(
                              '₹${product['price']} / day',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(height: 8),
                           
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
