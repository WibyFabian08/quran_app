import 'package:flutter/material.dart';
import 'package:islamic_app/constants/globals.dart';
import 'package:islamic_app/screens/home/appbar_widget.dart';
import 'package:islamic_app/screens/home/greeting_widget.dart';
import 'package:islamic_app/screens/home/tabbar_widget.dart';
import 'package:islamic_app/screens/home/tabs/doa_tab_widget.dart';
import 'package:islamic_app/screens/home/tabs/kisah_tab_widget.dart';
import 'package:islamic_app/screens/home/tabs/mark_tab_widget.dart';
import 'package:islamic_app/screens/home/tabs/surah_tab_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDark,
      appBar: homeNavbar("Islamic Apps"),
      body: DefaultTabController(
        length: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: greeting()
              ),
              SliverAppBar(
                pinned: true,
                elevation: 0,
                backgroundColor: backgroundDark,
                automaticallyImplyLeading: false,
                shape: Border(
                  bottom: BorderSide(
                    width: 3,
                    color: border.withOpacity(0.1)
                  )
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(0),
                  child: tab(),
                ),
              ),
            ],
            body: const TabBarView(
              children: [
                SurahView(),
                DoaView(),
                KisahView(),
                MarkView(),
              ],
            )
          ),
        ),
      ),
      // bottomNavigationBar: bottomTabBar(),
    );
  }
}








