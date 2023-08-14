// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:http_practice/services/http.dart';

import 'edit_posts.dart';

class PostDetails extends StatelessWidget {
  final String itemId;
  late Future<Map> futurePost;
  PostDetails({
    Key? key,
    required this.itemId,
  }) : super(key: key) {
    futurePost = HTTPHelper().getItem(itemId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          FutureBuilder(
            future: futurePost,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                Map post = snapshot.data;
                return IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditPost(post: post),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit),
                );
              }
              return Container();
            },
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: FutureBuilder(
        future: futurePost,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Some error has occurred: ${snapshot.error}'),
            );
          }
          if (snapshot.hasData) {
            Map post = snapshot.data;
            return Column(
              children: [
                Text(
                  '${post['title']}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('${post['body']}'),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

