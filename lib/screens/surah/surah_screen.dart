import "dart:convert";
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islamic_app/constants/globals.dart';
import 'package:islamic_app/models/surah.dart';
import 'package:islamic_app/screens/home/home_screen.dart';
import 'package:islamic_app/screens/surah/ayah_item_widget.dart';
import 'package:islamic_app/screens/surah/detail_surah_widget.dart';

class SurahScreen extends StatelessWidget {
  const SurahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final surahNomor = ModalRoute.of(context)!.settings.arguments as int;

    Future<Surah> getSurah() async {
      var data =
          await Dio().get("https://quran-api-id.vercel.app/surahs/$surahNomor");

      return Surah.fromJson(json.decode(data.toString()));
    }

    return FutureBuilder(
      future: getSurah(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: backgroundDark,
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        Surah surah = snapshot.data!;

        return Scaffold(
          backgroundColor: backgroundDark,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 265,
                    elevation: 0,
                    backgroundColor: backgroundDark,
                    automaticallyImplyLeading: false,
                    leading: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ));
                        },
                        icon: SvgPicture.asset(
                          "assets/icons/icon_back.svg",
                          // ignore: deprecated_member_use
                          color: Colors.white,
                        )),
                    pinned: false,
                    snap: false,
                    floating: true,
                    actions: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              settings:
                                  RouteSettings(arguments: surahNomor + 1),
                              builder: (context) => const SurahScreen(),
                            ));
                          },
                          icon: SvgPicture.asset(
                            "assets/icons/icon_next.svg",
                            // ignore: deprecated_member_use
                            color: Colors.white,
                          ))
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      background: detailSurah(surah),
                    ),
                  ),
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                    childCount: surah.ayahs.length,
                    (context, index) {
                      return ayatItem(
                          surah.ayahs.elementAt(index), context, surah);
                    },
                  ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}



// import "dart:convert";
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:islamic_app/constants/globals.dart';
// import 'package:islamic_app/models/surah.dart';
// import 'package:islamic_app/screens/surah/appbar_widget.dart';
// import 'package:islamic_app/screens/surah/ayah_item_widget.dart';
// import 'package:islamic_app/screens/surah/detail_surah_widget.dart';

// class SurahScreen extends StatelessWidget {
//   const SurahScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final surahNomor = ModalRoute.of(context)!.settings.arguments;

//     Future<Surah> getSurah() async {
//       var data =
//           await Dio().get("https://quran-api-id.vercel.app/surahs/$surahNomor");

//       return Surah.fromJson(json.decode(data.toString()));
//     }

//     return FutureBuilder(
//       future: getSurah(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Scaffold(
//             backgroundColor: backgroundDark,
//             body: const Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         }

//         Surah surah = snapshot.data!;

//         return Scaffold(
//           backgroundColor: backgroundDark,
//           appBar: surahNavbar(snapshot.data!.name, context, snapshot.data!.number),
//           body: NestedScrollView(
//               headerSliverBuilder: (context, innerBoxIsScrolled) =>
//                   [SliverToBoxAdapter(child: detailSurah(surah))],
//               body: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 24),
//                 child: ListView.separated(
//                     itemBuilder: (context, index) {
//                       return ayatItem(surah.ayahs.elementAt(index), context, surah);
//                     },
//                     separatorBuilder: (context, index) => Divider(
//                         color: const Color(0xFF7B80AD).withOpacity(.35)),
//                     itemCount: surah.ayahs.length),
//               )),
//         );
//       },
//     );
//   }
// }


