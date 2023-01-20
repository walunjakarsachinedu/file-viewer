import 'package:flutter/material.dart';
import 'package:pdf/pdf_screen.dart';
import 'package:pdf/text_screen.dart';

class DocumentScreen extends StatelessWidget {
	final String? path;
  const DocumentScreen({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return openDocument(path);
  }

	Widget openDocument(String? filePath) {
		if(filePath == null) return Center(child: Text("no file: $filePath"));
    return Scaffold(
      body: filePath.endsWith(".pdf")
				? PdfWidget(path: filePath)
				: TextWidget(path: filePath),
    );
  }
}