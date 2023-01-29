import 'package:flutter/foundation.dart';

class StandartCompetencyLectureProvider extends ChangeNotifier {
  final Map<String, List<String>> data = {
    '': List.generate(12, (index) => 'Ilmu Penyakit Dalam'),
    'Ilmu Penyakit Dalam': List.generate(4, (index) => 'Daftar Penyakit'),
    'Daftar Penyakit': List.generate(9, (index) => 'Respirasi'),
    'Respirasi': List.generate(9, (index) => 'Influenza'),
  };
  final paths = [];
  int index = 0;

  void removeLastPath() {
    paths.removeAt(paths.length - 1);
    notifyListeners();
  }

  void setIndex(int index, String title) {
    this.index = index;
    paths.add(title);
    notifyListeners();
  }

  void clearPaths() {
    paths.clear();
    notifyListeners();
  }
}
