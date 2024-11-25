import 'package:hl_image_picker/hl_image_picker.dart' as hl_image_picker;
import 'package:image_cropper/image_cropper.dart' as image_cropper;

image_cropper.CropAspectRatioPreset mapAspectRatioPreset(String name) {
  switch (name) {
    case 'original':
      return image_cropper.CropAspectRatioPreset.original;
    case 'square':
      return image_cropper.CropAspectRatioPreset.square;
    case 'ratio3x2':
      return image_cropper.CropAspectRatioPreset.ratio3x2;
    case 'ratio4x3':
      return image_cropper.CropAspectRatioPreset.ratio4x3;
    case 'ratio5x3':
      return image_cropper.CropAspectRatioPreset.ratio5x3;
    case 'ratio5x4':
      return image_cropper.CropAspectRatioPreset.ratio5x4;
    case 'ratio7x5':
      return image_cropper.CropAspectRatioPreset.ratio7x5;
    case 'ratio16x9':
      return image_cropper.CropAspectRatioPreset.ratio16x9;
    default:
      return image_cropper.CropAspectRatioPreset.square;
  }
}

hl_image_picker.CropAspectRatioPreset hlmapAspectRatioPreset(String name) {
  switch (name) {
    case 'original':
      return hl_image_picker.CropAspectRatioPreset.original;
    case 'square':
      return hl_image_picker.CropAspectRatioPreset.square;
    case 'ratio3x2':
      return hl_image_picker.CropAspectRatioPreset.ratio3x2;
    case 'ratio4x3':
      return hl_image_picker.CropAspectRatioPreset.ratio4x3;
    case 'ratio5x3':
      return hl_image_picker.CropAspectRatioPreset.ratio5x3;
    case 'ratio5x4':
      return hl_image_picker.CropAspectRatioPreset.ratio5x4;

    case 'ratio16x9':
      return hl_image_picker.CropAspectRatioPreset.ratio16x9;
    default:
      return hl_image_picker.CropAspectRatioPreset.square;
  }
}
