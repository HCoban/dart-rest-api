import 'dart:convert';

/// Class encapsulating a [RecipientItem].
class RecipientItem {
  /// The msisdn of the recipient.
  int recipient;

  /// The status of the message sent to the recipient. See [RecipientItemStatus]
  /// for allowed values.
  RecipientItemStatus status;

  /// The datum time of the last status in RFC3339 format (Y-m-d\TH:i:sP)
  DateTime statusDatetime;

  /// Constructor.
  RecipientItem({
    this.recipient,
    this.statusDatetime,
  });

  /// Construct an [RecipientItem] object from a json [String].
  factory RecipientItem.fromJson(String source) {
    final decoded = json.decode(source)['data'];
    if (decoded is List<dynamic> && decoded.length != 1) {
      throw Exception('Tried to decode a single object from a list of '
          'multiple objects. Use function "fromJsonList" instead');
    }
    return RecipientItem.fromMap(
        decoded == null ? json.decode(source) : decoded[0]);
  }

  /// Construct a [RecipientItem] object from a [Map].
  factory RecipientItem.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : RecipientItem(
          recipient: int.parse(map['recipient'].toString()),
          statusDatetime: DateTime.parse(map['statusDatetime']),
        );

  /// Get a json [String] representing the [RecipientItem].
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'recipient': recipient,
        'statusDatetime': statusDatetime,
      };
}

/// Enumeration of [RecipientItem] statusses.
enum RecipientItemStatus {
  /// The message is scheduled.
  scheduled,

  /// The message has been sent.
  sent,

  /// The message is buffered.
  buffered,

  /// The message has been delivered.
  delivered,

  /// The message is expired.
  expired,

  /// The delivery of the message failed.
  // ignore: constant_identifier_names
  delivery_failed
}

/// Class encapsulating [Recipients].
class Recipients {
  ///	The total count of recipients.
  int totalCount;

  /// The count of recipients that have the message pending (status `sent` and
  /// `buffered`).
  int totalSendCount;

  /// The count of recipients where the message is delivered (status
  /// `delivered`).
  int totalDeliveredCount;

  /// The count of recipients where the delivery has failed (status
  /// `delivery_failed`).
  int totalDeliveryFailedCount;

  /// A list of recipients.
  List<RecipientItem> items;

  /// Constructor.
  Recipients({
    this.totalCount,
    this.totalSendCount,
    this.totalDeliveredCount,
    this.totalDeliveryFailedCount,
    this.items,
  });

  /// Construct an [Recipients] object from a json [String].
  factory Recipients.fromJson(String source) =>
      Recipients.fromMap(json.decode(source));

  /// Construct a [Recipients] object from a [Map].
  factory Recipients.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : Recipients(
          totalCount: map['totalCount'],
          totalSendCount: map['totalSendCount'],
          totalDeliveredCount: map['totalDeliveredCount'],
          totalDeliveryFailedCount: map['totalDeliveryFailedCount'],
          items: List<RecipientItem>.from(
              map['items']?.map((item) => RecipientItem.fromMap(item))),
        );

  /// Get a json [String] representing the [Recipients] object.
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'totalCount': totalCount,
        'totalSendCount': totalSendCount,
        'totalDeliveredCount': totalDeliveredCount,
        'totalDeliveryFailedCount': totalDeliveryFailedCount,
        'items': List<RecipientItem>.from(items.map((item) => item.toMap())),
      };
}
