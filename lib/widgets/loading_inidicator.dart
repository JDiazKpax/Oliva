import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white10,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      );
}