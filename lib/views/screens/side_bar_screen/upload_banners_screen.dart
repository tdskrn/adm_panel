import 'package:adm_panel/utils/colors/colors_marques.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class UploadBannersScreen extends StatefulWidget {
  static const String routeName = '\UploadBannersScreen';

  @override
  State<UploadBannersScreen> createState() => _UploadBannersScreenState();
}

class _UploadBannersScreenState extends State<UploadBannersScreen> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  dynamic _image;

  String? fileName;

  pickImage() async {
    // variavel que verifica se plataforma é web
    if (kIsWeb) {
      FilePickerResult? result = await FilePickerWeb.platform
          .pickFiles(allowMultiple: false, type: FileType.image);
      if (result != null) {
        setState(() {
          _image = result.files.first.bytes;
          fileName = result.files.first.name;
        });
      }
    } else {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(allowMultiple: false, type: FileType.image);
      if (result != null) {
        setState(() {
          _image = result.files.first.bytes;
          fileName = result.files.first.name;
        });
      }
    }
  }

  _uploadBannersToStorage(dynamic image) async {
    Reference ref = _storage.ref().child('Banners').child(fileName!);

    UploadTask uploadTask = ref.putData(image);

    TaskSnapshot snapshot = await uploadTask;

    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  uploadToFirebaseStore() async {
    try {
      EasyLoading.show();
      if (_image != null) {
        // aqui passamos a variavel _image que foi atualizada no setState
        String imageUrl = await _uploadBannersToStorage(_image);

        _firestore.collection('banners').doc(fileName).set({
          "image": imageUrl,
        }).whenComplete(() {
          EasyLoading.showSuccess("Upload feito com sucesso");
          setState(() {
            _image = null;
          });
        });
      }
    } catch (error) {
      EasyLoading.showError(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              "Banners",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36,
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade500,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _image != null
                          ? Image.memory(
                              _image,
                              fit: BoxFit.cover,
                            )
                          : Center(
                              child: Text("Banners"),
                            ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: ColorsMarques.blueMarques),
                      onPressed: () {
                        pickImage();
                      },
                      child: Text(
                        "Upload Image",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: ColorsMarques.blueMarques,
                ),
                onPressed: () {
                  uploadToFirebaseStore();
                },
                child: Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          if (fileName != null) Text(fileName!)
        ],
      ),
    );
  }
}
