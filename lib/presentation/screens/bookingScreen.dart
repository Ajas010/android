import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:terefbooking/data/constants.dart';
import 'package:terefbooking/presentation/screens/paymentScreen.dart';
import 'package:terefbooking/services/getSlotsApi.dart';

class BookNowScreen extends StatefulWidget {
  const BookNowScreen({super.key, required this.turfId});
  final turfId;

  @override
  State<BookNowScreen> createState() => _BookNowScreenState();
}

class _BookNowScreenState extends State<BookNowScreen> {
  DateTime? selectedDate;
  List<Map<String, dynamic>> slots = [];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Book Now',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: appthemeColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Selector
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDate == null
                      ? 'Select a Date'
                      : DateFormat('yyyy-MM-dd').format(selectedDate!),
                  style: const TextStyle(fontSize: 18),
                ),
                ElevatedButton(
                  onPressed: () async {
                    DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) {
                      selectedDate = date;
                      slots = await getSlots(
                          turfId: widget.turfId,
                          date: selectedDate.toString().substring(0, 10));
                      setState(() {});
                    }
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: appthemeColor),
                  child: const Text(
                    'Pick Date',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Availability and Slots
            Expanded(
              child: selectedDate == null
                  ? const Center(
                      child: Text(
                        'Please select a date to check availability',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      itemCount: slots.length,
                      itemBuilder: (context, index) {
                        final slot = slots[index];
                        return GestureDetector(
                          onTap: slot['status'] == 'True'
                              ? null
                              : () {
                                  // Navigate to Payment Screen
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PaymentScreen(
                                        rent: slot['turf_rent'],
                                        turfId: widget.turfId,
                                        date: selectedDate
                                            .toString()
                                            .substring(0, 10),
                                        slotId: slot['id'],
                                        isProduct: false,
                                      ),
                                    ),
                                  );
                                },
                          child: Container(
                            width: screenWidth / 2,
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: slot['status'] == 'True'
                                  ? Colors.grey
                                  : appthemeColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  slot['timeslot'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  slot['status'] == 'True'
                                      ? 'Booked'
                                      : 'Available',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
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
