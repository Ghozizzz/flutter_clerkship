class SurveyKeyValueData {
  String id;
  String jenisSurvey;
  String reason;

  SurveyKeyValueData({
    required this.id,
    required this.jenisSurvey,
    required this.reason,
  });

  Map<String, String> toJson({
    String? keyTitle,
    String? jenisTitle,
    String? valueTitle,
  }) {
    return {
      keyTitle ?? 'id': id,
      jenisTitle ?? 'jenis_survey': jenisSurvey,
      valueTitle ?? 'alasan': reason,
    };
  }
}
