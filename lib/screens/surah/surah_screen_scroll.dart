import "dart:convert";
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islamic_app/constants/globals.dart';
import 'package:islamic_app/models/surah.dart';
import 'package:islamic_app/screens/surah/ayah_item_widget.dart';
import 'package:islamic_app/screens/surah/detail_surah_widget.dart';
import 'package:islamic_app/screens/surah/surah_screen.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class SurahScreenScroll extends StatelessWidget {
  const SurahScreenScroll({super.key});

  @override
  Widget build(BuildContext context) {
    final surahNomor =
        ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;
    AutoScrollController scrollController = AutoScrollController();

    Future<Surah> getSurah() async {
      var data = await Dio().get(
          "https://quran-api-id.vercel.app/surahs/${surahNomor['surahNo']}");

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
                controller: scrollController,
                slivers: [
                  SliverAppBar(
                    expandedHeight: 265,
                    elevation: 0,
                    backgroundColor: backgroundDark,
                    automaticallyImplyLeading: false,
                    leading: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: SvgPicture.asset(
                          "assets/icons/icon_back.svg",
                          // ignore: deprecated_member_use
                          color: Colors.white,
                        )),
                    pinned: false,
                    snap: true,
                    floating: true,
                    actions: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              settings: RouteSettings(
                                  arguments: surahNomor["surahNo"] + 1),
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
                      return AutoScrollTag(
                          index: surah.ayahs.elementAt(index).number.inSurah,
                          key: ValueKey(
                              surah.ayahs.elementAt(index).number.inSurah),
                          controller: scrollController,
                          child: ayatItem(
                              surah.ayahs.elementAt(index), context, surah));
                    },
                  ))
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: primary,
            onPressed: () {
              scrollController.scrollToIndex(surahNomor['ayah'],
                  preferPosition: AutoScrollPosition.begin);
            },
            child: const Icon(
              Icons.bookmark,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
