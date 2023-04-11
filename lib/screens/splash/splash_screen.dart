import 'package:flutter/material.dart';
import 'package:islamic_app/constants/globals.dart';
import "package:google_fonts/google_fonts.dart";
import "package:flutter_svg/flutter_svg.dart";
import 'package:islamic_app/screens/home/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDark,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Islamic Apps",
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Learn Quran and\n Recite once everyday",
                  style: GoogleFonts.poppins(
                      color: text, fontWeight: FontWeight.normal, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 49,
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 450,
                      // width: double.infinity,
                      decoration: BoxDecoration(
                          color: purple,
                          borderRadius: BorderRadius.circular(30)),
                      child: SvgPicture.asset("assets/images/image_splash.svg"),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: -23,
                      child: Center(
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder:(context) => const HomeScreen(),)
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 16),
                            decoration: BoxDecoration(
                                color: orange,
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              "Get Started",
                              style: GoogleFonts.poppins(
                                  color: blue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
