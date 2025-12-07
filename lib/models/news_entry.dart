// To parse this JSON data, do
//
//     final newsEntry = newsEntryFromJson(jsonString);

import 'dart:convert';

NewsEntry newsEntryFromJson(String str) => NewsEntry.fromJson(json.decode(str));

String newsEntryToJson(NewsEntry data) => json.encode(data.toJson());

class NewsEntry {
  List<News> news;

  NewsEntry({
    required this.news,
  });

  factory NewsEntry.fromJson(Map<String, dynamic> json) => NewsEntry(
    news: List<News>.from(json["news"].map((x) => News.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "news": List<dynamic>.from(news.map((x) => x.toJson())),
  };
}

class News {
  int id;
  String title;
  Author author;
  String source;
  DateTime publishTime;
  Category category;
  String thumbnail;

  News({
    required this.id,
    required this.title,
    required this.author,
    required this.source,
    required this.publishTime,
    required this.category,
    required this.thumbnail,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
    id: json["id"],
    title: json["title"],
    author: authorValues.map[json["author"]]!,
    source: json["source"],
    publishTime: DateTime.parse(json["publish_time"]),
    category: categoryValues.map[json["category"]]!,
    thumbnail: json["thumbnail"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "author": authorValues.reverse[author],
    "source": source,
    "publish_time": "${publishTime.year.toString().padLeft(4, '0')}-${publishTime.month.toString().padLeft(2, '0')}-${publishTime.day.toString().padLeft(2, '0')}",
    "category": categoryValues.reverse[category],
    "thumbnail": thumbnail,
  };
}

enum Author {
  ALEKSEI_BLOKHIN,
  ANDRII_SOKOLOVSKYI,
  GEORGY_TZEPKOVSKY,
  KINGSLEY,
  KOSTA_KNIG,
  MEGHNA_1819,
  MICHAEL_ELLIS,
  NDINE,
  TOBY_PRINCE,
  UTTIYO_SCARNAGE
}

final authorValues = EnumValues({
  "Aleksei Blokhin": Author.ALEKSEI_BLOKHIN,
  "Andrii Sokolovskyi": Author.ANDRII_SOKOLOVSKYI,
  "Georgy Tzepkovsky": Author.GEORGY_TZEPKOVSKY,
  "Kingsley_": Author.KINGSLEY,
  "Kosta König": Author.KOSTA_KNIG,
  "Meghna @ 1819": Author.MEGHNA_1819,
  "Michael Ellis": Author.MICHAEL_ELLIS,
  "Nаdine": Author.NDINE,
  "Toby Prince": Author.TOBY_PRINCE,
  "Uttiyo Scarnage": Author.UTTIYO_SCARNAGE
});

enum Category {
  INJURY_UPDATE,
  MANAGER_NEWS,
  MATCH_RESULT,
  THOUGHTS,
  TRANSFER
}

final categoryValues = EnumValues({
  "Injury Update": Category.INJURY_UPDATE,
  "Manager News": Category.MANAGER_NEWS,
  "Match Result": Category.MATCH_RESULT,
  "Thoughts": Category.THOUGHTS,
  "Transfer": Category.TRANSFER
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
