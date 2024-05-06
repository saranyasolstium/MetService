import 'dart:async';
import 'dart:io';
import 'package:eagle_pixels/reuse/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:external_path/external_path.dart';


class PDFViewerScreen extends StatefulWidget {
  final String serviceId;

  PDFViewerScreen({required this.serviceId});

  @override
  _PDFViewerScreenState createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  String? _pdfPath;

  @override
  void initState() {
    super.initState();
    _fetchAndLoadPdf();
  }

  Future<void> _fetchAndLoadPdf() async {
    String url = "https://met.solstium.net/api/v1/employee/report_pdf/${widget.serviceId}";
    String? token = await SharedPreferencesHelper.getToken();

    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        Directory tempDir = await getTemporaryDirectory();
        String tempPath = tempDir.path;

        String pdfPath = '$tempPath/report.pdf';
        await File(pdfPath).writeAsBytes(response.bodyBytes);

        setState(() {
          _pdfPath = pdfPath;
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error while fetching PDF: $error');
    }
  }



Future<void> _downloadPdf() async {
  try {
    String url = "https://met.solstium.net/api/v1/employee/report_pdf/${widget.serviceId}";
    String? token = await SharedPreferencesHelper.getToken();
    
    http.Response response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Specify your custom folder path on external storage
      String customFolderPath = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);
      
      // Check if the custom folder exists, if not create it
      Directory customDir = Directory(customFolderPath);
      if (!customDir.existsSync()) {
        customDir.createSync(recursive: true);
      }

      String fileName = 'report.pdf';
      String filePath = '$customFolderPath/$fileName';
      
      await File(filePath).writeAsBytes(response.bodyBytes);

      // Show a snackbar to indicate successful download
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PDF downloaded successfully. File saved at: $filePath'),
        ),
      );
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (error) {
    print('Error while downloading PDF: $error');
    // Show a snackbar to indicate download failure
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to download PDF. Error: $error'),
      ),
    );
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        title: Text('PDF Viewer'),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: _downloadPdf,
          ),
        ],
      ),

      body: _pdfPath != null
          ? PDFView(filePath: _pdfPath!)
          : Center(child: CircularProgressIndicator()),
    );
  }
}
