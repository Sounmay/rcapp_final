import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:rcapp/services/database.dart';

class UploadPdf extends StatefulWidget {
  @override
  _UploadPdfState createState() => _UploadPdfState();
}

class _UploadPdfState extends State<UploadPdf> {
  @override
  Widget build(BuildContext context) {
    return PdfCapture();
  }
}

class PdfCapture extends StatefulWidget {
  @override
  _PdfCaptureState createState() => _PdfCaptureState();
}

class _PdfCaptureState extends State<PdfCapture> {
  File _pickedPdf;

  bool showOptions = false;

  String title = '';
  String subtitle = '';

  void _pickPdf() async {
    File pickedPdfFile = await FilePicker.getFile(
        type: FileType.custom, allowedExtensions: ['pdf']);
    setState(() {
      _pickedPdf = pickedPdfFile;
    });
  }

  void _clear() {
    setState(() => _pickedPdf = null);
  }

  void toggle() {
    setState(() {
      showOptions = !showOptions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text('Upload Pdf'),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              if (showOptions == true) ...[
                Container(
                  height: 90,
                  child: Column(children: <Widget>[
                    IconButton(
                      iconSize: 40,
                      color: Colors.deepOrange,
                      icon: Icon(Icons.photo_library),
                      onPressed: () => _pickPdf(),
                    ),
                    Text('File Explorer',
                        style: GoogleFonts.inter(
                            color: Colors.black, fontWeight: FontWeight.bold))
                  ]),
                ),
              ]
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
            child: Column(children: <Widget>[
              if (_pickedPdf == null) ...[
                Center(
                  child: Container(
                    width: 320,
                    height: 250,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.deepOrange, width: 2.0),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            toggle();
                          },
                          iconSize: 40,
                          icon: Icon(Icons.file_upload),
                        ),
                        SizedBox(height: 5),
                        Text('Click to Add Pdf',
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500, fontSize: 20))
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Title',
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepOrange, width: 1.0),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepOrange, width: 3.0),
                            borderRadius: BorderRadius.circular(10))),
                    validator: (val) => val.isEmpty ? 'Enter Title' : null,
                    onChanged: (val) {
                      setState(() => title = val);
                    }),
                SizedBox(height: 10),
                TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Sub-Title',
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepOrange, width: 1.0),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepOrange, width: 3.0),
                            borderRadius: BorderRadius.circular(10))),
                    validator: (val) => val.isEmpty ? 'Enter subtitle' : null,
                    onChanged: (val) {
                      setState(() => subtitle = val);
                    })
              ],
              if (_pickedPdf != null) ...[
                // Image.file(_pickedPdf),
                SizedBox(height: 10),
                TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Title',
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepOrange, width: 1.0),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepOrange, width: 3.0),
                            borderRadius: BorderRadius.circular(10))),
                    validator: (val) => val.isEmpty ? 'Enter Title' : null,
                    onChanged: (val) {
                      setState(() => title = val);
                    }),
                SizedBox(height: 10),
                TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Sub-Title',
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepOrange, width: 1.0),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepOrange, width: 3.0),
                            borderRadius: BorderRadius.circular(10))),
                    validator: (val) => val.isEmpty ? 'Enter Subtitle' : null,
                    onChanged: (val) {
                      setState(() => subtitle = val);
                    }),
                SizedBox(height: 10),
                Uploader(file: _pickedPdf, title: title, subtitle: subtitle),
                SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        color: Colors.deepOrange,
                        child: Icon(Icons.refresh),
                        onPressed: _clear,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                      ),
                    ]),
              ]
            ]),
          ),
        ));
  }
}

class Uploader extends StatefulWidget {
  final title;
  final subtitle;
  final file;
  Uploader({this.file, this.title, this.subtitle});
  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  var _uploadTask;

  final DatabaseService _pdfUploader = DatabaseService();

  Future _startUpload(String title, String subtitle) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('pdf_store')
          .child('${DateTime.now()}.pdf');

      setState(() {
        _uploadTask = ref.putFile(widget.file);
      });

      await ref.putFile(widget.file).onComplete;

      final url = await ref.getDownloadURL();

      _pdfUploader.updatePdf(title, subtitle, url);
      print(url);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
        stream: _uploadTask.events,
        builder: (context, snapshot) {
          var event = snapshot?.data?.snapshot;
          double progressPercent =
              event != null ? event.bytesTransferred / event.totalByteCount : 0;

          return Column(children: <Widget>[
            if (_uploadTask.isComplete) Text("Uploaded To Database"),
            LinearProgressIndicator(value: progressPercent),
            Text('${(progressPercent * 100).toStringAsFixed(2)} %')
          ]);
        },
      );
    } else {
      return FlatButton.icon(
        onPressed: () {
          _startUpload(widget.title, widget.subtitle);
        },
        icon: Icon(Icons.cloud_upload),
        label: Text(
          'Save Data To List',
          style: GoogleFonts.inter(fontSize: 17),
        ),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0)),
        color: Colors.deepOrange,
      );
    }
  }
}
