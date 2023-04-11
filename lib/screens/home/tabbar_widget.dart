import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:islamic_app/constants/globals.dart";

TabBar tab() {
  return TabBar(
    unselectedLabelColor: text,
    labelColor: Colors.white,
    indicatorColor: primary,
    indicatorWeight: 3,
    tabs: [
      tabItem("Surat"),
      tabItem("Doa"),
      tabItem("Nabi"),
      tabItem("Mark"),
    ],
  );
}

Tab tabItem(String label) {
  return Tab(
    child: Text(label, style: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w600
    ),),
  );
}