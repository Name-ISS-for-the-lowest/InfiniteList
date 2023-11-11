import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

//this is the random words widget which just create a stateful widget and
//seems to returns RandomWordsState
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

//this one is the randomState words, and seems to extend not a widget
//but rather the class state of type randomWords
//this is interesting
class RandomWordsState extends State<RandomWords> {
  //here we create a randomWords pair object
  //I believe the words are generate byt this not sure yet
  final _randomWordPairs = <WordPair>[];
  final _savedWordPairs = <WordPair>{};
  //this is a build list function at it returns type widget
  Widget _buildList() {
    //here I am returning the type listview.builder type
    return ListView.builder(
      //here I give the view some padding
      padding: const EdgeInsets.all(16.0),
      //here I declre the item builder
      itemBuilder: (context, item) {
        //if the index is odd, I return a divider, which just seems to be a line
        if (item.isOdd) return const Divider();
        //here if the index of _item is divisible by 2
        final index = item ~/ 2;
        if (index >= _randomWordPairs.length) {
          //if index which seems to be the size of the list
          //which seems to automatically grow while we scroll down
          //then we generate 10 new word pairs, and app them to the randomWordPairs list
          _randomWordPairs.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_randomWordPairs[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _savedWordPairs.contains(pair);

    return ListTile(
      title: Text(pair.asPascalCase, style: const TextStyle(fontSize: 18.0)),
      trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _savedWordPairs.remove(pair);
          } else {
            _savedWordPairs.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _savedWordPairs.map((WordPair pair) {
        return ListTile(
            title: Text(pair.asPascalCase,
                style: const TextStyle(fontSize: 16.0)));
      });
      final List<Widget> divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();
      return Scaffold(
          appBar: AppBar(title: const Text('Saved WordPairs')),
          body: ListView(children: divided));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: const Text('Word Pair Generator'), actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _pushSaved,
          )
        ]),
        body: _buildList());
  }
}
