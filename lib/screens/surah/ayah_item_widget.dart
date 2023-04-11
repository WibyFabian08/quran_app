import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamic_app/constants/globals.dart';
import 'package:islamic_app/models/bookmark.dart';
import 'package:islamic_app/models/surah.dart';
import 'package:islamic_app/screens/surah/audio_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

Widget ayatItem(Ayah ayah, BuildContext context, Surah surah) {
  Future<void> setPreference(Ayah dataAyah) async {
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

      pref.clear();
    }

    // ignore: iterable_contains_unrelated_type
    if (bookmark.any((element) =>
        element.surahName == surah.name &&
        element.ayah == ayah.number.inSurah)) {
      bookmark.removeWhere(
        (element) =>
            element.surahName == surah.name &&
            element.ayah == ayah.number.inSurah,
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color(0xFF9055FF),
          content: Text(
            "Delete from Bookmark Success",
            style: TextStyle(color: Colors.white),
          )));
    } else {
      bookmark.add(BookMark(
          ayah: ayah.number.inSurah,
          surahNo: surah.number,
          surahName: surah.name));

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color(0xFF9055FF),
          content: Text("Add to Bookmark Success",
              style: TextStyle(color: Colors.white))));
    }

    var myData = json.encode({"bookmark": bookmark});

    pref.setString('myData', myData);
  }

  return Padding(
    padding: const EdgeInsets.only(top: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: secondary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(100)),
                  ),
                  Text(
                    "${ayah.number.inSurah}",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(15))),
                          backgroundColor: const Color(0xFF9055FF),
                          builder: (context) {
                            return SizedBox(
                              height: 200,
                              // color: Colors.white,
                              child: StatefulBuilder(
                                builder: (context, setState) {
                                  setState(() {});
                                  return AudioPlayerWidget(ayah: ayah);
                                },
                              ),
                            );
                          },
                        );
                      },
                      child: SvgPicture.asset("assets/icons/icon_play.svg")),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setPreference(ayah);
                      },
                      child: SvgPicture.asset(
                          "assets/icons/icon_bookmark_color.svg")),
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          ayah.arab,
          style: GoogleFonts.amiri(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.end,
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          ayah.translation,
          style: GoogleFonts.poppins(
              color: text, fontSize: 16, fontWeight: FontWeight.w400),
          textAlign: TextAlign.start,
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          "Tafsir :",
          style: GoogleFonts.poppins(
              color: text, fontSize: 16, fontWeight: FontWeight.w400),
          textAlign: TextAlign.start,
        ),
        Text(
          ayah.tafsir.kemenag.short,
          style: GoogleFonts.poppins(
              color: text, fontSize: 16, fontWeight: FontWeight.w400),
          textAlign: TextAlign.start,
        ),
      ],
    ),
  );
}
