import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  // 📞 फोन लावण्यासाठी फंक्शन
  Future<void> _makeCall() async {
    final Uri url = Uri.parse('tel:18001801551');
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        debugPrint('कॉल करता आला नाही');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // 🌐 वेबसाईट उघडण्यासाठी फंक्शन
  Future<void> _openWebsite() async {
    final Uri url = Uri.parse('https://mahadbt.maharashtra.gov.in/');
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        debugPrint('वेबसाईट उघडता आली नाही');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("मदत आणि मार्गदर्शन", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green[800],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column( // 👈 इथे 'Column' जोडला आहे, ज्यामुळे 'children' ची एरर निघून जाईल
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "महत्त्वाचे संपर्क",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 15),

            // 📞 किसान कॉल सेंटर कार्ड
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.call, color: Colors.white),
                ),
                title: const Text("किसान कॉल सेंटर (टोल फ्री)"),
                subtitle: const Text("१८००-१८०-१५५१"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: _makeCall,
              ),
            ),

            const SizedBox(height: 10),

            // 🌐 महाडीबीटी वेबसाईट कार्ड
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.language, color: Colors.white),
                ),
                title: const Text("महाडीबीटी पोर्टल (अर्ज करण्यासाठी)"),
                subtitle: const Text("mahadbt.maharashtra.gov.in"),
                trailing: const Icon(Icons.open_in_new, size: 16),
                onTap: _openWebsite,
              ),
            ),
            
            const SizedBox(height: 30),
            const Text(
              "नेहमीचे प्रश्न",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildFaqTile("अनुदान कधी मिळते?", "यंत्र खरेदी केल्यानंतर आणि कागदपत्रांची पडताळणी झाल्यावर अनुदान खात्यात जमा होते."),
            _buildFaqTile("लॉटरी कशी तपासायची?", "महाडीबीटी पोर्टलवर लॉगिन करून 'Status' मध्ये तुम्ही निवड झाली की नाही ते पाहू शकता."),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqTile(String title, String content) {
    return ExpansionTile(
      title: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(content),
        ),
      ],
    );
  }
}