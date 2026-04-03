import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class FertilizersPage extends StatefulWidget {
  const FertilizersPage({super.key});

  @override
  State<FertilizersPage> createState() => _FertilizersPageState();
}

class _FertilizersPageState extends State<FertilizersPage> {
  List allData = []; // मूळ डेटा
  List displayData = []; // स्क्रीनवर दिसणारा डेटा
  bool isLoading = true;
  String errorMessage = "";
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchFertilizers();
  }

  Future<void> fetchFertilizers() async {
    setState(() {
      isLoading = true;
      errorMessage = "";
    });

    // तुमची Stein API लिंक (शेवटी Sheet नाव तपासा)
    const String apiUrl = "https://api.steinhq.com/v1/storages/69a2f6d0affba40a62560158/Sheet1";

    try {
      final response = await http.get(Uri.parse(apiUrl)).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> decodedData = json.decode(response.body);
        setState(() {
          allData = decodedData;
          displayData = decodedData; // सुरुवातीला सर्व खते दाखवा
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = "डेटा मिळाला नाही. (Status: ${response.statusCode})";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "इंटरनेट किंवा शीट तपासा!";
        isLoading = false;
      });
    }
  }

  // ✅ सर्च फंक्शन (हे नीट तपासा)
  void searchKhat(String query) {
    setState(() {
      if (query.isEmpty) {
        displayData = allData;
      } else {
        displayData = allData.where((item) {
          final String name = item['name']?.toString().toLowerCase() ?? "";
          final String company = item['company']?.toString().toLowerCase() ?? "";
          final String searchLower = query.toLowerCase();
          
          return name.contains(searchLower) || company.contains(searchLower);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("खते आणि बाजारभाव", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green[700],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // 🔎 सर्च बार
          Container(
            padding: const EdgeInsets.all(15),
            color: Colors.green[700],
            child: TextField(
              controller: searchController,
              onChanged: (value) => searchKhat(value),
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "खत किंवा कंपनीचे नाव शोधा...",
                hintStyle: TextStyle(color: Colors.grey[600]),
                prefixIcon: const Icon(Icons.search, color: Colors.green),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          
          // 📋 खतांची यादी
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator(color: Colors.green))
                : errorMessage.isNotEmpty
                    ? Center(child: Text(errorMessage))
                    : displayData.isEmpty
                        ? const Center(child: Text("माहिती सापडली नाही!"))
                        : ListView.builder(
                            padding: const EdgeInsets.all(10),
                            itemCount: displayData.length,
                            itemBuilder: (context, index) {
                              return _buildKhatCard(displayData[index]);
                            },
                          ),
          ),
        ],
      ),
    );
  }

  Widget _buildKhatCard(Map khat) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        title: Text(
          khat['name']?.toString() ?? "नाव नाही",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text("कंपनी: ${khat['company'] ?? '-'}", style: const TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 2),
            Text("वापर: ${khat['use_for'] ?? '-'}", maxLines: 2, overflow: TextOverflow.ellipsis),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              khat['price']?.toString() ?? "N/A",
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange, fontSize: 16),
            ),
            Text(khat['weight']?.toString() ?? "", style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}