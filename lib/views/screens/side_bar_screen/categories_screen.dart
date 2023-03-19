import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors/colors_marques.dart';

class CategoriesScreen extends StatefulWidget {
  static const String routeName = '\CategoriesScreen';

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  dynamic _image;
  String? fileName;

  _pickImage() async {
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

  uploadCategory() {
    if (_formKey.currentState!.validate()) {
      print('Good guy');
    } else {
      debugPrint('Bad Guy');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: const Text(
                "Category",
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
                                child: Text("Image Category"),
                              ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: ColorsMarques.blueMarques),
                        onPressed: () {
                          _pickImage();
                        },
                        child: Text(
                          "Upload Image Local",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Category Name Must not be empty';
                        }
                        if (value.length < 6) {
                          return "Name Category is too short";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Enter Category name",
                          hintText: "Enter Category name"),
                    ),
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
                    uploadCategory();
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
          ],
        ),
      ),
    );
  }
}
