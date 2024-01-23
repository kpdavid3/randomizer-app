import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CounterBox extends StatelessWidget {
  final String mcNum;
  final String iNum;
  final String tfNum;
  final String difficulty;

  const CounterBox({
    super.key,
    required this.difficulty,
    required this.mcNum,
    required this.iNum,
    required this.tfNum,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 241, 241, 241),
          borderRadius:
              BorderRadius.circular(10.0), // Adjust the radius as needed
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(0.1), // Adjust the shadow color and opacity
              offset: const Offset(0, 2), // Adjust the shadow offset
              blurRadius: 2.0, // Adjust the blur radius
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              difficulty,
              style: GoogleFonts.poppins(
                  color: Colors.black45,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text(
                  "Multiple Choice:",
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 16.sp,
                  ),
                ),
                const Spacer(),
                Text(
                  mcNum,
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Identification:",
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 16.sp,
                  ),
                ),
                const Spacer(),
                Text(
                  iNum,
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "True or False:",
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 16.sp,
                  ),
                ),
                const Spacer(),
                Text(
                  tfNum,
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
