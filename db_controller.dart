import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseController {

  // Firestore instance create
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Create a CollectionReference called users that references the firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    //Save user information
    Future<void> saveUserData(String name, String email, String phoneNumber) {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
            'name': name, 
            'email': email,
            'phoneNumber': phoneNumber, 
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

}