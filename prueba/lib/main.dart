import 'package:flutter/material.dart';// para que funcione en la linea de comandos poner "flutter pub add english_words"
import 'package:english_words/english_words.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';  //  flutter pub add flutter_colorpicker
import 'package:pie_chart/pie_chart.dart'; //  flutter pub add pie_chart
import 'dart:math';
Random random = new Random();
void main() {
  runApp(const MyApp());
}
Map<String, double> dataMap = {
  "SlowSeat": 50,
  "MildSoul": 37,
  "ShyCart": 2,
  "PlainTip": 25,
};

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Random Name Generator',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
      ),
      home: const Menu(),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _Menu();
}


class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 20);
  void _pushSaved(){
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context){
          final tiles = _saved.map(
                (pair){
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList(): <Widget>[];
          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Name Generator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _pushSaved,
            tooltip: 'Saved Suggestions',
          )
        ],
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemBuilder: (context, i){
            if (i.isOdd) return const Divider();
            final index = i ~/2;//divides i by 2 and returns an integer as a result.
            if (index >= _suggestions.length){
              _suggestions.addAll(generateWordPairs().take(10));
            }
            final alreadySaved = _saved.contains(_suggestions[index]);
            return ListTile(
                title: Text(
                  _suggestions[index].asPascalCase,
                  style: _biggerFont,
                ),
                trailing: Icon(
                  alreadySaved ? Icons.favorite : Icons.favorite_border,
                  color: alreadySaved ? Colors.red : null,
                  semanticLabel: alreadySaved ? 'Remove from saved': 'Save',
                ),
                onTap: (){
                  setState(() {
                    if(alreadySaved){
                      _saved.remove(_suggestions[index]);
                    }else{
                      _saved.add(_suggestions[index]);
                    }
                  });
                }
            );
          }
      ),
    );
  }
}


class _Menu extends State<Menu> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 20);
  void _pushSaved(){
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context){
          final tiles = _saved.map(
                (pair){
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList(): <Widget>[];
          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
  String msg = 'Random Name Generator';
  int val = 1;
  int graph=0;
  Color pickerColor = Color(0xffffffff);
  Color currentColor =Color(0xffffffff);
  @override
  Widget build(BuildContext context) {
    if(val==1) {
      return Scaffold(
        backgroundColor: pickerColor,
        appBar: AppBar(toolbarHeight: 350,
          title: Image.asset('assets/images/dart1.jpg',width: 1000000,
              fit:BoxFit.contain),
        ),
        body: Container(



          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(msg, style: TextStyle(
                  fontSize: 30, fontStyle: FontStyle.italic),),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // background
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: _randomWords,
                child: Text('Generator'),
              ),

              Container(



                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ColorPicker(
                          pickerColor: pickerColor,
                          onColorChanged: changeColor,
                        ),ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red, // background
                            onPrimary: Colors.white, // foreground
                          ),
                          onPressed: _changeGraph,
                          child: Text('Cambiar Grafico'),
                        ),

                        PieChart(
                          dataMap: dataMap,
                          animationDuration: Duration(milliseconds: 800),
                          chartLegendSpacing: 32,
                          chartRadius: MediaQuery.of(context).size.width / 5,

                          initialAngleInDegree: 0,
                          chartType: ChartType.ring,
                          ringStrokeWidth: 32,
                          centerText: "Names",
                          legendOptions: LegendOptions(
                            showLegendsInRow: false,
                            legendPosition: LegendPosition.right,
                            showLegends: true,

                            legendTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          chartValuesOptions: ChartValuesOptions(
                            showChartValueBackground: true,
                            showChartValues: true,
                            showChartValuesInPercentage: false,
                            showChartValuesOutside: false,
                            decimalPlaces: 1,
                          ),
                          // gradientList: ---To add gradient colors---
                          // emptyColorGradient: ---Empty Color gradient---
                        ),
                      ]

                  )),

            ],
          ),


        ),

      );



    }
    else{
      return Scaffold(
        backgroundColor: pickerColor,
        appBar: AppBar(
          title: const Text('Random Name Generator'),
          leading: GestureDetector(
            onTap: _goMenu,

            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Icon(
                Icons.arrow_back,
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: _pushSaved,
              tooltip: 'Saved Suggestions',
            )
          ],
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (context, i){
              if (i.isOdd) return const Divider();
              final index = i ~/2;//divides i by 2 and returns an integer as a result.
              if (index >= _suggestions.length){
                _suggestions.addAll(generateWordPairs().take(10));
              }
              final alreadySaved = _saved.contains(_suggestions[index]);
              return ListTile(
                  title: Text(
                    _suggestions[index].asPascalCase,
                    style: _biggerFont,
                  ),
                  trailing: Icon(
                    alreadySaved ? Icons.favorite : Icons.favorite_border,
                    color: alreadySaved ? Colors.red : null,
                    semanticLabel: alreadySaved ? 'Remove from saved': 'Save',
                  ),
                  onTap: (){
                    setState(() {
                      if(alreadySaved){
                        _saved.remove(_suggestions[index]);
                      }else{
                        _saved.add(_suggestions[index]);
                      }
                    });
                  }
              );
            }
        ),
      );
    }


  }
  _randomWords() {
    setState(() {
      val=2;
    });
  }
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  _goMenu() {
    setState(() {
      val=1;
    });
  }
  _changeGraph() {
    setState(() {
      dataMap = {
        "SlowSeat": random.nextInt(50).toDouble(),
        "MildSoul": random.nextInt(50).toDouble(),
        "ShyCart": random.nextInt(50).toDouble(),
        "PlainTip": random.nextInt(50).toDouble(),
      };
    });
  }
}