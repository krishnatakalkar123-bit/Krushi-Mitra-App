import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class AdvicePage extends StatefulWidget {
  const AdvicePage({super.key});

  @override
  State<AdvicePage> createState() => _AdvicePageState();
}

class _AdvicePageState extends State<AdvicePage> {
  List allAdvice = [];
  List filteredAdvice = [];
  bool isLoading = true;
  String errorMessage = "";
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchAdvice();
  }

  Future<void> fetchAdvice() async {
    setState(() {
      isLoading = true;
      errorMessage = "";
    });

    // ✅ तुमची नवीन API लिंक इथे अपडेट केली आहे
    const String apiUrl = "https://api.steinhq.com/v1/storages/69a3c0c2affba40a62564ba8/Sheet2";

    try {
      final response = await http.get(Uri.parse(apiUrl)).timeout(
        const Duration(seconds: 10),
      );

      if (response.statusCode == 200) {
        final List<dynamic> decodedData = json.decode(response.body);
        setState(() {
          allAdvice = decodedData;
          filteredAdvice = decodedData;
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = "माहिती मिळाली नाही. (Status: ${response.statusCode})";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "इंटरनेट कनेक्शन तपासा!";
        isLoading = false;
      });
    }
  }

  // 🔍 पिकाचे नाव शोधण्यासाठी फंक्शन
  void filterSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredAdvice = allAdvice;
      } else {
        filteredAdvice = allAdvice.where((item) {
          final crop = item['crop_name']?.toString().toLowerCase() ?? "";
          final problem = item['problem']?.toString().toLowerCase() ?? "";
          return crop.contains(query.toLowerCase()) || problem.contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        title: const Text("तज्ज्ञ सल्ला आणि उपाय", 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orange[800],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // 🔎 सर्च बार
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.orange[800],
            child: TextField(
              controller: searchController,
              onChanged: filterSearch,
              decoration: InputDecoration(
                hintText: "पिकाचे नाव किंवा रोग शोधा (उदा. कापूस)",
                prefixIcon: const Icon(Icons.search, color: Colors.orange),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator(color: Colors.orange))
                : errorMessage.isNotEmpty
                    ? Center(child: Text(errorMessage))
                    : ListView.builder(
                        padding: const EdgeInsets.all(10),
                        itemCount: filteredAdvice.length,
                        itemBuilder: (context, index) {
                          final advice = filteredAdvice[index];
                          return _buildAdviceCard(advice);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdviceCard(Map advice) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        leading: const Icon(Icons.eco, color: Colors.green),
        title: Text(
          advice['crop_name']?.toString() ?? "पीक",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text("रोग: ${advice['problem'] ?? '-'}", 
          style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500)),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                const Text("उपाय:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 5),
                Text(advice['solution'] ?? "माहिती उपलब्ध नाही.", 
                  style: const TextStyle(fontSize: 15)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.science, size: 18, color: Colors.blue),
                    const SizedBox(width: 5),
                    Text("प्रमाण (Dose): ${advice['dose'] ?? '-'}", 
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          )
        ],
      ),
    );
  }
}