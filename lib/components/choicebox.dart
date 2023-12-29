import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        color: status ? Colors.red : Colors.white,
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
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: status ? Colors.white : Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
