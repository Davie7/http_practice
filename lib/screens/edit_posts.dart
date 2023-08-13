// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}