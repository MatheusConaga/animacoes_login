import 'package:flutter/material.dart';

class InputCustomizado extends StatelessWidget {
  InputCustomizado({
    @required this.hint,
   this.obscure = false,
   this.icon = const Icon(Icons.person),
    super.key
  });

  final String? hint;
  final bool obscure;
  final Icon icon;


  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(8),
      child: TextField(
        obscureText: this.obscure,
        decoration: InputDecoration(
          hintText: this.hint,
          hintStyle: TextStyle(
              color: Colors.grey[600]!,
              fontSize: 18
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 10, 0, 0),
          prefixIcon: this.icon,
          border: InputBorder.none,
        ),
      ),
    );
  }
}