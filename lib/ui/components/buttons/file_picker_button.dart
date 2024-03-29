import 'dart:io';

import 'package:another_dashed_container/another_dashed_container.dart';
import 'package:clerkship/config/themes.dart';
import 'package:clerkship/r.dart';
import 'package:clerkship/ui/components/commons/flat_card.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mime/mime.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';
import 'package:path_provider/path_provider.dart';

import '../../screens/crop/crop_image_screen.dart';
import 'ripple_button.dart';

class SelectedFile {
  String id;
  File file;

  SelectedFile({
    required this.id,
    required this.file,
  });
}

class FilePickerController extends ValueNotifier<List<SelectedFile>> {
  List<SelectedFile> selectedFiles = [];

  FilePickerController() : super([]);

  void addFile(File file, {dynamic id}) {
    selectedFiles.add(
      SelectedFile(
        id: id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        file: file,
      ),
    );
    notifyListeners();
  }

  void removeFile(SelectedFile selected) {
    selectedFiles.removeWhere((element) => element.id == selected.id);
    notifyListeners();
  }
}

class FilePickerButton extends StatelessWidget {
  final bool onlyImage;
  final FilePickerController controller;
  final Function? onDelete;

  const FilePickerButton({
    super.key,
    required this.controller,
    this.onDelete,
    this.onlyImage = false,
  });

  Future<Directory?> getLocalDirectory() async {
    return Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationSupportDirectory();
  }

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);

    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, __, _) {
        return Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              primary: true,
              shrinkWrap: true,
              itemCount: controller.selectedFiles.length,
              itemBuilder: (context, index) {
                final file = controller.selectedFiles[index];

                return FlatCard(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(12.w),
                        child: SvgPicture.asset(
                          AssetIcons.icAttachment,
                          width: 20.w,
                        ),
                      ),
                      Text(
                        file.file.path.split('/').last,
                        style: Themes().black12,
                      ).addExpanded,
                      RippleButton(
                        padding: EdgeInsets.all(12.w),
                        onTap: () {
                          onDelete!(file);
                          controller.removeFile(file);
                          debugPrint('DiDelete');
                        },
                        child: SvgPicture.asset(
                          AssetIcons.icDelete,
                          width: 20.w,
                          color: Themes.red,
                        ),
                      ),
                    ],
                  ),
                ).addMarginBottom(8);
              },
            ),
            DashedContainer(
              borderRadius: 8,
              dashColor: Themes.stroke,
              strokeWidth: 1.4,
              dashedLength: 6,
              child: RippleButton(
                onTap: () async {
                  String? path = await FilesystemPicker.open(
                    context: context,
                    fileTileSelectMode: FileTileSelectMode.wholeTile,
                    fsType: FilesystemType.file,
                    requestPermission: () {
                      return Permission.storage.request().isGranted;
                    },
                    rootDirectory: Directory('/storage/emulated/0'),
                    // rootDirectory: Directory(getLocalDirectory()),
                  );
                  if (path != null) {
                    final mimeType = lookupMimeType(path);
                    if (mimeType?.contains('image') ?? false) {
                      File? croppedFile = await navigator.push(
                        MaterialPageRoute(
                          builder: (context) => CropImageScreen(
                            imageFile: File(path),
                          ),
                        ),
                      );

                      if (croppedFile == null) return;
                      controller.addFile(croppedFile);
                    } else {
                      controller.addFile(File(path));
                    }
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pilih file',
                      style: Themes().gray12?.withColor(Themes.hint),
                    ),
                    SvgPicture.asset(
                      AssetIcons.icAttachment,
                      width: 20.w,
                      height: 20.w,
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
