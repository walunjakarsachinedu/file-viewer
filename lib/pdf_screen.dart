import 'package:flutter/material.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

class PdfWidget extends StatefulWidget {
	final String path;	
  const PdfWidget({super.key, required this.path});

  @override
  State<PdfWidget> createState() => _PdfWidgetState();
}

class _PdfWidgetState extends State<PdfWidget> {
	String? filePath;	

  @override
  Widget build(BuildContext context) {
		return PdfView(path: widget.path) ;
  }
}