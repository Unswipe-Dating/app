import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HyperExclusiveRequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFCEAA), // Set app bar background
        elevation: 0.0, // Remove app bar shadow
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black, // Set back button color
          onPressed: () => Navigator.pop(context), // Handle back button press
        ),
      ),
      body: Center(
        child:  Column(
            children: [
              Container(
                width: double.infinity,
                color: const Color(0xFFFFCEAA),
                child: Padding(padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ImageIcon(
                        AssetImage("assets/images/locked_heart.png"),
                        color: Colors.black,
                        size: 48,
                      ), // Replace with your desired icon
                      SizedBox(height: 20.0), // Add spacing
                      Text(
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'lato',
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0),
                        'Use this request when you think you have found the one',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10.0), // Add spacing
                      GestureDetector( // Make text clickable
                        child: Text(
                          'Know more',
                          style: TextStyle(color: Colors.blue),
                          textAlign: TextAlign.center,
                        ),
                        onTap: () => print('Clicked!'), // Handle click event
                      ),
                      SizedBox(height: 10.0), // Add spacing

                    ],
                  ),
                )
              ),
              SizedBox(height: 20,),
               Expanded(child: Padding(padding: EdgeInsets.all(20),
                 child: Column(
                children: [
                  Text(
                    style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'lato',
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0),
                    'Hyper exclusive request for A expires in: ',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.0), // Add spacing
                  FixedSizeListViewPage(),

                ],
              ),

              ),

              ),
              Container(
                width: double.infinity,
                child: Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0,), child:
                ElevatedButton(
                  onPressed: () => print('Button pressed!'),
                  child: Text('Go Hyper exclusive',
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'lato',
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0)),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                    foregroundColor: Colors.white, backgroundColor: Colors.black, // Set button text color
                  ),
                ),
                )
              ),

              SizedBox(height: 20,),

            ],
          )



          ,
        ),
    );
  }
}


class FixedSizeListViewPage extends StatefulWidget {
  @override
  _FixedSizeListViewPageState createState() => _FixedSizeListViewPageState();
}

class _FixedSizeListViewPageState extends State<FixedSizeListViewPage> {
  int _selectedIndex = -1; // Keep track of selected item index

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child:
      Container(
          height: 200.0,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
          child: Padding(padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
    child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              final isSelected = index == _selectedIndex;
              return  DecoratedBox(
                decoration: BoxDecoration(color: isSelected ?  Colors.black: null,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                    title: Center (child: Text('Item ${index + 1}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Playfair',
                            fontWeight: FontWeight.w500,
                            fontSize: 24.0)),
                    ),
                    // Change background color on selection
                    onTap: () {
                      setState(() {
                        _selectedIndex = isSelected
                            ? -1
                            : index; // Toggle selection if already selected, otherwise select
                      });
                    }
                ),
              );
            },
          ),
      ),
      ),
    );
  }
}