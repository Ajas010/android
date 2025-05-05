import 'package:flutter/material.dart';
import 'package:terefbooking/data/constants.dart';
import 'package:terefbooking/presentation/screens/editProfile.dart';

class ProfileViewScreen extends StatelessWidget {
  final profile;

  const ProfileViewScreen({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appthemeColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(radius: 40,backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcZsL6PVn0SNiabAKz7js0QknS2ilJam19QQ&s'),),
          )),
          Center(
            child: Card(
              // color: const Color.fromARGB(1, 0, 0, 0),
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
          
          
          
          
                    ProfileField(label: 'Name', value: profile['name']),
                    const Divider(),
                    ProfileField(label: 'Email', value: profile['email']),
                    const Divider(),
                    ProfileField(
                        label: 'Gender',
                        value: profile['gender'] ?? 'not available'),
                    const Divider(),
                    ProfileField(
                        label: 'Phone', value: profile['phone'].toString()),
                    const Divider(),
                    ProfileField(
                        label: 'Place', value: profile['address'].toString()),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to Edit Profile Screen
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileEditScreen(
                                        name: profile['name'],
                                        email: profile['email'],
                                        gender:
                                            profile['gender'] ?? 'not available',
                                        phone: profile['phone'],
                                        address:profile['address']
                                      )));
                        },
                        child: const Text(
                          'Edit Profile',
                          style: TextStyle(color: appthemeColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileField extends StatelessWidget {
  final String label;
  final String value;

  const ProfileField({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
