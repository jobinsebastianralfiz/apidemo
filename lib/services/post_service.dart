import 'dart:convert';

import 'package:apihandlingdemo/api/base_url.dart';
import 'package:apihandlingdemo/models/commentmodel/comment_model.dart';
import 'package:apihandlingdemo/models/postmodel/post_model.dart';
import 'package:http/http.dart' as http;

class PostService {
  final client = http.Client();
  Future<List<PostModel>?> getAllPosts() async {
    try {
      final response = await client.get(
        Uri.parse("${API().baseUrl}${API().postEndpoint}"),
      );
      // print(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> responseBody = jsonDecode(response.body);

        final List<PostModel> posts =
            responseBody.map((json) => PostModel.fromJson(json)).toList();

        return posts;
      } else {
        throw Exception("Faile to load posts");
      }
    } catch (e) {
      print(e);
    }
  }





  Future<List<CommentModel>?> getComments(int? id) async {
    try {
      final response = await client.get(
        Uri.parse("${API().baseUrl}${API().commentEndpoint}$id"),
      );
      // print(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> responseBody = jsonDecode(response.body);

        final List<CommentModel>comments =
        responseBody.map((json) => CommentModel.fromJson(json)).toList();
       print(comments);
        return comments;
      } else {
        throw Exception("Faile to load posts");
      }
    } catch (e) {
      print(e);
    }
  }
}
