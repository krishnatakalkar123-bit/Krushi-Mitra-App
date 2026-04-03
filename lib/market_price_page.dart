import 'package:flutter/material.dart';

class MarketPricePage extends StatefulWidget {
  @override
  _MarketPricePageState createState() => _MarketPricePageState();
}

class _MarketPricePageState extends State<MarketPricePage> {
  // महाराष्ट्रातील जिल्हे
  String selectedCity = "Pune (पुणे)";
  final List<String> cities = [
    "Pune (पुणे)", "Mumbai (मुंबई)", "Nagpur (नागपूर)", 
    "Nashik (नाशिक)", "Latur (लातूर)", "Chhatrapati Sambhajinagar",
    "Solapur (सोलापूर)", "Kolhapur (कोल्हापूर)", "Amravati (अमरावती)"
  ];

  // एकाच शहरासाठी सर्व २० पिकांची यादी
  List<Map<String, String>> getAllCropRates(String city) {
    // हे भाव सध्या सरासरी दिले आहेत, तुम्ही तुमच्या सोयीनुसार बदलू शकता
    return [
      {"crop": "Wheat (गहू)", "price": "2400 - 3200"},
      {"crop": "Rice (तांदूळ)", "price": "3500 - 6000"},
      {"crop": "Jowar (ज्वारी)", "price": "2800 - 4500"},
      {"crop": "Bajra (बाजरी)", "price": "2200 - 2800"},
      {"crop": "Maize (मका)", "price": "2000 - 2400"},
      {"crop": "Cotton (कापूस)", "price": "6800 - 7500"},
      {"crop": "Sugarcane (ऊस)", "price": "2800 - 3200"},
      {"crop": "Soybean (सोयाबीन)", "price": "4200 - 4800"},
      {"crop": "Tur (तूर)", "price": "9000 - 10500"},
      {"crop": "Gram (हरभरा)", "price": "5500 - 6500"},
      {"crop": "Onion (कांदा)", "price": "1500 - 3500"},
      {"crop": "Tomato (टोमॅटो)", "price": "1200 - 2500"},
      {"crop": "Potato (बटाटा)", "price": "1500 - 2500"},
      {"crop": "Chilli (मिरची)", "price": "3000 - 8000"},
      {"crop": "Garlic (लसूण)", "price": "8000 - 15000"},
      {"crop": "Ginger (आले)", "price": "4000 - 7000"},
      {"crop": "Turmeric (हळद)", "price": "12000 - 16000"},
      {"crop": "Mango (आंबा)", "price": "5000 - 15000"},
      {"crop": "Banana (केळी)", "price": "1200 - 2000"},
      {"crop": "Pomegranate (डाळिंब)", "price": "6000 - 12000"},
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> rates = getAllCropRates(selectedCity);

    return Scaffold(
      appBar: AppBar(
        title: Text("$selectedCity - सर्व पिकांचे भाव"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          // जिल्हा निवडा विभाग
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: DropdownButtonFormField<String>(
              value: selectedCity,
              decoration: InputDecoration(
                labelText: "जिल्हा निवडा",
                border: OutlineInputBorder(),
              ),
              items: cities.map((city) => DropdownMenuItem(value: city, child: Text(city))).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCity = value!;
                });
              },
            ),
          ),

          // सर्व २० पिकांची लिस्ट
          Expanded(
            child: ListView.builder(
              itemCount: rates.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  child: ListTile(
                    leading: Icon(Icons.eco, color: Colors.green),
                    title: Text(rates[index]['crop']!, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("बाजार: $selectedCity"),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("₹${rates[index]['price']}", 
                             style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16)),
                        Text("प्रति क्विंटल", style: TextStyle(fontSize: 10, color: Colors.grey)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}