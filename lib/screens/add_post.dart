import 'package:flutter/material.dart';
import 'package:http_practice/services/http.dart';
import 'package:http_practice/utils/dialog.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add post'),
      ),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(hintText: 'Add a title'),
                  controller: _titleController,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Add a title'),
                  controller: _bodyController,
                  maxLines: 5,
                ),
                ElevatedButton(
                  onPressed: () async {
                    Map<String, String> dataToUpdate = {
                      'title': _titleController.text,
                      'body': _bodyController.text,
                    };
                    bool status = await HTTPHelper().addItem(dataToUpdate);

                    if(status){
                      showSnackBar('Added post', context);
                    }else{
                      showSnackBar('Failed to add post', context);
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          )),
    );
  }
}
