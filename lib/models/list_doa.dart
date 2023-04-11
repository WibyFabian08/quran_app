// To parse this JSON data, do
//
//     final listDoa = listDoaFromJson(jsonString);

import 'dart:convert';

List<ListDoa> listDoaFromJson(String str) => List<ListDoa>.from(json.decode(str).map((x) => ListDoa.fromJson(x)));

String listDoaToJson(List<ListDoa> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListDoa {
    ListDoa({
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

    factory ListDoa.fromJson(Map<String, dynamic> json) => ListDoa(
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
