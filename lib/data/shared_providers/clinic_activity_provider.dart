import 'package:clerkship/data/models/dropdown_item.dart';
import 'package:clerkship/ui/components/buttons/file_picker_button.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../network/services/clinic_activity_service.dart';

class ClinicActivityProvider extends ChangeNotifier {
  final clinicActivityService = getIt<ClinicActivityService>();

  void addClinicActivity({
    required DateTime tanggal,
    required TimeOfDay jam,
    required DropDownItem departemen,
    required List<DropDownItem> jenisKegiatan,
    DropDownItem? preseptor,
    List<DropDownItem>? penyakit,
    List<DropDownItem>? keterampilan,
    List<DropDownItem>? prosedur,
    List<DropDownItem>? gejala,
    TextSelection? catatan,
    List<SelectedFile>? lampiran,
  }) async {
    // var tanggal = tanggal.formatDate('yyyy-MM-dd');
  }
}
