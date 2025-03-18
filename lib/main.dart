import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Future<void> _incrementCounter() async {
    List<String> objects = ['apple', 'banana', 'cherry'];

    // Call the function to create description files
    await createDescriptions(objects);
    setState(() {
      _counter++;
    });
  }

  Future<void> createDescriptions(Iterable<String> objects) async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      for (final object in objects) {
        File file = File('${appDocDir.path}/$object.txt');

        if (await file.exists()) {
          DateTime modified = await file.lastModified();
          print('File for $object already exists. Last modified: $modified.');
          continue;
        }

        await file.create();
        await file.writeAsString('Start describing $object in this file.');
        print('File created: ${file.path}');
      }
    } on IOException catch (e) {
      print('Error creating file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.minimize),
      ),
    );
  }
}
