import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path/path.dart' as path;
// import 'dart:io';
class FileUploadController{
  File? imageFile;
  Future<String> uploadImageToFirebase(File? imageFile) async {
    try{
      if (imageFile == null) {
        throw Exception('No image file selected');
      }
      final FirebaseStorage storage = FirebaseStorage.instance;
      String fileName = path.basename(imageFile.path);
      Reference storageRef = storage.ref().child('images/$fileName');
      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
      return "hi";
    }
    catch (e) {
      print('Error uploading image: $e');
    }
    return "hi";

    }
}

