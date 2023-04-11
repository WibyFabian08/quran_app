import "dart:convert";

import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:google_fonts/google_fonts.dart";
import "package:islamic_app/constants/globals.dart";
import "package:islamic_app/models/bookmark.dart";
import "package:shared_preferences/shared_preferences.dart";

Column greeting() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(
        height: 10,
      ),
      Text(
        "Asslamualaikum",
        style: GoogleFonts.poppins(
            color: text, fontSize: 18, fontWeight: FontWeight.w500),
      ),
      Text(
        "May Allah Grant us Mercy",
        style: GoogleFonts.poppins(
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
      ),
      const SizedBox(
        height: 10,
      ),
      lastRead()
    ],
  );
}

Widget lastRead() {
  Future<List<BookMark>> getBookmark() async {
    final pref = await SharedPreferences.getInstance();
    List<BookMark> bookmark = [];

    if (pref.containsKey('myData')) {
      final data =
          json.decode(pref.getString('myData')!) as Map<String, dynamic>;

      data["bookmark"].forEach((element) {
        bookmark.add(BookMark(
            ayah: element["ayah"],
            surahNo: element["surah_no"],
            surahName: element["surah_name"]));
      });
    }
    return bookmark;
  }

  return FutureBuilder(
    future: getBookmark(),
    builder: (context, snapshot) {
      if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return Stack(
          children: [
            Container(
              height: 131,
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
              child: SvgPicture.asset("assets/images/image_quran.svg"),
            ),
            Padding(
              padding: const EdgeInsets.all(19),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset("assets/icons/icon_last_seen.svg"),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Last Read",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "No Bookmark",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "-",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            )
          ],
        );
      } else {
        return Stack(
          children: [
            Container(
              height: 131,
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
              child: SvgPicture.asset("assets/images/image_quran.svg"),
            ),
            Padding(
              padding: const EdgeInsets.all(19),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset("assets/icons/icon_last_seen.svg"),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Last Read",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    snapshot.data![snapshot.data!.length - 1].surahName,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Ayat No ${snapshot.data![snapshot.data!.length - 1].ayah}",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            )
          ],
        );
      }
    },
  );
}
