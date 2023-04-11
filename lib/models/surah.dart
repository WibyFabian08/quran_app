// To parse this JSON data, do
//
//     final surah = surahFromJson(jsonString);

import 'dart:convert';

Surah surahFromJson(String str) => Surah.fromJson(json.decode(str));

String surahToJson(Surah data) => json.encode(data.toJson());

class Surah {
    Surah({
        required this.number,
        required this.numberOfAyahs,
        required this.name,
        required this.translation,
        required this.revelation,
        required this.description,
        required this.audio,
        required this.bismillah,
        required this.ayahs,
    });

    int number;
    int numberOfAyahs;
    String name;
    String translation;
    String revelation;
    String description;
    String audio;
    Bismillah bismillah;
    List<Ayah> ayahs;

    factory Surah.fromJson(Map<String, dynamic> json) => Surah(
        number: json["number"],
        numberOfAyahs: json["numberOfAyahs"],
        name: json["name"],
        translation: json["translation"],
        revelation: json["revelation"],
        description: json["description"],
        audio: json["audio"],
        bismillah: Bismillah.fromJson(json["bismillah"]),
        ayahs: List<Ayah>.from(json["ayahs"].map((x) => Ayah.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "number": number,
        "numberOfAyahs": numberOfAyahs,
        "name": name,
        "translation": translation,
        "revelation": revelation,
        "description": description,
        "audio": audio,
        "bismillah": bismillah.toJson(),
        "ayahs": List<dynamic>.from(ayahs.map((x) => x.toJson())),
    };
}

class Ayah {
    Ayah({
        required this.number,
        required this.arab,
        required this.translation,
        required this.audio,
        required this.image,
        required this.tafsir,
        required this.meta,
    });

    Number number;
    String arab;
    String translation;
    Audio audio;
    Image image;
    Tafsir tafsir;
    Meta meta;

    factory Ayah.fromJson(Map<String, dynamic> json) => Ayah(
        number: Number.fromJson(json["number"]),
        arab: json["arab"],
        translation: json["translation"],
        audio: Audio.fromJson(json["audio"]),
        image: Image.fromJson(json["image"]),
        tafsir: Tafsir.fromJson(json["tafsir"]),
        meta: Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "number": number.toJson(),
        "arab": arab,
        "translation": translation,
        "audio": audio.toJson(),
        "image": image.toJson(),
        "tafsir": tafsir.toJson(),
        "meta": meta.toJson(),
    };
}

class Audio {
    Audio({
        required this.alafasy,
        required this.ahmedajamy,
        required this.husarymujawwad,
        required this.minshawi,
        required this.muhammadayyoub,
        required this.muhammadjibreel,
    });

    String alafasy;
    String ahmedajamy;
    String husarymujawwad;
    String minshawi;
    String muhammadayyoub;
    String muhammadjibreel;

    factory Audio.fromJson(Map<String, dynamic> json) => Audio(
        alafasy: json["alafasy"],
        ahmedajamy: json["ahmedajamy"],
        husarymujawwad: json["husarymujawwad"],
        minshawi: json["minshawi"],
        muhammadayyoub: json["muhammadayyoub"],
        muhammadjibreel: json["muhammadjibreel"],
    );

    Map<String, dynamic> toJson() => {
        "alafasy": alafasy,
        "ahmedajamy": ahmedajamy,
        "husarymujawwad": husarymujawwad,
        "minshawi": minshawi,
        "muhammadayyoub": muhammadayyoub,
        "muhammadjibreel": muhammadjibreel,
    };
}

class Image {
    Image({
        required this.primary,
        required this.secondary,
    });

    String primary;
    String secondary;

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        primary: json["primary"],
        secondary: json["secondary"],
    );

    Map<String, dynamic> toJson() => {
        "primary": primary,
        "secondary": secondary,
    };
}

class Meta {
    Meta({
        required this.juz,
        required this.page,
        required this.manzil,
        required this.ruku,
        required this.hizbQuarter,
        required this.sajda,
    });

    int juz;
    int page;
    int manzil;
    int ruku;
    int hizbQuarter;
    Sajda sajda;

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        juz: json["juz"],
        page: json["page"],
        manzil: json["manzil"],
        ruku: json["ruku"],
        hizbQuarter: json["hizbQuarter"],
        sajda: Sajda.fromJson(json["sajda"]),
    );

    Map<String, dynamic> toJson() => {
        "juz": juz,
        "page": page,
        "manzil": manzil,
        "ruku": ruku,
        "hizbQuarter": hizbQuarter,
        "sajda": sajda.toJson(),
    };
}

class Sajda {
    Sajda({
        required this.recommended,
        required this.obligatory,
    });

    bool recommended;
    bool obligatory;

    factory Sajda.fromJson(Map<String, dynamic> json) => Sajda(
        recommended: json["recommended"],
        obligatory: json["obligatory"],
    );

    Map<String, dynamic> toJson() => {
        "recommended": recommended,
        "obligatory": obligatory,
    };
}

class Number {
    Number({
        required this.inQuran,
        required this.inSurah,
    });

    int inQuran;
    int inSurah;

    factory Number.fromJson(Map<String, dynamic> json) => Number(
        inQuran: json["inQuran"],
        inSurah: json["inSurah"],
    );

    Map<String, dynamic> toJson() => {
        "inQuran": inQuran,
        "inSurah": inSurah,
    };
}

class Tafsir {
    Tafsir({
        required this.kemenag,
        required this.quraish,
        required this.jalalayn,
    });

    Kemenag kemenag;
    String quraish;
    String jalalayn;

    factory Tafsir.fromJson(Map<String, dynamic> json) => Tafsir(
        kemenag: Kemenag.fromJson(json["kemenag"]),
        quraish: json["quraish"],
        jalalayn: json["jalalayn"],
    );

    Map<String, dynamic> toJson() => {
        "kemenag": kemenag.toJson(),
        "quraish": quraish,
        "jalalayn": jalalayn,
    };
}

class Kemenag {
    Kemenag({
        required this.short,
        required this.long,
    });

    String short;
    String long;

    factory Kemenag.fromJson(Map<String, dynamic> json) => Kemenag(
        short: json["short"],
        long: json["long"],
    );

    Map<String, dynamic> toJson() => {
        "short": short,
        "long": long,
    };
}

class Bismillah {
    Bismillah({
        required this.arab,
        required this.translation,
        required this.audio,
    });

    String arab;
    String translation;
    Audio audio;

    factory Bismillah.fromJson(Map<String, dynamic> json) => Bismillah(
        arab: json["arab"],
        translation: json["translation"],
        audio: Audio.fromJson(json["audio"]),
    );

    Map<String, dynamic> toJson() => {
        "arab": arab,
        "translation": translation,
        "audio": audio.toJson(),
    };
}
