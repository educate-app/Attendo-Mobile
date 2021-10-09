import 'package:flutter/material.dart';

class CustomTileWidget extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final IconData icon;
  final VoidCallback onClick;
  final TextInputType inputType;
  const CustomTileWidget({
    Key? key,
    required this.controller,
    required this.title,
    required this.icon,
    required this.onClick,
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
              decoration: InputDecoration(
                hintText: title,
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 16),
                alignLabelWithHint: true,
              ),
            ),
          ),
          IconButton(onPressed: onClick, icon: Icon(icon))
        ],
      ),
    );
  }
}
