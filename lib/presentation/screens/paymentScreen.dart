import 'package:flutter/material.dart';
import 'package:terefbooking/data/constants.dart';
import 'package:terefbooking/presentation/screens/bottomnavbar.dart';
import 'package:terefbooking/presentation/screens/homeScreen.dart';
import 'package:terefbooking/services/bookTurf.dart';
import 'package:terefbooking/services/getTurfsApi.dart';
import 'package:terefbooking/services/rentProduct.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen(
      {super.key,
      required this.rent,
      required this.turfId,
      required this.date,
      required this.slotId,
      required this.isProduct});
  final bool isProduct;
  final rent;
  final turfId;

  final date;
  final slotId;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // Selected payment method index
  int _selectedPaymentIndex = 0;

  // Payment methods
  final List<Map<String, dynamic>> _paymentOptions = [
    {'method': 'UPI', 'icon': Icons.phone_android, 'color': Colors.purple},
    {'method': 'Debit Card', 'icon': Icons.credit_card, 'color': Colors.blue},
    {'method': 'Credit Card', 'icon': Icons.payment, 'color': Colors.green},
    {
      'method': 'Pay at Location',
      'icon': Icons.location_on,
      'color': Colors.orange
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Payment',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: appthemeColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display Amount with Decoration
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Total Amount',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '₹${widget.rent.toString()}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),

            const Text(
              'Select Payment Method',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Payment Options with Radio Buttons
            Expanded(
              child: ListView.builder(
                itemCount: _paymentOptions.length,
                itemBuilder: (context, index) {
                  final option = _paymentOptions[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Icon(option['icon'], color: option['color']),
                      title: Text(
                        option['method'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Radio<int>(
                        value: index,
                        groupValue: _selectedPaymentIndex,
                        onChanged: (value) {
                          setState(() {
                            _selectedPaymentIndex = value!;
                          });
                        },
                        activeColor: option['color'],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: appthemeColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  if (widget.isProduct) {
                    bool isok = await rentProduct(data: {
                      'user': loginId,
                      'product': widget.slotId,
                      'turf': widget.turfId,
                      'booking_date':
                          DateTime.now().toString().substring(0, 10),
                      'amount': widget.rent
                    });

                    //
                    if (isok)
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            icon: Icon(
                              Icons.check_circle_outlined,
                              size: 60,
                              color: Colors.green,
                            ),
                            title: const Text('Payment Successful'),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  // Navigate to Home Screen
                                  // List<Map<String, dynamic>> turfdata =
                                  //     await getTurfs();
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (ctxt) => BottomNavScreen(
                                              // turfs: turfdata,
                                            )),
                                    (route) => false,
                                  );
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    //
                  } else {
                    bool isBooked = await bookTurf(
                      turfId: widget.turfId,
                      userId: loginId!,
                      amount: widget.rent,
                      date: widget.date,
                      context: context,
                      slotid: widget.slotId,
                    );

                    // Show Success Dialog
                    if (isBooked)
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            icon: Icon(
                              Icons.check_circle_outlined,
                              size: 60,
                              color: Colors.green,
                            ),
                            title: const Text('Payment Successful'),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  // Navigate to Home Screen
                                  // List<Map<String, dynamic>> turfdata =
                                  //     await getTurfs();
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (ctxt) => BottomNavScreen(
                                              // turfs: turfdata,
                                            )),
                                    (route) => false,
                                  );
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                  }
                },
                child: const Text(
                  'Submit Payment',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
