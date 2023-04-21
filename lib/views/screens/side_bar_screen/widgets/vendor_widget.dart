import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VendorWidget extends StatelessWidget {
  Widget vendorData(int? flex, Widget widget) {
    return Expanded(
      flex: flex!,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          child: widget,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final Stream<QuerySnapshot> _vendorsStream =
        FirebaseFirestore.instance.collection('vendors').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _vendorsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              final vendorUserData = snapshot.data!.docs[index];

              return Container(
                child: Row(
                  children: [
                    vendorData(
                      1,
                      Container(
                        height: 50,
                        width: 50,
                        child: Image.network(vendorUserData['storeImage']),
                      ),
                    ),
                    vendorData(
                      3,
                      Text(
                        vendorUserData['bussinessName'].toUpperCase(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    vendorData(
                      2,
                      Text(vendorUserData['cityValue'].toUpperCase(),
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    vendorData(
                      2,
                      Text(vendorUserData['stateValue'].toUpperCase(),
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    vendorData(
                        1,
                        vendorUserData['approved'] == false
                            ? ElevatedButton(
                                onPressed: () async {
                                  await _firestore
                                      .collection('vendors')
                                      .doc(vendorUserData['vendorId'])
                                      .update({'approved': true});
                                },
                                child: Text('Reject'),
                              )
                            : ElevatedButton(
                                onPressed: () async {
                                  await _firestore
                                      .collection('vendors')
                                      .doc(vendorUserData['vendorId'])
                                      .update({'approved': false});
                                },
                                child: Text('Approved'),
                              )),
                    vendorData(
                      1,
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('View More'),
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );
  }
}
