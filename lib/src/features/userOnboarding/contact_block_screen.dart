import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Your App Title'),
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => print('Add button pressed'),
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('This is some descriptive text'),
              ),
              TabBar(
                tabs: [
                  Tab(text: 'Tab 1'),
                  Tab(text: 'Tab 2'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ListView.builder(
                      itemCount: 10, // Replace with your data length
                      itemBuilder: (context, index) => ListTile(
                        title: Text('Item ${index + 1}'),
                      ),
                    ),
                    ListView.builder(
                      itemCount: 10, // Replace with your data length
                      itemBuilder: (context, index) => ListTile(
                        title: Text('Item ${index + 1}'),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () => print('Button pressed'),
                  child: Text('Black Button'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}