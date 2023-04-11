// To parse this JSON data, do
//
//     final doa = doaFromJson(jsonString);

import 'dart:convert';

Doa doaFromJson(String str) => Doa.fromJson(json.decode(str));

String doaToJson(Doa data) => json.encode(data.toJson());

class Doa {
    Doa({
        required this.tag,
        required this.judul,
        required this.arab,
        required this.latin,
        required this.arti,
        required this.footnote,
    });

    List<String> tag;
    String judul;
    String arab;
    String latin;
    String arti;
    String footnote;

    factory Doa.fromJson(Map<String, dynamic> json) => Doa(
        tag: List<String>.from(json["tag"].map((x) => x)),
        judul: json["judul"],
        arab: json["arab"],
        latin: json["latin"],
        arti: json["arti"],
        footnote: json["footnote"],
    );

    Map<String, dynamic> toJson() => {
        "tag": List<dynamic>.from(tag.map((x) => x)),
        "judul": judul,
        "arab": arab,
        "latin": latin,
        "arti": arti,
        "footnote": footnote,
    };
}
