import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Backend{

FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
  void uploadData(data){
    firestore.collection('Users').doc(auth.currentUser!.uid).collection('Projects').add({
      'Data': data
    });
  }

}