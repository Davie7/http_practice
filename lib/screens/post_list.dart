import 'package:flutter/material.dart';
import 'package:http_practice/screens/add_post.dart';
import 'package:http_practice/services/http.dart';

import '../utils/dialog.dart';
import 'post_details.dart';

class PostList extends StatefulWidget {
  const PostList({super.key});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  final Future<List<Map>> _futurePosts = HTTPHelper().fetchItems();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddPost(),),);
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: _futurePosts,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Map> posts = snapshot.data;

            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int index) {
                Map item = posts[index];
                return ListTile(
                  title: Text(
                    item['title'],
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    item['body'],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetails(
                          itemId: item['id'].toString(),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
          if (snapshot.hasError) {
            showSnackBar(snapshot.error.toString(), context);
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
