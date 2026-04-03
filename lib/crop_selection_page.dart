import 'package:flutter/material.dart';
import 'crop_info_page.dart';

class CropSelectionPage extends StatelessWidget {

  // ✅ 30+ Crops List
  final List<String> crops = [
    "Wheat", "Rice", "Cotton", "Sugarcane", "Soybean",
    "Maize", "Bajra", "Jowar", "Tur", "Gram",
    "Moong", "Urad", "Groundnut", "Sunflower", "Mustard",
    "Onion", "Potato", "Tomato", "Chili", "Brinjal",
    "Cabbage", "Cauliflower", "Spinach", "Fenugreek",
    "Coriander", "Garlic", "Ginger", "Papaya",
    "Banana", "Mango", "Grapes"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Crop"),
        backgroundColor: Colors.green,
      ),

      // ✅ GRID UI (Modern Look 😎)
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        itemCount: crops.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),

        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CropInfoPage(cropName: crops[index]),
                ),
              );
            },

            // ✅ Card Design
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  crops[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}