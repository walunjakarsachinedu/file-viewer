
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class TextWidget extends StatelessWidget {
	final String path;
  const TextWidget ({super.key, required this.path});

  Future<String> getFileText(String path) async => Uri.dataFromString(
			"<pre> ${File(path).readAsStringSync()} </pre>",
			mimeType: "text/html",
		).toString();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<String>(
				future: getFileText(path),	
        builder: (context, path) {
					if(path.hasData && path.data != null) {
						return WebviewScaffold(
							url: path.data!,
							withZoom: true,
						);
					}
					return const SizedBox();
        }
      ),
    );
  }
}