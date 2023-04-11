import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:google_fonts/google_fonts.dart";
import "package:islamic_app/constants/globals.dart";
import "package:islamic_app/models/surah.dart";

Widget detailSurah(Surah surah) {
  return Stack(
    children: [
      Container(
        height: 265,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [
                  0,
                  0.6,
                  1
                ],
                colors: [
                  Color(0xFFDF98FA),
                  Color(0xFFB070FD),
                  Color(0xFF9055FF)
                ])),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: SvgPicture.asset("assets/images/image_quran_trans.svg"),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            Text(surah.name,
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w500)),
            const SizedBox(
              height: 4,
            ),
            Text(surah.translation,
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
            Divider(
              color: Colors.white.withOpacity(0.35),
              height: 32,
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(surah.revelation,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500)),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  height: 4,
                  width: 4,
                  decoration: BoxDecoration(
                      color: text, borderRadius: BorderRadius.circular(100)),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text("${surah.numberOfAyahs} Ayat",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500)),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            SvgPicture.asset("assets/icons/icon_bismillah.svg")
          ],
        ),
      )
    ],
  );
}
