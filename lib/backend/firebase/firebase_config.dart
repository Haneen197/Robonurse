import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAi_50VE0qdg6tAb6kJvFBAqAojilg5Dug",
            authDomain: "robonurse-gvqiu6.firebaseapp.com",
            projectId: "robonurse-gvqiu6",
            storageBucket: "robonurse-gvqiu6.firebasestorage.app",
            messagingSenderId: "648390899933",
            appId: "1:648390899933:web:df13c41fa03e93e45ac334"));
  } else {
    await Firebase.initializeApp();
  }
}
