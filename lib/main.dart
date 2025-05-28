import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:moving_box/core/utils/service_locator.dart';
import 'package:moving_box/firebase_options.dart';
import 'package:moving_box/my_app.dart';

void main() async {
  // init firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // init injection dependency
  setupLocator();

  // init env
  await dotenv.load();

  runApp(const MyApp());
}
