import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class SchemesPage extends StatefulWidget {
  const SchemesPage({super.key});

  @override
  State<SchemesPage> createState() => _SchemesPageState();
}

class _SchemesPageState extends State<SchemesPage> {
  List liveSchemes = [];
  bool isLoading = true;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    fetchSchemes();
  }

  Future<void> fetchSchemes() async {
    setState(() {
      isLoading = true;
      errorMessage = "";
    });

    const String apiUrl = "https://api.steinhq.com/v1/storages/69a29eb7affba40a6255b4f5/Sheet1";

    try {
      final response = await http.get(Uri.parse(apiUrl)).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException("कनेक्शनसाठी खूप वेळ लागत आहे. इंटरनेट तपासा!");
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> decodedData = json.decode(response.body);
        setState(() {
          liveSchemes = decodedData;
          isLoading = false;
          if (liveSchemes.isEmpty) {
            errorMessage = "सध्या कोणतीही योजना उपलब्ध नाही.";
          }
        });
      } else {
        setState(() {
          errorMessage = "डेटा मिळाला नाही. (Status Code: ${response.statusCode})";
          isLoading = false;
        });
      }
    } on TimeoutException catch (_) {
      setState(() {
        errorMessage = "वेळ संपली! कृपया तुमचे इंटरनेट तपासा.";
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = "काहीतरी चूक झाली. कृपया Google Sheet आणि इंटरनेट तपासा!";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("लाईव्ह सरकारी योजना", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green[800],
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchSchemes,
            tooltip: "रिफ्रेश करा",
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.green))
          : errorMessage.isNotEmpty
              ? _buildErrorWidget()
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: liveSchemes.length,
                  itemBuilder: (context, index) {
                    final scheme = liveSchemes[index];
                    return _buildSchemeCard(
                      scheme['title']?.toString() ?? "No Title",
                      scheme['desc']?.toString() ?? "No Description",
                      scheme['eligibility']?.toString() ?? "N/A",
                      scheme['url']?.toString() ?? "",
                    );
                  },
                ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 60),
            const SizedBox(height: 10),
            Text(errorMessage, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchSchemes,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green[800]),
              child: const Text("पुन्हा प्रयत्न करा", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSchemeCard(String title, String desc, String eligibility, String url) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black)),
        leading: const CircleAvatar(
          backgroundColor: Colors.orange,
          child: Icon(Icons.account_balance, color: Colors.white, size: 20)
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                _buildInfoSection("माहिती:", desc),
                const SizedBox(height: 12),
                _buildInfoSection("पात्रता:", eligibility),
                const SizedBox(height: 20),
                if (url.isNotEmpty && url.contains("http"))
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.open_in_new, size: 18, color: Colors.white),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                      ),
                      label: const Text("अधिक माहिती / अर्ज करा", style: TextStyle(color: Colors.white, fontSize: 15)),
                      onPressed: () async {
                        final Uri uri = Uri.parse(url.trim());
                        try {
                          // थेट ब्राउझरमध्ये उघडण्यासाठी LaunchMode.externalApplication वापरले आहे
                          await launchUrl(uri, mode: LaunchMode.externalApplication);
                        } catch (e) {
                          debugPrint("Error: $e");
                        }
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String label, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 14)),
        const SizedBox(height: 4),
        Text(content, style: const TextStyle(fontSize: 15, color: Colors.black87)),
      ],
    );
  }
}