import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyUIButtoms(),
    );
  }
}

class MyUIButtoms extends StatelessWidget {
  const MyUIButtoms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              TextButton(
                onPressed: null,
                child: const Text('TextButton Disabled'),
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () {},
                child: const Text('TextButton Enabled'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: null,
                child: const Text('ElevatedButton Disabled'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                child: const Text('ElevatedButton Enabled'),
              ),
              const SizedBox(height: 30),
              OutlinedButton(
                onPressed: null,
                child: const Text('OutlinedButton Disabled'),
              ),
              const SizedBox(height: 30),
              OutlinedButton(
                onPressed: () {},
                child: const Text('OutlinedButton Enabled'),
              ),
              const SizedBox(height: 30),
              IconButton(
                icon: const Icon(Icons.volume_up),
                tooltip: 'Increase volume by 10',
                onPressed: null,
              ),
              Text('IconButton Disabled'),
              const SizedBox(height: 30),
              IconButton(
                icon: const Icon(Icons.volume_up),
                tooltip: 'Increase volume by 10',
                onPressed: () {},
              ),
              Text('IconButton Enabled'),
              const SizedBox(height: 30),
              Ink(
                decoration: const ShapeDecoration(
                  color: Colors.lightBlue,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: const Icon(Icons.android),
                  color: Colors.white,
                  onPressed: () {},
                ),
              ),
              Text('IconButton With Ink Enabled'),
            ],
          ),
        ),
      ),
    );
  }
}
