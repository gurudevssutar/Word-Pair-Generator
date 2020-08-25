import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:sqflite/sqflite.dart';

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _randomWordPairs = <WordPair>[];
  final _savedWordPairs = Set<WordPair>();
  Widget _buildListView() {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, item) {
          _randomWordPairs.addAll(generateWordPairs().take(10));

          return _buildRow(_randomWordPairs[item]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _savedWordPairs.contains(pair);

    return ListTile(
      title: Text(pair.asPascalCase,
          style: TextStyle(color: Colors.purple[800], fontSize: 20)),
      trailing: Icon(alreadySaved ? (Icons.favorite) : (Icons.favorite_border),
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
            title: Text(pair.asPascalCase, style: TextStyle(fontSize: 16.0)));
      });

      final List<Widget> divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();

      return Scaffold(
          appBar: AppBar(title: Text("Saved WordPairs")),
          body: ListView(children: divided));
    }));
  }

  Widget _drawersWidget() {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
      DrawerHeader(
        child: Text("Welcome to WordPair Generator !",
            style: TextStyle(fontSize: 16.0, color: Colors.white)),
        decoration: BoxDecoration(color: Colors.purple[600]),
      ),
      ListTile(
        title: Text("About",
            style: TextStyle(
                color: Colors.purple[600],
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return Scaffold(
                appBar: AppBar(
                    title:
                        Text("About", style: TextStyle(color: Colors.white))),
                body: Text(
                    "This is a basic app which generates dynamic WordPairs " +
                        "and allows to save the wordpairs for future reference.",
                    style: TextStyle(
                        color: Colors.purple[600],
                        fontSize: 20,
                        fontWeight: FontWeight.bold)));
          }));
        },
        trailing: Icon(
          Icons.info_outline,
          color: Colors.purple[600],
        ),
      ),
      ListTile(
        title: Text("What's wordpair",
            style: TextStyle(
                color: Colors.purple[600],
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return Scaffold(
                appBar: AppBar(
                    title: Text("What's wordpair",
                        style: TextStyle(color: Colors.white))),
                body: Text(
                    "Representation of a combination of 2 words, first and second. " +
                        "This is can be also described as a two-part compound (in the linguistic sense of the word).",
                    style: TextStyle(
                        color: Colors.purple[600],
                        fontSize: 20,
                        fontWeight: FontWeight.bold)));
          }));
        },
        trailing: Icon(
          Icons.help_outline,
          color: Colors.purple[600],
        ),
      )
    ]));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("WordPair Generator"),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)
          ],
        ),
        body: _buildListView(),
        drawer: _drawersWidget());
  }
}
