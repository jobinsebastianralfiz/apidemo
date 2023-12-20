import 'package:apihandlingdemo/models/commentmodel/comment_model.dart';
import 'package:apihandlingdemo/models/postmodel/post_model.dart';
import 'package:apihandlingdemo/screens/post_details.dart';
import 'package:apihandlingdemo/services/post_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PostService _postService = PostService();
  List<PostModel>? posts = [];
  getData() async {
    posts = await _postService.getAllPosts();
  }

  @override
  void initState() {
    // getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "All Post",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: FutureBuilder(
              future: _postService.getAllPosts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final post = snapshot.data![index];
                        return Card(
                          child: ListTile(
                            onTap: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>PostDetails(post: post,)));
                            },
                            title: Text("${post.title}"),
                            subtitle: Text(
                              "${post.body}",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        );
                      });
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
