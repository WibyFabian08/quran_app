import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamic_app/constants/globals.dart';

AppBar homeNavbar(String name) {
  return AppBar(
    backgroundColor: backgroundDark,
    automaticallyImplyLeading: false,
    elevation: 0,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // const SizedBox(width: 20,),
        // IconButton(
        //     onPressed: () {},
        //     icon: SvgPicture.asset("assets/icons/icon_menu.svg")),
        Text(name,
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        // IconButton(onPressed: () {}, icon: const Icon(Icons.light_mode)),
      ],
    ),
  );
}