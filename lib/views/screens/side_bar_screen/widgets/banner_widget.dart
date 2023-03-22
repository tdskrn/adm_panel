import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// * Solucao
// flutter run -d chrome --web-renderer html
// faz imagens web aparecerem
//flutter build web --web-renderer html --release

class BannerWidget extends StatelessWidget {
  final Stream<QuerySnapshot> _categoriesStream =
      FirebaseFirestore.instance.collection('banners').snapshots();
  // referenciamos categories
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _categoriesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: Colors.cyan),
          );
        }

        return GridView.builder(
          shrinkWrap: true,
          //snapshot recebe _categoriesStream
          itemCount: snapshot.data!.size,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            final categoryData = snapshot.data!.docs[index];
            return Column(
              children: [
                SizedBox(
                  height: 100,
                  width: 200,
                  child: Image.network(
                    categoryData['image'],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
