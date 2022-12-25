import 'dart:io';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../utils/dialog_helper.dart';
import '../../components/buttons/ripple_button.dart';
import '../../components/commons/primary_appbar.dart';

class CropImageScreen extends StatefulWidget {
  final File imageFile;

  const CropImageScreen({
    super.key,
    required this.imageFile,
  });

  @override
  CropImageScreenState createState() => CropImageScreenState();
}

class AspectRatio {
  String title;
  double aspectRatio;
  bool selected;

  AspectRatio({
    required this.title,
    required this.aspectRatio,
    this.selected = false,
  });
}

class CropImageScreenState extends State<CropImageScreen> {
  Size? imageSize;
  CropController controller = CropController();
  ValueNotifier<List<AspectRatio>> aspectRatios = ValueNotifier([
    AspectRatio(
      title: 'Square',
      aspectRatio: 1,
      selected: true,
    ),
    AspectRatio(
      title: '3:2',
      aspectRatio: 2 / 3,
    ),
    AspectRatio(
      title: '4:3',
      aspectRatio: 3 / 4,
    ),
    AspectRatio(
      title: '5:3',
      aspectRatio: 3 / 5,
    ),
    AspectRatio(
      title: '5:4',
      aspectRatio: 4 / 5,
    ),
    AspectRatio(
      title: '7:5',
      aspectRatio: 4 / 5,
    ),
    AspectRatio(
      title: '16:9',
      aspectRatio: 9 / 16,
    ),
  ]);

  @override
  void initState() {
    super.initState();
    try {
      imageSize = ImageSizeGetter.getSize(FileInput(widget.imageFile));
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          PrimaryAppBar(
            title: 'Crop Image',
            action: const Icon(
              Icons.done_rounded,
              color: Themes.primary,
              size: 28,
            ).onTap(() async {
              DialogHelper.showProgressDialog();
              controller.crop();
            }),
          ),
          Crop(
            maskColor: Colors.black.withOpacity(0.5),
            baseColor: Colors.black,
            aspectRatio: 1,
            onCropped: (image) async {
              File writtedImage = File(
                  '${(await getTemporaryDirectory()).path}/IMG_${DateTime.now().millisecondsSinceEpoch}.jpg');
              await writtedImage.writeAsBytes(image);

              File? result = await FlutterImageCompress.compressAndGetFile(
                writtedImage.absolute.path,
                '${(await getTemporaryDirectory()).path}/IMG_${DateTime.now().millisecondsSinceEpoch}.jpg',
                quality: 75,
              );

              if (mounted) {
                Navigator.pop(context);
                Navigator.pop(context, result);
              }
            },
            controller: controller,
            image: widget.imageFile.readAsBytesSync(),
          ).addExpanded,
          ValueListenableBuilder<List<AspectRatio>>(
            valueListenable: aspectRatios,
            builder: (context, data, _) {
              return Container(
                height: 68.h,
                color: Colors.white,
                child: ListView.builder(
                  padding: EdgeInsets.all(18.w),
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    AspectRatio aspectRatio = data[index];

                    return RippleButton(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.h,
                        horizontal: 12.w,
                      ),
                      radius: 32.w,
                      color:
                          aspectRatio.selected ? Themes.primary : Themes.white,
                      border: Border.all(color: Themes.stroke),
                      onTap: () {
                        for (AspectRatio ar in data) {
                          ar.selected = false;
                        }
                        aspectRatio.selected = true;
                        controller.aspectRatio = aspectRatio.aspectRatio;

                        aspectRatios.value = List.from(aspectRatios.value);
                      },
                      text: aspectRatio.title,
                      textColor:
                          aspectRatio.selected ? Themes.white : Themes.black,
                    ).addMarginRight(12.w);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
