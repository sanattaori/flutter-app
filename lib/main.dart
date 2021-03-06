import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        
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
  
  final _suggestions = <WordPair>[];
  // Set stores the word pairings that the user favorited. 
  //Set is preferred to List because a properly implemented Set doesn’t allow duplicate entries.
  final _saved = new Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);
  
  //ListView that displays the suggested word pairing.
  Widget _buildSuggestions() {
    return new ListView.builder(
      
      padding: const EdgeInsets.all(16.0),
      // The itemBuilder callback is called, once per suggested word pairing,
      // and places each suggestion into a ListTile row.
      // For even rows, the function adds a ListTile row for the word pairing.
      // For odd rows, the function adds a Divider widget to visually
      // separate the entries. Note that the divider may be difficult
      // to see on smaller devices.
      itemBuilder: (context, i) {
        // Add a one-pixel-high divider widget before each row in theListView.
        if (i.isOdd) return new Divider();

        // The syntax "i ~/ 2" divides i by 2 and returns an integer result.
        // For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
        // This calculates the actual number of word pairings in the ListView,
        // minus the divider widgets.
        final index = i ~/ 2;
        // If you've reached the end of the available word pairings...
        if (index >= _suggestions.length) {
          // ...then generate 10 more and add them to the suggestions list.
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      }
    );
    
  }

  void _pushSaved() {
  Navigator.of(context).push(
    new MaterialPageRoute(
      builder: (context) {
        final tiles = _saved.map(
              (pair) {
            return new ListTile(
              title: new Text(
                pair.asPascalCase,
                style: _biggerFont,
              ),
            );
          },
        );
        final divided = ListTile
            .divideTiles(
          context: context,
          tiles: tiles,
        )
            .toList();
            return new Scaffold(
              appBar: new AppBar(
                title: new Text('Saved Suggestions'),
          ),
          body: new ListView(children: divided),
        );
      },
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return new Scaffold (
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
    body: _buildSuggestions(),
    );
  }

  Widget _buildRow(WordPair pair) {
    //check to ensure that a word pairing hasn’t already been added to favorites.
    final alreadySaved = _saved.contains(pair);

    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
      alreadySaved ? Icons.favorite : Icons.favorite_border,
      color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
      setState(() {
        if (alreadySaved) {
          _saved.remove(pair);
          } else {
          _saved.add(pair);
          }
        });
      },
    );
  }
}