import 'package:flutter/material.dart';
import 'package:to_do_app/model/constants/constants.dart';

class SelectCategory extends StatelessWidget {
  final Function(String?)? onChanged;
  final String? value;

  const SelectCategory({Key? key, this.onChanged, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        value: value,
        enableFeedback: true,
        iconEnabledColor: primaryColor,
        iconDisabledColor: primaryColor,
        style: const TextStyle(color: primaryColor),
        onChanged: onChanged,
        icon: const Icon(Icons.arrow_downward),
        elevation: 0,
        items: [
          'Work',
          'Love',
          'Personal',
          'Home',
          'Date',
          'V I B',
          'Kids',
          'Other'
        ].map<DropdownMenuItem<String>>((String value2) {
          return DropdownMenuItem<String>(
            value: value2,
            child: Text(value2),
          );
        }).toList());
  }
}
