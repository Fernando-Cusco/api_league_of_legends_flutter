// To parse this JSON data, do
//
//     final campeones = campeonesFromJson(jsonString);

import 'dart:convert';

Campeones campeonesFromJson(String str) => Campeones.fromJson(json.decode(str));

String campeonesToJson(Campeones data) => json.encode(data.toJson());

class Campeones {
    Campeones({
        this.type = "",
        this.format = "",
        this.version = "",
        this.data,
    });

    String type;
    String format;
    String version;
    Data ?data;

    factory Campeones.fromJson(Map<String, dynamic> json) => Campeones(
        type: json["type"],
        format: json["format"],
        version: json["version"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "format": format,
        "version": version,
    };
}

class Data {
    Data({
        this.campeon,
    });

    Campeon ?campeon;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        campeon: Campeon.fromJson(json["Campeon"]),
    );

}

class Campeon {
    Campeon({
        this.version = "",
        this.id = "",
        this.key = "",
        this.name = "",
        this.title = "",
        this.blurb = "",
        this.info,
        this.image,
        this.tags,
        this.partype = "",
        this.stats,
    });

    String version;
    String id;
    String key;
    String name;
    String title;
    String blurb;
    Info ?info;
    Image ?image;
    List<String> ?tags;
    String partype;
    Map<String, double> ?stats;


    factory Campeon.fromJson(Map<String, dynamic> json) => Campeon(
        version: json["version"],
        id: json["id"],
        key: json["key"],
        name: json["name"],
        title: json["title"],
        blurb: json["blurb"],
        info: Info.fromJson(json["info"]),
        image: Image.fromJson(json["image"]),
        tags: List<String>.from(json["tags"].map((x) => x)),
        partype: json["partype"],
        stats: Map.from(json["stats"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
    );
}

class Champions {
  List<Campeon> campeones = [];

  Champions();

  Champions.fromJsonToList(List jsonList) {
    if (jsonList == null) return;
    for (var c in jsonList) {
      final campeon = Campeon.fromJson(c);
      campeones.add(campeon);
    }
  }

}

class Image {
    Image({
        this.full = "",
        this.sprite = "",
        this.group = "",
        this.x = 0,
        this.y = 0,
        this.w = 0,
        this.h = 0,
    });

    String full;
    String sprite;
    String group;
    int x;
    int y;
    int w;
    int h;

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        full: json["full"],
        sprite: json["sprite"],
        group: json["group"],
        x: json["x"],
        y: json["y"],
        w: json["w"],
        h: json["h"],
    );

    Map<String, dynamic> toJson() => {
        "full": full,
        "sprite": sprite,
        "group": group,
        "x": x,
        "y": y,
        "w": w,
        "h": h,
    };
}

class Info {
    Info({
        this.attack = 0,
        this.defense = 0,
        this.magic = 0,
        this.difficulty = 0,
    });

    int attack;
    int defense;
    int magic;
    int difficulty;

    factory Info.fromJson(Map<String, dynamic> json) => Info(
        attack: json["attack"],
        defense: json["defense"],
        magic: json["magic"],
        difficulty: json["difficulty"],
    );

    Map<String, dynamic> toJson() => {
        "attack": attack,
        "defense": defense,
        "magic": magic,
        "difficulty": difficulty,
    };
}
