import 'package:flutter/material.dart';
import 'package:terefbooking/data/constants.dart';
import 'package:terefbooking/presentation/screens/auth/loginScreen.dart';
import 'package:terefbooking/presentation/screens/bookingHistory.dart';
import 'package:terefbooking/presentation/screens/rentHistory.dart';
import 'package:terefbooking/presentation/screens/viewProfile.dart';
import 'package:terefbooking/services/bookingHistoryApi.dart';
import 'package:terefbooking/services/getProfileApi.dart';
import 'package:terefbooking/services/getRentHistory.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Profile Section
          // UserAccountsDrawerHeader(

          //   accountName: Text(
          //     'username',
          //     style: const TextStyle(fontWeight: FontWeight.bold),
          //   ),
          //   accountEmail: Text('email@gmail.com'),
          // currentAccountPicture: CircleAvatar(
          //   backgroundImage: NetworkImage(
          //       'https://tse2.mm.bing.net/th?id=OIP.MNYMRopweKA9axhd73z_GwHaE8&pid=Api&P=0&h=180'),
          //   backgroundColor: Colors.grey[200],
          // ),
          //   decoration: BoxDecoration(
          //     color: Colors.green,
          //   ),
          // ),
          // Drawer Options
          SizedBox(
            height: 20,
          ),
          ListTile(
            title: Text(
              'Options',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          ListTile(
            leading: const Icon(
              Icons.account_circle_outlined,
            ),
            title: const Text('My Profile'),
            onTap: () async {
              Map<String, dynamic> profile = await getUserProfile(loginId);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProfileViewScreen(profile: profile)));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
            ),
            title: const Text('Settings'),
            onTap: () {
              // Navigator.pushNamed(context, '/settings');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.history,
            ),
            title: const Text('Rent History'),
            onTap: () async {
              // List<Map<String, dynamic>> data = await getRentHistory();

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctxt) => RentHistoryScreen(
                            // bookingHistory: data,
                          )));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.book_online,
            ),
            title: const Text('My Bookings'),
            onTap: () async {
             
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        BookingHistoryScreen()),
              );

              // Navigator.pushNamed(context, '/myBookings');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout_outlined,
            ),
            title: const Text('Logout'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Confirm Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the dialog
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
