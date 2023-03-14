import 'package:adm_panel/utils/colors/colors_marques.dart';
import 'package:flutter/material.dart';

class UploadBannersScreen extends StatelessWidget {
  static const String routeName = '\UploadBannersScreen';

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
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text("Banners"),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: ColorsMarques.blueMarques),
                      onPressed: () {},
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
                onPressed: () {},
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
    );
  }
}
