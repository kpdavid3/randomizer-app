import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home.dart';

class EndPage extends StatefulWidget {
  const EndPage({Key? key}) : super(key: key);

  @override
  _EndPageState createState() => _EndPageState();
}

class _EndPageState extends State<EndPage> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: RawKeyboardListener(
        focusNode: _focusNode,
        onKey: (event) {
          if (event is RawKeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.enter) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Home()));  // Navigate to Home
            }
          }
        },
        child: GestureDetector(
          onTap: () => _focusNode.requestFocus(),  // Focus the node when tapped anywhere in the scaffold
          child: Container(
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
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/background.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/logo2.png',
                      height: 200,
                    ),
                    Text(
                      'National Science Quiz Contest',
                      style: GoogleFonts.montserrat(
                        fontSize: 48,
                        color: const Color(0xFFD4AD52),
                        fontWeight: FontWeight.bold,
                        shadows: [
                          const Shadow(
                            color: Colors.grey,
                            offset: Offset(2.0, 2.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
