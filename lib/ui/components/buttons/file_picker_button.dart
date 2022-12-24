import 'dart:io';

import 'package:clerkship/config/themes.dart';
import 'package:clerkship/r.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mime/mime.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive/responsive.dart';

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
  final List<SelectedFile> selectedFiles = [];

  FilePickerController() : super([]);

  void addFile(File file) {
    selectedFiles.add(
      SelectedFile(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
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

  const FilePickerButton({
    super.key,
    required this.controller,
    this.onlyImage = false,
  });

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);

    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, __, _) {
        return RippleButton(
          border: Border.all(color: Themes.stroke),
          onTap: () async {
            String? path = await FilesystemPicker.open(
              context: context,
              fileTileSelectMode: FileTileSelectMode.wholeTile,
              fsType: FilesystemType.file,
              requestPermission: () {
                return Permission.storage.request().isGranted;
              },
              rootDirectory: Directory('/storage/emulated/0'),
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
        );
      },
    );
  }
}
