import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:islamic_app/constants/globals.dart";

BottomNavigationBar bottomTabBar() {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    backgroundColor: gray,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    items: [
      bottomTabItem("assets/icons/Icon_surah.svg", "Surah"),
      bottomTabItem("assets/icons/Icon_light.svg", "Lamp"),
      bottomTabItem("assets/icons/Icon_pray.svg", "Sholat"),
      bottomTabItem("assets/icons/Icon_doa.svg", "Doa"),
      bottomTabItem("assets/icons/icon_bookmark.svg", "Bookmark"),
    ],
  );
}

BottomNavigationBarItem bottomTabItem(String asset, String label) {
  return BottomNavigationBarItem(
    
      icon: SvgPicture.asset(
        asset,
      ),
      activeIcon: SvgPicture.asset(
        asset,
        // ignore: deprecated_member_use
        color: primary,
      ),
      label: label);
}
