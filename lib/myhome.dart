import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:tesseract_ocr/tesseract_ocr.dart';

class HomeScreeen extends StatefulWidget {
  @override
  _HomeScreeenState createState() => _HomeScreeenState();
}

class _HomeScreeenState extends State<HomeScreeen> {
  bool _scanning = false;
  String _extractText = '';
  String _extraText1='';
  File? _pickedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text('Tesseract OCR'),
      ),
      body: ListView(
        children: [
          _pickedImage == null
              ? Container(
            height: 300,
            color: Colors.grey[300],
            child: Icon(
              Icons.image,
              size: 100,
            ),
          )
              : Container(
            height: 300,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                image: DecorationImage(
                  image: FileImage(_pickedImage!),
                  fit: BoxFit.fill,
                )),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: RaisedButton(
              color: Colors.green,
              child: Text(
                'Pick Image with text',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                setState(() {
                  _scanning = true;
                });
                _pickedImage = (await ImagePicker.platform.pickImage(source: ImageSource.gallery)) as File?;
                await ImagePicker.pickImage(source: ImageSource.gallery);
                //_extractText = await FlutterTesseractOcr.extractText(_pickedImage!.path);
                 await TesseractOcr.extractText(_pickedImage?.path);
                setState(() {
                  _scanning = false;
                });
              },
            ),
          ),
          SizedBox(height: 20),
          _scanning
              ? Center(child: CircularProgressIndicator())
              : Icon(
            Icons.done,
            size: 40,
            color: Colors.green,
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              _extractText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
