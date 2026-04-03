import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:xml/xml.dart'; // जर एरर आली तर 'flutter pub add xml' करा

class NewsListPage extends StatefulWidget {
  const NewsListPage({super.key});

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  List<Map<String, String>> _newsItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMarathiAgriNews();
  }

  Future<void> _fetchMarathiAgriNews() async {
    // हा पत्ता थेट Google News च्या मराठी शेती विभागाचा आहे
    const String rssUrl = 'https://news.google.com/rss/search?q=शेती+महाराष्ट्र+बाजारभाव&hl=mr&gl=IN&ceid=IN:mr';

    try {
      final response = await http.get(Uri.parse(rssUrl));
      if (response.statusCode == 200) {
        final document = XmlDocument.parse(response.body);
        final items = document.findAllElements('item');

        setState(() {
          _newsItems = items.map((node) {
            return {
              'title': node.findElements('title').first.innerText,
              'link': node.findElements('link').first.innerText,
              'pubDate': node.findElements('pubDate').first.innerText,
            };
          }).toList();
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("लाईव्ह मराठी शेती बातम्या", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green[800],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.green))
          : _newsItems.isEmpty
              ? const Center(child: Text("बातम्या लोड झाल्या नाहीत. इंटरनेट तपासा."))
              : ListView.builder(
                  itemCount: _newsItems.length,
                  itemBuilder: (context, index) {
                    final item = _newsItems[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      elevation: 3,
                      child: ListTile(
                        leading: const Icon(Icons.newspaper, color: Colors.green, size: 30),
                        title: Text(
                          item['title'] ?? "",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        subtitle: Text(item['pubDate'] ?? "", style: const TextStyle(fontSize: 10)),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                        onTap: () async {
                          final url = Uri.parse(item['link'] ?? "");
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url, mode: LaunchMode.externalApplication);
                          }
                        },
                      ),
                    );
                  },
                ),
    );
  }
}