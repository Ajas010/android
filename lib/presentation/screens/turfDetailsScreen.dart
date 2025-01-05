import 'package:flutter/material.dart';
import 'package:terefbooking/data/constants.dart';
import 'package:terefbooking/presentation/screens/bookingScreen.dart';
import 'package:terefbooking/presentation/screens/productScreen.dart';
import 'package:terefbooking/services/getProductsApi.dart';

class TurfDetailsScreen extends StatelessWidget {
  final String name;
  final String place;
  final String rent;
  final String image;
  final double rating;
  final String description;
  final String openingTime;
  final String closingTime;
  final turfid;

  const TurfDetailsScreen({
    super.key,
    required this.name,
    required this.place,
    required this.rent,
    required this.image,
    required this.rating,
    required this.description,
    required this.openingTime,
    required this.closingTime,
    required this.turfid,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: appthemeColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Turf Image
            Stack(
              children: [
                Image.network(
                  image,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: Colors.black.withOpacity(0.7),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            rating.toStringAsFixed(1),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Turf Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    place,
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rent: $rent',
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Opening and Closing Time
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  Row(
                    children: [
                      const Icon(Icons.access_time, color: Colors.green),
                      const SizedBox(width: 8),
                      Text(
                        'Open: $openingTime',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.access_time, color: Colors.red),
                      const SizedBox(width: 8),
                      Text(
                        'Close: $closingTime',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  //   ],
                  // ),
                  const SizedBox(height: 16),

                  // Description
                  const Text(
                    'Description:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 24),

                  // Buttons
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctxt) => BookNowScreen(
                                      turfId: turfid,
                                    )));
                        // Navigate to booking screen
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white
                          // padding: const EdgeInsets.symmetric(
                          //     horizontal: 24, vertical: 12),
                          ),
                      child: const Text(
                        'Book Now',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        List<Map<String, dynamic>> data =
                            await getProducts(turfid);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctxt) => ProductsScreen(turfId: turfid,
                                    products:
                                        data))); // Navigate to rent equipment screen
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        // foregroundColor: Colors.white
                        // padding: const EdgeInsets.symmetric(
                        //     horizontal: 24, vertical: 12),
                      ),
                      child: const Text(
                        'Rent Equipment',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 20,
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
