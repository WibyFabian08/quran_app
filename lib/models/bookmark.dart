// To parse this JSON data, do
//
//     final bookMark = bookMarkFromJson(jsonString);

import 'dart:convert';

List<BookMark> bookMarkFromJson(String str) => List<BookMark>.from(json.decode(str).map((x) => BookMark.fromJson(x)));

String bookMarkToJson(List<BookMark> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookMark {
    BookMark({
        required this.ayah,
        required this.surahNo,
        required this.surahName,
    });

    int ayah;
    int surahNo;
    String surahName;

    factory BookMark.fromJson(Map<String, dynamic> json) => BookMark(
        ayah: json["ayah"],
        surahNo: json["surah_no"],
        surahName: json["surah_name"],
    );

    Map<String, dynamic> toJson() => {
        "ayah": ayah,
        "surah_no": surahNo,
        "surah_name": surahName,
    };
}
