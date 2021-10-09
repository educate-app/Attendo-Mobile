import 'package:attendo/models/form_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirestoreDatabase {
  final FirebaseFirestore firestore;
  FirestoreDatabase(
     this.firestore,
  );

  Future<void> addUser(BuildContext context, FormModel data) async {
    final student = firestore.collection('students').withConverter<FormModel>(
          fromFirestore: (snapshot, _) => FormModel.fromMap(snapshot.data()!),
          toFirestore: (movie, _) => movie.toMap(),
        );
    try {
      student.doc(data.enrollmentnumber.toString()).set(data);
    } on FirebaseException catch (e) {
      print(e);
      //  Show a dialog box with the error message
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Something went wrong'),
              content: Text(e.message as String),
              actions: <Widget>[
                // ignore: deprecated_member_use
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }
}
