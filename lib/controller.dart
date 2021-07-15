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
  var datalist = List.empty(growable: true).obs;

  @override
  void onInit() {
    super.onInit();
    getComments();
    getData();
  }

  getComments() async {
    var com = await CommentsNetworking.getComments();
    if (com != null) {
      comments.value = com;
    }
  }

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

  getData() {
    CollectionReference c = FirebaseFirestore.instance.collection('images');
    c.snapshots().listen((event) {
      datalist.value = event.docs;
    });
  }
}
