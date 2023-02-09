class KeyValueData {
  String id;
  String reason;

  KeyValueData({
    required this.id,
    required this.reason,
  });

  Map<String, String> toJson() {
    return {
      'id': id,
      'alasan': reason,
    };
  }
}
