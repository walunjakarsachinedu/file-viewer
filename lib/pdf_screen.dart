import 'package:flutter/material.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

class PdfWidget extends StatelessWidget {
	final String path;	
  const PdfWidget({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
		return PdfView(path: path) ;
  }
}