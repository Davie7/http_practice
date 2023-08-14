// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:http_practice/services/http.dart';
import 'package:http_practice/utils/dialog.dart';

class EditPost extends StatefulWidget {
  final Map post;
  const EditPost({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.post['title']);
    _bodyController = TextEditingController(text: widget.post['body']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
              ),
              TextFormField(
                controller: _bodyController,
              ),
              ElevatedButton(
                onPressed: () async {
                  Map<String, String> dataToUpdate = {
                    'title': _titleController.text,
                    'body': _bodyController.text,
                  };

                  bool status = await HTTPHelper().updateItem(
                    dataToUpdate,
                    widget.post['id'].toString(),
                  );

                  if (status) {
                    showSnackBar('Updated post successfully', context);
                  } else {
                    showSnackBar('Failed to update', context);
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
