import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Set<String> itemList = Set<String>();
  FlutterBlue flutterBlue = FlutterBlue.instance;
  var scanSubscription;

  @override
  void initState() {
    super.initState();
    scanSubscription = flutterBlue.scan().listen((ScanResult scanResult) {
      if (scanResult.advertisementData.localName.trim() != '') {
        debugPrint(scanResult.advertisementData.localName);
        setState(() {
          itemList.add(scanResult.advertisementData.localName);
        });
      }
    });
  }

  @override
  void dispose() {
    scanSubscription.cancel();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: itemList.toList().map((String item) {
          return ListTile(title: Text(item));
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      )
    );
  }
}
