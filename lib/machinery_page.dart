import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MachineryPage extends StatefulWidget {
  const MachineryPage({super.key});

  @override
  State<MachineryPage> createState() => _MachineryPageState();
}

class _MachineryPageState extends State<MachineryPage> {
  List machineryList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMachinery();
  }

  Future<void> fetchMachinery() async {
    const String apiUrl = "https://api.steinhq.com/v1/storages/69a3c311affba40a62564c0f/Sheet3";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          machineryList = json.decode(response.body);
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() { isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("आधुनिक शेती यंत्रे", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green[800],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: machineryList.length,
              itemBuilder: (context, index) {
                final machine = machineryList[index];

                // 🛠️ बदल १: तुझ्या फोल्डरचा अचूक मार्ग (Path)
                // आपण इथे "assets/yentre/" जोडला आहे कारण तुझे फोटो त्या फोल्डरमध्ये आहेत
                String imageName = (machine['image'] ?? "").toString().trim();
                String assetPath = "assets/yentre/$imageName"; 

                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🖼️ लोकल इमेज (Assets)
                      Image.asset(
                        assetPath,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 200,
                          color: Colors.grey[200],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                              Text("फोटो मिळाला नाही: $imageName", 
                                style: const TextStyle(color: Colors.grey, fontSize: 10),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              machine['name'] ?? "यंत्र", 
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                            ),
                            const SizedBox(height: 8),
                            Text(
                              machine['detail'] ?? "-", 
                              style: const TextStyle(fontSize: 14, color: Colors.black87),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Divider(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "किंमत: ${machine['price'] ?? 'N/A'}", 
                                    style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)
                                  )
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.green[100], 
                                    borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Text(
                                    "अनुदान: ${machine['subsidy'] ?? '-'}", 
                                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green)
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}