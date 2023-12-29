import 'package:flutter/material.dart';

class ChoiceBox extends StatelessWidget {
  final String text;
  final bool status;

  const ChoiceBox({
    Key? key,
    required this.text,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          // ChoiceBox(text: text, status: true), // Embed CustomWidget here
          const SizedBox(height: 16.0), // Add some spacing if needed
          Text(
            text,
            style: status
                ? const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight
                        .bold, // Change to your desired style for true status
                    color: Colors
                        .green, // Change to your desired color for true status
                  )
                : const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
