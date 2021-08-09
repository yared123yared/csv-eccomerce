import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final Function onPressed;

  const DeleteButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.pink,
      foregroundColor: Colors.white,
      child: IconButton(
        icon: Icon(
          Icons.delete_outline,
          color: Colors.white,
        ),

        onPressed: ()=>this.onPressed(),
      ),
    );
  }
}
