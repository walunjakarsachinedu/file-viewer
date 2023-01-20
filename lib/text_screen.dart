import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
	final String path;
  const TextWidget ({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Center(
			child: Text(path),
		);
  }
}