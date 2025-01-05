import 'package:flutter/material.dart';
import 'package:terefbooking/data/constants.dart';
import 'package:terefbooking/presentation/screens/paymentScreen.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> product;
  final turfid;

  const ProductDetailsScreen({super.key, required this.product,required this.turfid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product['productname'],
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: appthemeColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        '$baseUrl/${product['image']}',
                      ),
                      fit: BoxFit.fill),
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green),
                ),
              ),
              const SizedBox(height: 16),
              // Product Name
              Text(
                product['productname'],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // Product Rent
              Text(
                'Rent: ₹${product['price']} / day',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text('Size: '),
                  Text(
                    product['category'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Product Details
              Text(
                product['description'],
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

              // Size Options
              // Text(
              //   'Size:',
              //   style: const TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // const SizedBox(height: 8),
              // Wrap(
              //   spacing: 8,
              //   children: ['S', 'M', 'L', 'XL', 'XXL']
              //       .map(
              //         (size) => ChoiceChip(
              //           label: Text(size),
              //           selected: false,
              //           onSelected: (selected) {
              //             // Handle size selection
              //           },
              //         ),
              //       )
              //       .toList(),
              // ),
              const SizedBox(height: 24),
              // Button to Navigate to Payment Screen
              if (product['availablequantity'] == '0')
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Out of Stock!',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              if (product['availablequantity'] == '0')
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.grey,
                      backgroundColor: Colors.grey[300],
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 16,
                      ),
                    ),
                    onPressed: () {
                      // Navigate to Payment Screen
                    },
                    child: const Text(
                      'Proceed to Payment',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              if (product['availablequantity'] != '0')
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 16,
                      ),
                    ),
                    onPressed: () {
                      // Navigate to Payment Screen
                      Navigator.push(context,
                          MaterialPageRoute(builder: (ctxt) => PaymentScreen(rent:product['price'] ,date:'' ,isProduct:true ,slotId: product['id'],turfId:turfid ,)));
                    },
                    child: const Text(
                      'Proceed to Payment',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
