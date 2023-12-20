import 'package:apihandlingdemo/models/postmodel/post_model.dart';
import 'package:apihandlingdemo/services/post_service.dart';
import 'package:flutter/material.dart';


class PostDetails extends StatefulWidget {
  final PostModel? post;
  const PostDetails({super.key,this.post});

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text("${widget.post!.title}"),
            SizedBox(height: 20,),
            Divider(color: Colors.red,height: 1,),
            SizedBox(height: 20,),
            Text("${widget.post!.body}"),
            SizedBox(height: 20,),
            Text("Comments"),
            SizedBox(height: 20,),
            Expanded(child: FutureBuilder(
              future: PostService().getComments(widget.post!.id),
              builder: (context,snapshot){
                if(snapshot.hasData){

                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context,index){
                    return Card(
                      child: ListTile(
                        title: Text("${snapshot.data![index].body}"),
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
