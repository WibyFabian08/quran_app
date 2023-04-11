import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamic_app/constants/globals.dart';
import 'package:islamic_app/models/bookmark.dart';
import 'package:islamic_app/screens/surah/surah_screen_scroll.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MarkView extends StatelessWidget {
  const MarkView({super.key});

  Future<List<BookMark>> _getBookmark() async {
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getBookmark(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
              child: Text(
            "No Bookmark Yet",
            style: TextStyle(color: Colors.white),
          ));
        }

        return ListView.separated(
            itemBuilder: (context, index) {
              return bookMarkItem(
                  data: snapshot.data!.elementAt(index), context: context);
            },
            separatorBuilder: (context, index) {
              return Divider(color: const Color(0xFF7B80AD).withOpacity(.35));
            },
            itemCount: snapshot.data!.length);
      },
    );
  }
}

Widget bookMarkItem({required BookMark data, required BuildContext context}) {
  Future<void> deleteBokkMark(BookMark dataBookMark) async {
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
    bookmark.removeWhere(
      (element) =>
          element.surahName == dataBookMark.surahName &&
          element.ayah == dataBookMark.ayah,
    );

    var myData = json.encode({"bookmark": bookmark});

    pref.setString('myData', myData);
  }

  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onLongPress: () {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: primary,
            title: Text(
              "Delete Bookmark",
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
            ),
            content: Text(
              "Are you sure delete bookmark?",
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child:
                    const Text('Delete', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  deleteBokkMark(data);
                  Navigator.of(context).pop();

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Color(0xFF9055FF),
                      content: Text(
                        "Delete from Bookmark Success",
                        style: TextStyle(color: Colors.white),
                      )));
                },
              ),
            ],
          );
        },
      );
    },
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
        settings: RouteSettings(arguments: {
          "surahNo": data.surahNo,
          "ayah": data.ayah
        }),
        builder: (context) => const SurahScreenScroll(),
      ));
    },
    child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Surah ${data.surahName}",
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset("assets/icons/icon_ayat.svg"),
                Text(
                  "${data.ayah}",
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                ),
              ],
            )
          ],
        )),
  );
}
