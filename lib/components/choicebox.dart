import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChoiceBox extends StatelessWidget {
  final String text;
  final String letter;
  final String type;
  final double fontSize;
  const ChoiceBox({
    super.key,
    required this.text,
    required this.letter,
    required this.type,
    required this.fontSize,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.center,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFD4AD52),
            Color(0xFFD4AD52),
            Color(0xFFD4AD52),
            Color(0xFFD4AD52),
            Color(0xFFD4AD52),
            Color(0xFF333333),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (type == "mc")
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 40, 0),
                  child: Text(
                    letter,
                    style: GoogleFonts.montserrat(
                      fontSize: 38.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    text,
                    style: GoogleFonts.montserrat(
                      fontSize: fontSize.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          if (type == "tf")
            Text(
              text,
              style: GoogleFonts.montserrat(
                fontSize: 42.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                height: 1,
              ),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}
