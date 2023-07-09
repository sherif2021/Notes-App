import 'package:clean_arch_example/app.dart';
import 'package:clean_arch_example/config/di.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DI().execute();
  runApp(const NotesApp());
}
