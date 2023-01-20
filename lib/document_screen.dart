import 'package:flutter/material.dart';
import 'package:pdf/pdf_screen.dart';
import 'package:pdf/text_screen.dart';

class DocumentScreen extends StatelessWidget {
	final String? path;
  const DocumentScreen({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return path!=null ? documentScreen(path!) : emptyScreen();
  }

	Widget documentScreen(String filePath) {
    return Scaffold(
      body: filePath.endsWith(".pdf")
				? PdfWidget(path: filePath)
				: TextWidget(path: filePath),
    );
  }

	Widget emptyScreen() =>const Scaffold(
		body: Center(
			child: Text(
				"No File Selected",
				style: TextStyle(fontSize: 16),
			),
		),
	); 

}