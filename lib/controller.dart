import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazyloadlists/model.dart';
import 'package:lazyloadlists/networking.dart';

class CommentsController extends GetxController {
  var comments = List<CommentsModel>.empty(growable: true).obs;
  final picker = ImagePicker();

  var file;
  RxString imageUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getComments();
  }

  getComments() async {
    var com = await CommentsNetworking.getComments();
    if (com != null) {
      comments.value = com;
    }
  }

  // Future pickImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.camera);
  //   _imageFile = File(pickedFile!.path);
  // }

  // Future uploadImageToFirebase() async {
  //   String fileName = basename(_imageFile.path);
  //   StorageReference firebaseStorageRef =
  //       FirebaseStorage.instance.ref().child('uploads/$fileName');
  //   StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
  //   StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
  //   taskSnapshot.ref.getDownloadURL().then(
  //         (value) => print("Done: $value"),
  //       );
  // }
  getImage() async {
    final _imagePicker = ImagePicker();
    PickedFile? image =
        await _imagePicker.getImage(source: ImageSource.gallery);
    file = File(image!.path);
  }

  uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance;

    //Upload to Firebase
    var snapshot = await _firebaseStorage
        .ref()
        .child('images/admin/${DateTime.now()}')
        .putFile(file);
    var downloadUrl = await snapshot.ref.getDownloadURL();
    imageUrl.value = downloadUrl;

    Map<String, dynamic> demoData = {
      'img': imageUrl.value,
    };

    CollectionReference c = FirebaseFirestore.instance.collection('images');
    c.doc().set(demoData);
  }
}
