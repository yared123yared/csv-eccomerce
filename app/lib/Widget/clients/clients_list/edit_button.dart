import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  final Function onPressed;

  const EditButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Colors.white,
      child: IconButton(
        icon: Icon(
          Icons.edit,
          color: Colors.white,
        ),
        onPressed: this.onPressed(),
      ),
    );
  }
}
