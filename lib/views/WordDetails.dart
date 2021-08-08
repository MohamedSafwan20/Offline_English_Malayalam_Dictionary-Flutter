import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:offline_english_malayalam_dictionary/database/db.dart';
import 'package:sqflite/sqflite.dart';

class WordDetails extends StatefulWidget {
  const WordDetails({Key? key}) : super(key: key);

  @override
  _WordDetailsState createState() => _WordDetailsState();
}

class _WordDetailsState extends State<WordDetails> {
  Object? word = '';

  var malayalamDefinition;

  FlutterTts flutterTts = FlutterTts();

  Future<List> _getMalayalamDefinition() async {
    Database db = await DictionaryDatabase.instance.database;

    return await db.query('dictionary',
        columns: ["malayalam_word"], where: 'english_word="$word"');
  }

  void _speak(String word) {
    flutterTts.speak(word);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    word = ModalRoute.of(context)!.settings.arguments;
    malayalamDefinition = _getMalayalamDefinition();
    return Scaffold(
        appBar:
            AppBar(title: Text(word.toString()), centerTitle: true, actions: [
          IconButton(
            onPressed: () {
              _speak(word.toString());
            },
            padding: const EdgeInsets.all(10.0),
            icon: Icon(
              Icons.volume_up,
            ),
          )
        ]),
        body: FutureBuilder(
          future: malayalamDefinition,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List definitions = snapshot.data[0]['malayalam_word'].split(";");
              return ListView.builder(
                  itemCount: definitions.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(8),
                      child: Text(
                        '-> ${definitions[index]}',
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  });
            }

            return Text("Error");
          },
        ));
  }
}
