import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
        ),
        body: new Center(
          child: new RandomWords(),
        ),
      ),
    );
  }
}

//Stateful widgets maintain state that might change during the lifetime of the widget.
class RandomWords extends StatefulWidget {
  //StatefulWidget class creates an instance of a State class
  @override
  createState() => new RandomWordsState();
  }
  
class RandomWordsState extends State<RandomWords> {
  //The StatefulWidget class is, itself, immutable, but the State class persists over the lifetime of the widget.
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();
    return new Text(wordPair.asPascalCase);
  }
}