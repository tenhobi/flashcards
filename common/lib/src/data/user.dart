import 'dart:convert';

import 'package:flashcards_common/src/data/data.dart';
import 'package:meta/meta.dart';

class LinkType {
  static const LinkType facebook = LinkType._(0, "https://facebook.com/");
  static const LinkType twitter = LinkType._(1, "https://twitter.com/");
  static const LinkType github = LinkType._(2, "https://github.com/");

  static List<LinkType> get values => [facebook, twitter, github];
  static List<String> get names => ['facebook', 'twitter', 'github'];

  final int value;
  final String baseUrl;

  @override
  String toString() => '$value';

  String linkName() => LinkType.names[value];

  Map<String, dynamic> toJson() => {'value': '$value'};

  factory LinkType.fromJson(String data) => LinkType.values[int.parse(data)];

  const LinkType._(this.value, this.baseUrl);
}

class FilledLinkType {
  final LinkType linkType;
  final String value;

  FilledLinkType({@required this.linkType, @required this.value});

  factory FilledLinkType.fromJson(Map<String, dynamic> data) => FilledLinkType(
        linkType: LinkType.values[data['linkType']],
        value: data['value'],
      );

  FilledLinkType copyWith({LinkType linkType, String value}) => FilledLinkType(
        linkType: linkType ?? this.linkType,
        value: value ?? this.value,
      );

  Map<String, dynamic> toJson() {
    return {
      'linkType': linkType.value,
      'value': '$value',
    };
  }

  String link() {
    return "${linkType.baseUrl}$value";
  }
}

class UserData extends Data {
  final String uid;
  final int score;
  final String language;
  final String name;
  final String bio;
  final List<FilledLinkType> links;
  final String photoUrl;

  UserData({
    @required this.uid,
    @required this.name,
    this.language = 'en_US',
    this.score = 0,
    this.bio = "",
    this.links = const [],
    this.photoUrl = "",
  });

  factory UserData.fromMap(Map<String, dynamic> data) {
    var list = <FilledLinkType>[];

    if (data['links'] != null) {
      List<dynamic> d = json.decode(data['links']);

      for (var val in d) {
        list.add(FilledLinkType.fromJson(val));
      }
    }

    return UserData(
      uid: data['uid'],
      name: data['name'],
      score: data['score'],
      language: data['language'],
      bio: data['bio'] ?? "",
      links: list ?? [],
      photoUrl: data["photoUrl"] ?? "",
    );
  }

  @override
  UserData copyWith({
    String uid,
    int score,
    String language,
    String name,
    String photoUrl,
    String bio,
    List<FilledLinkType> links,
  }) =>
      UserData(
        uid: uid ?? this.uid,
        score: score ?? this.score,
        language: language ?? this.language,
        name: name ?? this.name,
        bio: bio ?? this.bio,
        links: links ?? this.links,
        photoUrl: photoUrl ?? this.photoUrl,
      );

  @override
  Map<String, dynamic> toMap() {
    final links = json.encode(this.links);
    return {
      'uid': '$uid',
      'name': '$name',
      'score': score,
      'language': '$language',
      'bio': '$bio',
      'links': '$links',
      'photoUrl': '$photoUrl',
    };
  }
}
