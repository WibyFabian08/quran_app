import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamic_app/constants/globals.dart';
import 'package:islamic_app/screens/home/home_screen.dart';
import 'package:islamic_app/screens/surah/surah_screen.dart';

AppBar surahNavbar(String name, BuildContext context, int number) {
  return AppBar(
    backgroundColor: backgroundDark,
    automaticallyImplyLeading: false,
    elevation: 0,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder:(context) => const HomeScreen(),)
              );
            },
            icon: SvgPicture.asset("assets/icons/icon_back.svg")),
        Text(name,
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        IconButton(
            onPressed: () {
              Navigator.of(context).push(
        MaterialPageRoute(
          settings: RouteSettings(
            arguments: number + 1
          ),
          builder:(context) => const SurahScreen(),)
      );
            },
            icon: SvgPicture.asset("assets/icons/icon_next.svg")),
      ],
    ),
  );
}
