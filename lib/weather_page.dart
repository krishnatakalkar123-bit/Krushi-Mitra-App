import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  TextEditingController cityController = TextEditingController();
  
  String temp = "33";
  String humidity = "31";
  String wind = "5";
  String cityName = "मानवत, IN";
  String description = "अंशतः ढगाळ";
  String tempMax = "33";
  String tempMin = "19";
  String rainChance = "24";

  final String myApiKey = "714e3f06973e6a9b793e031b6117d876";

  Future<void> fetchWeather(String city) async {
    if (city.isEmpty) return;
    try {
      final url = "https://api.openweathermap.org/data/2.5/weather?q=$city,IN&appid=$myApiKey&units=metric&lang=mr";
      final res = await http.get(Uri.parse(url));

      if (res.statusCode == 200) {
        updateUI(jsonDecode(res.body));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("शहर सापडले नाही!")));
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  void updateUI(dynamic data) {
    setState(() {
      cityName = "${data['name']}, ${data['sys']['country']}";
      temp = data['main']['temp'].toInt().toString();
      tempMax = data['main']['temp_max'].toInt().toString();
      tempMin = data['main']['temp_min'].toInt().toString();
      humidity = data['main']['humidity'].toString();
      wind = data['wind']['speed'].toString();
      description = data['weather'][0]['description'];
      rainChance = data['clouds']['all'].toString(); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // आकर्षक बॅकग्राउंड ग्रेडियंट
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8F5E9), // फिकट हिरवा (वरचा भाग)
              Color(0xFFC8E6C9), // थोडा गडद हिरवा (खालचा भाग)
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Header (तुमचा लोगो आणि नाव)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/logoimage/logo.png', 
                      height: 50, 
                      width: 50,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Krushi App",
                      style: TextStyle(
                        fontSize: 26, 
                        fontWeight: FontWeight.bold, 
                        color: Colors.green[900]
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Search Bar
                TextField(
                  controller: cityController,
                  decoration: InputDecoration(
                    hintText: "शहर शोधा (उदा. Manwat)...",
                    prefixIcon: const Icon(Icons.search, color: Colors.green),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8), // पारदर्शक पांढरा
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30), 
                      borderSide: BorderSide.none
                    ),
                  ),
                  onSubmitted: (value) => fetchWeather(value),
                ),

                const SizedBox(height: 30),

                // Main Display
                const Icon(Icons.wb_cloudy_outlined, size: 80, color: Colors.blue),
                const SizedBox(height: 10),
                Text(cityName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                Text("$temp°C", style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w900)),
                Text(description, style: const TextStyle(fontSize: 18, color: Colors.blueGrey)),

                const SizedBox(height: 20),

                // Summary Box
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9), 
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
                    ]
                  ),
                  child: Column(
                    children: [
                      Text("आज कमाल $tempMax°C आणि किमान $tempMin°C तापमान राहील.", textAlign: TextAlign.center),
                      const Divider(),
                      Text("पावसाची शक्यता: $rainChance%", style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Details Grid
                const Align(
                  alignment: Alignment.centerLeft, 
                  child: Text("आजचे तपशील", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    detailCard("वारा", "$wind km/h", Icons.air),
                    detailCard("आद्रता", "$humidity%", Icons.water_drop),
                    detailCard("पाऊस", "$rainChance%", Icons.umbrella),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget detailCard(String label, String val, IconData icon) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.28,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9), 
        borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.green),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          Text(val, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}