import 'package:flutter/material.dart';
import 'edit_page.dart';
import 'randomizer.dart';
import '../components/button.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: Colors.red[200], // Set red background color
        child: Center(
          child: Container(
            width: screenWidth * 0.95,
            height: screenHeight * 0.9,
            decoration: BoxDecoration(
              color: Colors.white, // White background for the rounded rectangle
              borderRadius: BorderRadius.circular(20), // Set border radius
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'logo2.png', // Replace with the actual path to your image
                  height: 200, // Adjust the height as needed
                ),
                Text(
                  'National Science Quiz Contest',
                  style: GoogleFonts.poppins(
                    fontSize: 36,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Quiz Randomizer',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Button(
                  buttonText: 'Edit Questions',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EditPage()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Button(
                  buttonText: 'Start Quiz',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RandomizerPage()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Back',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
