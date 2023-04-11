// To parse this JSON data, do
//
//     final listSurah = listSurahFromJson(jsonString);

import 'dart:convert';

List<ListSurah> listSurahFromJson(String str) => List<ListSurah>.from(json.decode(str).map((x) => ListSurah.fromJson(x)));

String listSurahToJson(List<ListSurah> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListSurah {
    ListSurah({
        required this.nomor,
        required this.nama,
        required this.namaLatin,
        required this.jumlahAyat,
        required this.tempatTurun,
        required this.arti,
        required this.deskripsi,
        required this.audio,
    });

    int nomor;
    String nama;
    String namaLatin;
    int jumlahAyat;
    TempatTurun tempatTurun;
    String arti;
    String deskripsi;
    String audio;

    factory ListSurah.fromJson(Map<String, dynamic> json) => ListSurah(
        nomor: json["nomor"],
        nama: json["nama"],
        namaLatin: json["nama_latin"],
        jumlahAyat: json["jumlah_ayat"],
        tempatTurun: tempatTurunValues.map[json["tempat_turun"]]!,
        arti: json["arti"],
        deskripsi: json["deskripsi"],
        audio: json["audio"],
    );

    Map<String, dynamic> toJson() => {
        "nomor": nomor,
        "nama": nama,
        "nama_latin": namaLatin,
        "jumlah_ayat": jumlahAyat,
        "tempat_turun": tempatTurunValues.reverse[tempatTurun],
        "arti": arti,
        "deskripsi": deskripsi,
        "audio": audio,
    };
}

// ignore: constant_identifier_names
enum TempatTurun { MEKAH, MADINAH }

final tempatTurunValues = EnumValues({
    "madinah": TempatTurun.MADINAH,
    "mekah": TempatTurun.MEKAH
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
