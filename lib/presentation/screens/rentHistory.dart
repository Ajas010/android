import 'package:flutter/material.dart';
import 'package:terefbooking/data/constants.dart';

class RentHistoryScreen extends StatelessWidget {
  RentHistoryScreen({super.key, required this.bookingHistory});
  final bookingHistory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Rent History',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: appthemeColor,
      ),
      body: bookingHistory.isEmpty
          ? const Center(
              child: Text(
                'No items found.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: bookingHistory.length,
              itemBuilder: (context, index) {
                final booking = bookingHistory[index];
                return BookingCard(
                  amount: booking['amount'],
                  turfName: booking['productname'] ?? "",
                  imageUrl: booking['product_image'] ??
                      "https://tse2.mm.bing.net/th?id=OIP.iPoDbwGmgx9DxrnHDHJiRwHaHa&pid=Api&P=0&h=180",
                  date: booking['booking_date'] ?? "",
                  time: booking['isreturn'] ?? "",
                );
              },
            ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final String turfName;
  final String imageUrl;
  final String date;
  final bool time;
  final amount;

  const BookingCard({
    super.key,
    required this.turfName,
    required this.imageUrl,
    required this.date,
    required this.time,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          // Turf Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            child: Image.network(
              '$baseUrl/$imageUrl',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          // Booking Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    turfName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(date),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.access_time,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(time ? 'Retured' : 'Not returned'),
                    ],
                  ),
                  Text(
                    '₹ ${amount}',
                    style: TextStyle(color: Colors.green),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
