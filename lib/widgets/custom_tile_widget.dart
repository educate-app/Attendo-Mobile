import 'package:flutter/material.dart';

class CustomTileWidget extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final IconData icon;
  final TextInputType inputType;

  const CustomTileWidget({
    Key? key,
    required this.controller,
    required this.title,
    required this.icon,
    required this.inputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              autocorrect: true,
              keyboardType: inputType,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter some Value';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: title,
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 16),
                alignLabelWithHint: true,
              ),
            ),
          ),
          IconButton(onPressed: () {}, icon: Icon(icon))
        ],
      ),
    );
  }
}
