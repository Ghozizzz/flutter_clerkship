class KeyValueData {
  String id;
  String reason;

  KeyValueData({
    required this.id,
    required this.reason,
  });

  Map<String, String> toJson({
    String? keyTitle,
    String? valueTitle,
  }) {
    return {
      keyTitle ?? 'id': id,
      valueTitle ?? 'alasan': reason,
    };
  }
}
