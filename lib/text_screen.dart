
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class TextWidget extends StatelessWidget {
	final String path;
  const TextWidget ({super.key, required this.path});

  String getFileText(String path) => Uri.dataFromString(
		"<pre> ${File(path).readAsStringSync()} </pre>",
		mimeType: "text/html",
	).toString();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebviewScaffold(
        url: getFileText(path),
        withZoom: true,
      ),
    );
  }
}