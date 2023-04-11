// To parse this JSON data, do
//
//     final kisahNabi = kisahNabiFromJson(jsonString);

import 'dart:convert';

List<KisahNabi> kisahNabiFromJson(String str) => List<KisahNabi>.from(json.decode(str).map((x) => KisahNabi.fromJson(x)));

String kisahNabiToJson(List<KisahNabi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KisahNabi {
    KisahNabi({
        required this.name,
        required this.thnKelahiran,
        required this.usia,
        required this.description,
        required this.tmp,
        required this.imageUrl,
        required this.iconUrl,
    });

    String name;
    String thnKelahiran;
    dynamic usia;
    String description;
    String tmp;
    String imageUrl;
    String iconUrl;

    factory KisahNabi.fromJson(Map<String, dynamic> json) => KisahNabi(
        name: json["name"],
        thnKelahiran: json["thn_kelahiran"],
        usia: json["usia"],
        description: json["description"],
        tmp: json["tmp"],
        imageUrl: json["image_url"],
        iconUrl: json["icon_url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "thn_kelahiran": thnKelahiran,
        "usia": usia,
        "description": description,
        "tmp": tmp,
        "image_url": imageUrl,
        "icon_url": iconUrl,
    };
}
