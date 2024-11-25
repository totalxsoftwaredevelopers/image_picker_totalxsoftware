# Image Picker TotalXSoftware

<a href="https://totalx.in">
<img alt="Launch Totalx" src="https://totalx.in/assets/logo-k3HH3X3v.png">
</a>

<p><strong>Developed by <a rel="noopener" target="_new" style="--streaming-animation-state: var(--batch-play-state-1); --animation-rate: var(--batch-play-rate-1);" href="https://totalx.in"><span style="--animation-count: 18; --streaming-animation-state: var(--batch-play-state-2);">Totalx Software</span></a></strong></p>

---

## Introduction

`ImagePickerTotalxsoftware` is a Flutter package for handling advanced image picking, cropping, compressing, and uploading functionalities with Firebase integration. This package simplifies the process of selecting, cropping, and uploading images to Firebase Storage.

---

## Features

- `Single Image Selection`: Choose a single image from the camera or gallery.
- `Multiple Image Selection`: Select multiple images at once.
- `Image Cropping`: Crop selected images with custom aspect ratios.
- `Firebase Upload`: Upload images directly to Firebase Storage.
- `Image Compression`: Compress images before uploading.
- `Image Deletion`: Delete single or multiple images from Firebase Storage.

---

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  image_picker_totalxsoftware: ^1.0.0
```

## Usage

### Import the Package

```yaml
import 'package:image_picker_totalxsoftware/image_picker_totalxsoftware.dart';
```

## Permissions
### Android
Add the following permissions to your `AndroidManifest.xml`:

```xml

<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-feature android:name="android.hardware.camera" android:required="false" />
<uses-permission android:name="android.permission.CAMERA" />
```
### iOS

Add the following keys to your `Info.plist` file:

```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>We need access to your photo library to pick images.</string>
<key>NSCameraUsageDescription</key>
<string>We need access to your camera to take photos.</string>

<!-- <key>NSPhotoLibraryAddUsageDescription</key>
<string>We need permission to save edited images to your photo library.</string> -->
```

## Examples

#### 1. Single Image Picker

```dart
// file path

String? imagePath = await ImagePickerTotalxsoftware.pickImage(
  source: ImageSource.gallery,
  onError: (error) {
    print("Error picking image: $error");
  },
);

```

---

#### 2. Single Image Picker And Crop

```dart
// file path

String? path = await ImagePickerTotalxsoftware.pickAndCropImage(
    context,
    aspectRatioPresets: [
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.square,
    ],
    onError: (e) {
        log(e);
    },
);

```

---

#### 3. Multiple Image Picker

```dart
// List of file paths

final paths = await ImagePickerTotalxsoftware.pickMultipleImage(
    context,
    maxImageCount: 5,
        // minImageCount: 2,
    onError: (e) {
        log(e);
    },
);


```

---

#### 4. Multiple Image Picker with Cropping

```dart
// List of file paths

final paths = await ImagePickerTotalxsoftware.pickMultipleImageAndCrop(
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

```

---

#### 5. Pick and Upload Single Image to Firebase Storage

```dart
// String url

String? uploadedUrl = await ImagePickerTotalxsoftware.pickAndUploadToFirebaseStorage(
  context,
  source: ImageSource.gallery,
  storagePath: 'usersImages',
  onError: (error) {
    print("Error uploading image: $error");
  },
);

```

---

#### 6. Pick, Crop, and Upload Image to Firebase Storage

```dart
// String url

String? uploadedUrl = await ImagePickerTotalxsoftware.pickCropAndUploadToFirebaseStorage(
  context,
  source: ImageSource.gallery,
  storagePath: 'usersImages',
  cropStyle: CropStyle.circle,
  onError: (error) {
    print("Error uploading cropped image: $error");
  },
);

```

---
#### 7. Upload an Image to Firebase Storage

```dart
// String url
String? url =await ImagePickerTotalxsoftware.uploadToFirebaseStorage(
    filepath: 'path/to/file.png',
    // compressSize: const Size(720, 1280),
    storagePath: 'images',
    onError: (e) {
     log(e);
    },
);

```

---
#### 8. Upload Multiple Images to Firebase Storage

```dart
// List of urls

List<String> uploadedUrls = await ImagePickerTotalxsoftware.uploadMultipleToFirebaseStorage(
  filepathList: ['path/to/image1.jpeg', 'path/to/image2.jpeg'],
  storagePath: 'images',
  onError: (error) {
    print("Error uploading multiple images: $error");
  },
);

```
---

#### 9. Delete a Single Image from Firebase Storage

```dart

try {
    
    await ImagePickerTotalxsoftware.deleteImageFromFirebaseByUrl(
    'https://firebasestorage.googleapis.com/v0/b/your-app-id/o/uploads/image.jpeg',
    );
                    
} catch (e) {
  log('error $e')
}

```
---

#### 10. Delete Multiple Images from Firebase Storage

```dart

try {

await ImagePickerTotalxsoftware.deleteMultipleImagesFromFirebaseByUrls([
  'https://firebasestorage.googleapis.com/v0/b/your-app-id/o/uploads/image1.jpeg',
  'https://firebasestorage.googleapis.com/v0/b/your-app-id/o/uploads/image2.jpeg',
]);
                    
} catch (e) {
  log('error $e')
}

```
---



## Explore more about TotalX at www.totalx.in - Your trusted software development company!





<div style="display: flex; gap: 20px; justify-content: center; align-items: center; margin-top: 15px;"> <a href="https://www.youtube.com/channel/UCWysKlrrg4_a3W4Usw5MYKw" target="_blank"> <img src="https://cdn-icons-png.flaticon.com/512/1384/1384060.png" alt="YouTube" width="60" height="60"> <p style="text-align: center;">YouTube</p> </a> <a href="https://x.com/i/flow/login?redirect_after_login=%2FTOTALXsoftware" target="_blank"> <img src="https://cdn-icons-png.flaticon.com/512/733/733579.png" alt="X (Twitter)" width="60" height="60"> <p style="text-align: center;">Twitter</p> </a> <a href="https://www.instagram.com/totalx.in/" target="_blank"> <img src="https://cdn-icons-png.flaticon.com/512/1384/1384063.png" alt="Instagram" width="60" height="60"> <p style="text-align: center;">Instagram</p> </a> <a href="https://www.linkedin.com/company/total-x-softwares/" target="_blank"> <img src="https://cdn-icons-png.flaticon.com/512/145/145807.png" alt="LinkedIn" width="60" height="60"> <p style="text-align: center;">LinkedIn</p> </a> </div>

## 🌐 Connect with Totalx Software

Join the vibrant Flutter Firebase Kerala community for updates, discussions, and support:

<a href="https://t.me/Flutter_Firebase_Kerala" target="_blank" style="text-decoration: none;"> <img src="https://cdn-icons-png.flaticon.com/512/2111/2111646.png" alt="Telegram" width="90" height="90"> <p><b>Flutter Firebase Kerala Totax</b></p> </a>