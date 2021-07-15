import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:lazy_loading_list/lazy_loading_list.dart';
import 'package:lazyloadlists/controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  CommentsController _commentsController = Get.put(CommentsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Obx(
      //   () => ListView.builder(
      //     itemCount: _commentsController.comments.length,
      //     itemBuilder: (context, index) {
      //       return LazyLoadingList(
      //           loadMore: () => print('loading...'),
      //           child: ListTile(
      //             leading:
      //                 Image.network(_commentsController.comments[index].url!),
      //           ),
      //           index: index,
      //           hasMore: true);
      //     },
      //   ),
      // ),
      body: SafeArea(
        child: Center(
          child: Obx(
            () => Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _commentsController.getImage();
                  },
                  child: Text('Upload'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _commentsController.uploadImage();
                  },
                  child: Text('Fire'),
                ),
                SizedBox(
                  height: 20,
                ),
                (_commentsController.imageUrl.value == '')
                    ? Text('Null')
                    : Image.network(_commentsController.imageUrl.value),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
