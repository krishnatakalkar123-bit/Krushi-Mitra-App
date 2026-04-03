

import 'package:flutter/material.dart';
import 'data/maharashtra_data.dart';
import 'taluka_page.dart';

class DistrictPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final districts = maharashtraData.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Select District"),
        backgroundColor: Colors.green,
      ),

      body: ListView.builder(
        itemCount: districts.length,
        itemBuilder: (context, index) {

          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(
                districts[index],
                style: TextStyle(fontSize: 18),
              ),

              trailing: Icon(Icons.arrow_forward),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TalukaPage(
                      districtName: districts[index],
                    ),
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