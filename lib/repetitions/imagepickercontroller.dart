import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Imagepickercontroller extends GetxController {
  var imagepath = ''.obs;
  Future<void> pickimage(ImageSource source) async {
    try {
      final PickedFile = await ImagePicker().pickImage(source: source);
      if (PickedFile != null) {
        imagepath.value=PickedFile.path;
      }else{
        Get.snackbar("No image selected", "Please select image");
      }
    } catch (error) {
      Get.snackbar("Error", "error while image choosing $error");
    }
  }
}
