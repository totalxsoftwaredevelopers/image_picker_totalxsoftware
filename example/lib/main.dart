import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker_totalxsoftware/enum/crop_aspect_ratio_preset.dart';
import 'package:image_picker_totalxsoftware/image_picker_totalxsoftware.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Image Picker and Uploader'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              // pick image
              ElevatedButton(
                onPressed: () async {
                  final file = await ImagePickerTotalxsoftware.pickImage(
                    source: ImageSource.gallery,
                    onError: (e) {
                      log(e);
                    },
                  );

                  if (file != null) {
                    log(file);
                  }
                },
                child: const Text('Pick Image'),
              ),
              const SizedBox(height: 10),
              // pick and crop image
              ElevatedButton(
                onPressed: () async {
                  final path = await ImagePickerTotalxsoftware.pickAndCropImage(
                    context,
                    aspectRatioPresets: [
                      CropAspectRatioPreset.ratio7x5,
                      CropAspectRatioPreset.square,
                    ],
                    onError: (e) {
                      log(e);
                    },
                  );
                  if (path != null) {
                    log(path);
                  }
                },
                child: const Text('Pick Image and Crop'),
              ),
              const SizedBox(height: 10),
              // pick and upload to firebase storage
              ElevatedButton(
                onPressed: () async {
                  final url = await ImagePickerTotalxsoftware
                      .pickAndUploadToFirebaseStorage(
                    context,
                    storagePath: 'images',
                    onError: (e) {
                      log(e);
                    },
                  );
                  if (url != null) {
                    log(url);
                  }
                },
                child: const Text(
                    'Pick Image and Upload to Firebase Storage'),
              ),
              const SizedBox(height: 10),
              // pick crop and upload to firebase storage
              ElevatedButton(
                onPressed: () async {
                  final url = await ImagePickerTotalxsoftware
                      .pickCropAndUploadToFirebaseStorage(
                    context,
                    storagePath: 'images',
                    cropStyle: CropStyle.circle,
                    onError: (e) {
                      log(e);
                    },
                  );
                  if (url != null) {
                    log(url);
                  }
                },
                child: const Text(
                    'Pick Image and Crop and Upload to Firebase Storage',textAlign: TextAlign.center,),
              ),

              const SizedBox(height: 10),
              //pickMultipleImage
              ElevatedButton(
                onPressed: () async {
                  final paths =
                      await ImagePickerTotalxsoftware.pickMultipleImage(
                    context,
                    maxImageCount: 5,
                    onError: (e) {
                      log(e);
                    },
                  );
                  if (paths.isNotEmpty) {
                    log(paths.toString());
                  }
                },
                child: const Text('Pick Multiple Image'),
              ),
              const SizedBox(height: 10),
              //pickMultipleImageAndCrop
              ElevatedButton(
                onPressed: () async {
                  final paths =
                      await ImagePickerTotalxsoftware.pickMultipleImageAndCrop(
                    context,
                    maxImageCount: 5,
                    // minImageCount: 2,
                    aspectRatioPresets: [
                      CropAspectRatioPreset.ratio7x5,
                      CropAspectRatioPreset.ratio4x3,
                    ],
                    cropStyle: CropStyle.rectangle,
                    onError: (e) {
                      log(e);
                    },
                  );
                  if (paths.isNotEmpty) {
                    log(paths.toString());
                  }
                },
                child: const Text('Pick Multiple Image And Crop'),
              ),
              const SizedBox(height: 10),

              // upload to firebase storage
              ElevatedButton(
                onPressed: () async {
                  final url =
                      await ImagePickerTotalxsoftware.uploadToFirebaseStorage(
                    filepath: 'path/to/file.png',
                    // compressSize: const Size(720, 1280),
                    storagePath: 'images',
                    onError: (e) {
                      log(e);
                    },
                  );
                  if (url != null) {
                    log(url);
                  }
                },
                child: const Text(
                  'Upload Image to Firebase Storage',
                ),
              ),
              const SizedBox(height: 10),
              // upload multiple to firebase storage
              ElevatedButton(
                onPressed: () async {
                  final urls = await ImagePickerTotalxsoftware
                      .uploadMultipleToFirebaseStorage(
                    filepathList: [
                      'path/to/file1.png',
                      'path/to/file2.png',
                      'path/to/file3.png',
                    ],
                    // compressSize: const Size(720, 1280),
                    storagePath: 'images',
                    onError: (e) {
                      log(e);
                    },
                  );
                  if (urls.isNotEmpty) {
                    log(urls.toString());
                  }
                },
                child: const Text(
                  'Upload Multiple Images to Firebase Storage',
                ),
              ),

              const SizedBox(height: 10),
              // delete image from firebase
              ElevatedButton(
                onPressed: () async {
                  try {
                    await ImagePickerTotalxsoftware
                        .deleteImageFromFirebaseByUrl('url');
                  } on Exception catch (e) {
                    log(e.toString());
                  }
                },
                child: const Text(
                  'Delete Image from Firebase Storage',
                ),
              ),

              const SizedBox(height: 10),
              // delete multiple images from firebase
              ElevatedButton(
                onPressed: () async {
                  try {
                    await ImagePickerTotalxsoftware
                        .deleteMultipleImagesFromFirebaseByUrls([
                      'url1',
                      'url2',
                      'url3',
                    ]);
                  } on Exception catch (e) {
                    log(e.toString());
                  }
                },
                child: const Text(
                  'Delete Multiple Images from Firebase Storage',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
