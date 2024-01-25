import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class Defaultsection extends StatefulWidget {
  const Defaultsection({super.key});

  @override
  Defaultsectionstate createState() => Defaultsectionstate();
}

class Defaultsectionstate extends State<Defaultsection> {
  String selectedFilePath = "";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [
              Colors.yellow,
              Color(0xFF333333),
              Colors.yellow,
              Colors.white,
              Colors.yellow,
              Color(0xFF333333),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Container(
            width: screenWidth * 0.95,
            height: screenHeight * 0.9,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
              // borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Image.asset(
                //       'assets/logo1.png', // Update with your actual logo path
                //       height: 100,
                //     ),
                //     const SizedBox(width: 20),
                //     Image.asset(
                //       'assets/logo2.png', // Update with your actual logo path
                //       height: 100,
                //     ),
                //   ],
                // ),
                const SizedBox(height: 20),
                Container(
                  width: screenWidth * 0.60,
                  child: Text(
                    'National Science Quiz Contest',
                    style: GoogleFonts.montserrat(
                      fontSize: 86.sp,
                      color: const Color(0xFFD4AD52),
                      fontWeight: FontWeight.bold,
                      height: 1.0,
                      shadows: [
                        const Shadow(
                          color: Color(0xFF333333),
                          offset: Offset(2.0, 2.0),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
