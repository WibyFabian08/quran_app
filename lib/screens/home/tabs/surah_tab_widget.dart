import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamic_app/constants/globals.dart';
import 'package:islamic_app/models/list_surah.dart';
import 'package:islamic_app/screens/surah/surah_screen.dart';

class SurahView extends StatelessWidget {
  const SurahView({super.key});

  Future<List<ListSurah>> _getListSurah() async {
    String data = await rootBundle.loadString("assets/data/list-surah.json");
    return listSurahFromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getListSurah(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData) {
          return const Center(
              child: Text(
            "Data Not Found",
            style: TextStyle(color: Colors.white),
          ));
        }

        return ListView.separated(
            itemBuilder: (context, index) {
              return surahItem(
                  surah: snapshot.data!.elementAt(index), context: context);
            },
            separatorBuilder: (context, index) {
              return Divider(color: const Color(0xFF7B80AD).withOpacity(.35));
            },
            itemCount: snapshot.data!.length);
      },
    );
  }
}

Widget surahItem({required ListSurah surah, required BuildContext context}) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          settings: RouteSettings(
            arguments: surah.nomor
          ),
          builder:(context) => const SurahScreen(),)
      );
    },
    child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset("assets/icons/icon_ayat.svg"),
                    Text("${surah.nomor}",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500))
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(surah.namaLatin,
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                    Row(
                      children: [
                        Text(surah.tempatTurun.name,
                            style: GoogleFonts.poppins(
                                color: text,
                                fontSize: 12,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 4,
                          width: 4,
                          decoration: BoxDecoration(
                              color: text,
                              borderRadius: BorderRadius.circular(100)),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text("${surah.jumlahAyat} Ayat",
                            style: GoogleFonts.poppins(
                                color: text,
                                fontSize: 12,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Text(surah.nama,
                style: GoogleFonts.amiri(
                    color: primary, fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        )),
  );
}
