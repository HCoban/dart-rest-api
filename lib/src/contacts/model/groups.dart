import 'dart:convert';

/// Class encapsulating a [Groups] object.
class Groups {
  /// The total count of groups that contact belongs to.
  int totalCount;

  /// URL which can be used to retrieve list of groups contact belongs to.
  String href;

  /// Constructor.
  Groups({
    this.totalCount,
    this.href,
  });

  /// Construct an [Groups] object from a json [String].
  factory Groups.fromJson(String source) {
    final decoded = json.decode(source)['data'];
    if (decoded is List<dynamic> && decoded.length != 1) {
      throw Exception('Tried to decode a single object from a list of '
          'multiple objects. Use function "fromJsonList" instead');
    }
    return Groups.fromMap(decoded == null ? json.decode(source) : decoded[0]);
  }

  /// Construct a [Groups] object from a [Map].
  factory Groups.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : Groups(
          totalCount: map['totalCount'],
          href: map['href'],
        );

  /// Get a json [String] representing the [Groups].
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'totalCount': totalCount,
        'href': href,
      };
}
