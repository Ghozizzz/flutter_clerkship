class Quiz {
  String title;
  String id;
  bool selected;

  Quiz({
    required this.title,
    required this.id,
    this.selected = false,
  });
}
