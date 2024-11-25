// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:hl_image_picker/hl_image_picker.dart' as hl_image_picker;
import 'package:image_cropper/image_cropper.dart' as image_cropper;
import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:image_picker_totalxsoftware/enum/crop_aspect_ratio_preset.dart';
import 'package:image_picker_totalxsoftware/service/map_aspect_ratio_preset.dart';

export 'image_picker_totalxsoftware.dart';

class ImagePickerTotalxsoftware {
  static final _imagePicker = image_picker.ImagePicker();
  static final _storage = FirebaseStorage.instance;

  static Future<String?> pickImage({
    ImageSource source = ImageSource.gallery,
    required void Function(String e) onError,
  }) async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: source == ImageSource.camera
            ? image_picker.ImageSource.camera
            : image_picker.ImageSource.gallery,
      );
      if (pickedFile == null) return null;

      final path = pickedFile.path;
      return path;
    } catch (e) {
      onError(e.toString());
      return null;
    }
  }

  static Future<List<String>> pickMultipleImage(
    BuildContext context, {
    required int maxImageCount,
    int? minImageCount,
    List<String>? selectedImages,
    required void Function(String e) onError,
  }) async {
    try {
      final picker = hl_image_picker.HLImagePicker();

      final pickedFiles = await picker.openPicker(
          selectedIds: selectedImages,
          pickerOptions: hl_image_picker.HLPickerOptions(
            maxSelectedAssets: maxImageCount,
            minSelectedAssets: minImageCount,
            mediaType: hl_image_picker.MediaType.image,
          ),
          cropping: false);

      if (pickedFiles.isEmpty) return [];

      final pathList = pickedFiles.map((e) => e.path).toList();

      return pathList;
    } catch (e) {
      onError(e.toString());
      return [];
    }
  }

  static Future<List<String>> pickMultipleImageAndCrop(
    BuildContext context, {
    required int maxImageCount,
    int? minImageCount,
    List<CropAspectRatioPreset> aspectRatioPresets = const [
      CropAspectRatioPreset.square,
    ],
    CropStyle cropStyle = CropStyle.rectangle,
    required void Function(String e) onError,
  }) async {
    try {
      final picker = hl_image_picker.HLImagePicker();

      final pickedFiles = await picker.openPicker(
        pickerOptions: hl_image_picker.HLPickerOptions(
          maxSelectedAssets: maxImageCount,
          minSelectedAssets: minImageCount,
          mediaType: hl_image_picker.MediaType.image,
        ),
        cropping: true,
        cropOptions: hl_image_picker.HLCropOptions(
            aspectRatioPresets: aspectRatioPresets
                .map((e) => hlmapAspectRatioPreset(e.name))
                .toList(),
            croppingStyle: cropStyle == CropStyle.circle
                ? hl_image_picker.CroppingStyle.circular
                : hl_image_picker.CroppingStyle.normal),
      );

      if (pickedFiles.isEmpty) return [];

      final pathList = pickedFiles.map((e) => e.path).toList();

      return pathList;
    } catch (e) {
      onError(e.toString());
      return [];
    }
  }

  static Future<String?> pickAndCropImage(
    BuildContext context, {
    ImageSource source = ImageSource.gallery,
    List<CropAspectRatioPreset> aspectRatioPresets = const [
      CropAspectRatioPreset.square
    ],
    CropStyle cropStyle = CropStyle.rectangle,
    required void Function(String e) onError,
  }) async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: source == ImageSource.camera
            ? image_picker.ImageSource.camera
            : image_picker.ImageSource.gallery,
      );
      if (pickedFile == null) return null;

      final path = pickedFile.path;
      final cropPath = await cropImage(
        context,
        path: path,
        aspectRatioPresets: aspectRatioPresets,
        cropStyle: cropStyle,
        onError: onError,
      );
      return cropPath;
    } catch (e) {
      onError(e.toString());
      return null;
    }
  }

  static Future<String?> pickAndUploadToFirebaseStorage(
    BuildContext context, {
    ImageSource source = ImageSource.gallery,
    required String storagePath,
    Size compressSize = const Size(720, 1280),
    required void Function(String e) onError,
  }) async {
    try {
      final path = await pickImage(
        source: source,
        onError: onError,
      );
      if (path == null) return null;

      final url = await uploadToFirebaseStorage(
        compressSize: compressSize,
        storagePath: storagePath,
        filepath: path,
        onError: onError,
      );
      return url;
    } catch (e) {
      onError(e.toString());
      return null;
    }
  }

  static Future<String?> pickCropAndUploadToFirebaseStorage(
    BuildContext context, {
    ImageSource source = ImageSource.gallery,
    required String storagePath,
    List<CropAspectRatioPreset> aspectRatioPresets = const [
      CropAspectRatioPreset.square
    ],
    CropStyle cropStyle = CropStyle.rectangle,
    Size compressSize = const Size(720, 1280),
    required void Function(String e) onError,
  }) async {
    try {
      final path = await pickImage(
        source: source,
        onError: onError,
      );
      if (path == null) return null;

      final cropPath = await cropImage(
        context,
        path: path,
        aspectRatioPresets: aspectRatioPresets,
        cropStyle: cropStyle,
        onError: onError,
      );
      if (cropPath == null) return null;

      final url = await uploadToFirebaseStorage(
        compressSize: compressSize,
        storagePath: storagePath,
        filepath: cropPath,
        onError: onError,
      );
      return url;
    } catch (e) {
      onError(e.toString());
      return null;
    }
  }

  static Future<String?> uploadToFirebaseStorage({
    required String storagePath,
    Size compressSize = const Size(720, 1280),
    required String filepath,
    required void Function(String e) onError,
  }) async {
    try {
      final imageList = await uploadMultipleToFirebaseStorage(
        storagePath: storagePath,
        filepathList: [filepath],
        onError: onError,
      );
      return imageList.first;
    } on Exception catch (e) {
      onError(e.toString());
      return null;
    }
  }

  static Future<List<String>> uploadMultipleToFirebaseStorage({
    required String storagePath,
    Size compressSize = const Size(720, 1280),
    required List<String> filepathList,
    required void Function(String e) onError,
  }) async {
    try {
      final byteList = await Future.wait(
        filepathList.map((e) async => await File(e).readAsBytes()),
      );

      final compressedImages = await Future.wait(
        byteList.map(
          (bytes) async => await FlutterImageCompress.compressWithList(
            bytes,
            quality: 70,
            minHeight: compressSize.height.toInt(),
            minWidth: compressSize.width.toInt(),
            inSampleSize: 2,
          ),
        ),
      );

      final uploadTasks = compressedImages.map((data) {
        final ref = _storage
            .ref(storagePath)
            .child('${Timestamp.now().microsecondsSinceEpoch}.jpeg');
        return ref.putData(data, SettableMetadata(contentType: 'image/jpeg'));
      }).toList();

      final snapshotList = await Future.wait(uploadTasks);
      final downloadUrls = await Future.wait(
          snapshotList.map((snap) => snap.ref.getDownloadURL()));

      return downloadUrls;
    } on FirebaseException catch (e) {
      onError('uploadMultipleToFirebaseStorage() ${e.message}');
      return [];
    } catch (e) {
      onError('uploadMultipleToFirebaseStorage() $e');
      return [];
    }
  }

  static Future<void> deleteImageFromFirebaseByUrl(
    String imageUrl,
  ) async {
    try {
      await deleteMultipleImagesFromFirebaseByUrls([imageUrl]);
    } catch (e) {
      throw Exception('deleteImageFromFirebaseByUrl() $e');
    }
  }

  static Future<void> deleteMultipleImagesFromFirebaseByUrls(
    List<String> imageUrlList,
  ) async {
    if (imageUrlList.isEmpty) return;

    try {
      final functionList =
          imageUrlList.map((url) => _checkAndDeleteImage(url)).toList();
      await Future.wait(functionList);
      log('Images deleted successfully');
    } catch (e) {
      throw Exception('deleteMultipleImagesFromFirebaseByUrls() $e');
    }
  }

  static Future<void> _checkAndDeleteImage(String imageUrl) async {
    try {
      await _storage.refFromURL(imageUrl).delete();
    } on FirebaseException catch (e) {
      if (e.code != 'object-not-found') {
        throw Exception('deleteImage() ${e.message}');
      }
    } catch (e) {
      throw Exception('deleteImage() $e');
    }
  }

  static Future<String?> cropImage(
    BuildContext context, {
    required String path,
    List<CropAspectRatioPreset> aspectRatioPresets = const [
      CropAspectRatioPreset.square,
    ],
    CropStyle cropStyle = CropStyle.rectangle,
    required void Function(String e) onError,
  }) async {
    // Helper function to map aspect ratio preset names to the appropriate values

    try {
      final croppedFile = await image_cropper.ImageCropper().cropImage(
        sourcePath: path,
        uiSettings: [
          image_cropper.AndroidUiSettings(
            initAspectRatio:
                mapAspectRatioPreset(aspectRatioPresets.first.name),
            cropStyle: cropStyle == CropStyle.circle
                ? image_cropper.CropStyle.circle
                : image_cropper.CropStyle.rectangle,
            toolbarTitle: 'Crop',
            aspectRatioPresets: aspectRatioPresets
                .map((e) => mapAspectRatioPreset(e.name))
                .toList(),
          ),
          image_cropper.IOSUiSettings(
            title: 'Crop',
            cropStyle: cropStyle == CropStyle.circle
                ? image_cropper.CropStyle.circle
                : image_cropper.CropStyle.rectangle,
            aspectRatioPresets: aspectRatioPresets
                .map((e) => mapAspectRatioPreset(e.name))
                .toList(),
          ),
          image_cropper.WebUiSettings(
            context: context,
          ),
        ],
      );
      return croppedFile?.path;
    } catch (e) {
      onError('$e');
      return null;
    }
  }
}

enum ImageSource {
  camera,
  gallery,
}

enum CropStyle {
  rectangle,
  circle;
}
