import 'package:flutter/material.dart';
import 'package:terefbooking/data/constants.dart';
import 'package:terefbooking/services/bookingHistoryApi.dart';
import 'package:terefbooking/services/cancelBooking.dart';

class BookingHistoryScreen extends StatelessWidget {
  BookingHistoryScreen({super.key, required this.bookingHistory});
  final bookingHistory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Booking History',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: appthemeColor,
      ),
      body: bookingHistory.isEmpty
          ? const Center(
              child: Text(
                'No bookings found.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: bookingHistory.length,
              itemBuilder: (context, index) {
                final booking = bookingHistory[index];
                return BookingCard(
                  status: booking['status'],
                  id: booking['booking_id'],
                  amount: booking['amount'],
                  turfName: booking['turf_name'] ?? "",
                  imageUrl: booking['turf_image'] ??
                      "https://tse2.mm.bing.net/th?id=OIP.iPoDbwGmgx9DxrnHDHJiRwHaHa&pid=Api&P=0&h=180",
                  date: booking['booking_date'] ?? "",
                  time: booking['slot_time'] ?? "",
                );
              },
            ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final status;
  final String turfName;
  final String imageUrl;
  final String date;
  final String time;
  final amount;
  final id;

  const BookingCard({
    super.key,
    required this.turfName,
    required this.imageUrl,
    required this.date,
    required this.time,
    required this.amount,
    required this.id,
    required this.status,
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
                      Text(time),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹ ${amount}',
                        style: TextStyle(color: Colors.green),
                      ),
                      if (status != 'CANCELED')
                        TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: Text('Are you sure to want delete?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Cancel')),
                                  TextButton(
                                      onPressed: () async {
                                        await cancelBooking(id: id);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        List<Map<String, dynamic>> data =
                                            await getBookingHistory();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BookingHistoryScreen(
                                                      bookingHistory: data)),
                                        );
                                      },
                                      child: Text('OK'))
                                ],
                              ),
                            );
                          },
                          child: Text(
                            'Cancel Booking',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      if (status == 'CANCELED')
                        Text(
                          'CANCELED',
                          style: TextStyle(color: Colors.grey),
                        )
                    ],
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
