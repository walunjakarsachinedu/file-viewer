
import 'package:flutter/material.dart' hide Intent;
import 'package:flutter/services.dart';
import 'package:pdf/pdf_screen.dart';
import 'package:pdf/text_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'dart:async';




void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription _intentData;
  String? _pdfFilePath;

	void handleSharingIntent(List<SharedMediaFile> files) {
		if(files.isEmpty) return;
		_pdfFilePath = files[0].path;
		setState(() {});
	}
	 
	void handleTextIntent(String? uri) {
		if(uri == null) return;
		_pdfFilePath = Uri.parse(uri).path;
		setState(() {});
	}

  @override
  void initState() {
    super.initState();
		Permission.storage.request();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

		ReceiveSharingIntent.getInitialMedia().then(handleSharingIntent);
		ReceiveSharingIntent.getMediaStream().listen(handleSharingIntent);

		ReceiveSharingIntent.getInitialText().then(handleTextIntent);
		ReceiveSharingIntent.getTextStream();
	}

  @override
  void dispose() {
    _intentData.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
			debugShowCheckedModeBanner: false,
      home: Scaffold(
				// appBar: AppBar(title: Text(_pdfFilePath ?? "null", style: const TextStyle(fontSize: 8),)),
        body: openDocument(_pdfFilePath),
      ),
    );
  }

	Widget openDocument(String? filePath) {
		if(filePath == null) return Center(child: Text("no file: $filePath"));
    return filePath.endsWith(".pdf")
        ? PdfWidget(path: filePath)
        : TextWidget(path: filePath);
  }
}