import 'package:flutter/material.dart';
import 'package:flutter_application_restuarant/applicationentry.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv; 
//this library helps to load configuration at runtime from .env file

void main() async{
  await DotEnv.load(fileName: ".env");
  runApp(MyApp());
}

