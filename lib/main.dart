
import 'package:flutter/material.dart' hide Intent;
import 'package:flutter/services.dart';
import 'package:pdf/document_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:receive_intent/receive_intent.dart';
import 'dart:async';

import 'package:uri_to_file_path/uri_to_file_path.dart';



void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription _intentData;
  String? _pdfFilePath;

	void handleIntent(Intent? intent) async {
		if(intent == null) return;
		if(intent.action == "android.intent.action.VIEW") _pdfFilePath = intent.data;
		if(intent.action == "android.intent.action.SEND") _pdfFilePath = intent.extra?["android.intent.extra.STREAM"];
		if(_pdfFilePath != null) _pdfFilePath = await UriToFilePath.getAbsolutePath(_pdfFilePath!);
		setState(() {});
	}

	Future<void> _initReceiveIntent() async {
		try {
			final intent = await ReceiveIntent.getInitialIntent();
			handleIntent(intent);
		} on PlatformException {print("platform error occurs");}
	}

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.black));
		Permission.storage.request();

    _intentData = ReceiveIntent.receivedIntentStream.listen(handleIntent);
		_initReceiveIntent();
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
      home: DocumentScreen(path: _pdfFilePath, key: UniqueKey()),
    );
  }
}