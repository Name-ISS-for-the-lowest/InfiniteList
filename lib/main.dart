import 'package:flutter/material.dart';
import './random_words.dart';

void main() => runApp(MyApp());


//this widget is the root of the app
//it returns a theme and a home, which is a randomWord widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) { 
    return MaterialApp(
        theme: ThemeData(
            colorScheme: ColorScheme.light()
                .copyWith(primary: const Color.fromARGB(255, 71, 176, 39)),
            appBarTheme: AppBarTheme(color: Color.fromARGB(255, 39, 160, 176))),
        home: RandomWords());
  }
}

