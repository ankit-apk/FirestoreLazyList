import 'package:http/http.dart' as http;
import 'package:lazyloadlists/model.dart';

class CommentsNetworking {
  static getComments() async {
    var client = http.Client();
    var response = await client
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    if (response.statusCode == 200) {
      return commentsModelFromJson(response.body);
    }
  }
}
