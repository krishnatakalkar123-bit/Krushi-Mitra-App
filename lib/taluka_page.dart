
import 'package:flutter/material.dart';
import 'data/maharashtra_data.dart';
import 'weather_page.dart';

class TalukaPage extends StatelessWidget {
  final String districtName;

  TalukaPage({required this.districtName});

  @override
  Widget build(BuildContext context) {

    final talukas = maharashtraData[districtName]!;

    return Scaffold(
      appBar: AppBar(
        title: Text(districtName),
        backgroundColor: Colors.green,
      ),

      body: ListView.builder(
        itemCount: talukas.length,
        itemBuilder: (context, index) {

          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(
                talukas[index]['name'],
                style: TextStyle(fontSize: 18),
              ),

              trailing: Icon(Icons.arrow_forward),

              onTap: () {
             Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const WeatherPage(),
  ),
);
              },
            ),
          );

        },
      ),
    );
  }
}