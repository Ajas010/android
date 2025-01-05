import 'package:flutter/material.dart';

class GenderSelector extends StatefulWidget {
  final ValueChanged<String> onGenderSelected;

  const GenderSelector({Key? key, required this.onGenderSelected})
      : super(key: key);

  @override
  _GenderSelectorState createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  String? _selectedGender = 'Male'; // Tracks the selected gender

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gender',
        ),
        Column(
          children: [
            // Expanded(
            // child:
            RadioListTile<String>(
              title: const Text('Male'),
              value: 'Male',
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
                widget.onGenderSelected(value!);
              },
              // ),
            ),
            // Expanded(
            // child:
            RadioListTile<String>(
              title: const Text('Female'),
              value: 'Female',
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
                widget.onGenderSelected(value!);
              },
            ),
            // ),
          ],
        ),
        // if (_selectedGender == null)
        //   const Padding(
        //     padding: EdgeInsets.only(left: 16.0, top: 8.0),
        //     child: Text(
        //       'Please select your gender',
        //       style: TextStyle(color: Colors.red, fontSize: 12),
        //     ),
        //   )
      ],
    );
  }
}
