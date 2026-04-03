import 'dart:io'; // फाईल हाताळण्यासाठी
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // लायब्ररी विसरू नका
import 'package:image_picker/image_picker.dart'; // १. फोटो निवडण्यासाठी
import 'package:krushi_app/main.dart'; // 'LoginPage' क्लास जिथे आहे, तो पाथ

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = "शेतकरी मित्र"; // सुरुवातीला एक डिफॉल्ट नाव
  String userLocation = "महाराष्ट्र, भारत";
  String? _imagePath; // २. निवडलेल्या फोटोचा पत्ता साठवण्यासाठी

  @override
  void initState() {
    super.initState();
    _loadUserData(); // पेज उघडताच नाव आणि फोटो लोड करा
  }

  // ३. मोबाईल मेमरीमधून नाव आणि फोटोचा पत्ता मिळवण्यासाठी फंक्शन
  _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name') ?? "शेतकरी मित्र";
      _imagePath = prefs.getString('user_profile_image'); // ४. फोटोचा पाथ लोड करा
    });
  }

  // ५. गॅलरीतून फोटो निवडण्याचे आणि सेव्ह करण्याचे फंक्शन
  Future<void> _pickAndSaveImage() async {
    final ImagePicker picker = ImagePicker();
    // गॅलरी उघडा
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        _imagePath = image.path; // ६. स्क्रीनवर फोटो दाखवण्यासाठी स्टेट अपडेट करा
      });
      await prefs.setString('user_profile_image', image.path); // ७. मोबाईलमध्ये सेव्ह करा
      
      if(mounted) {
         ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("प्रोफाईल फोटो यशस्वीरित्या सेव्ह झाला!")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("प्रोफाईल व माहिती", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), // ८. टायटल बोल्ड केले
        backgroundColor: Colors.green[800],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // १. प्रोफाईल विभाग
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              color: Colors.green[50],
              child: Column(
                children: [
                  // ९. फोटो दाखवण्यासाठी CircleAvatar
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 65, // बाहेरची बॉर्डर
                        backgroundColor: Colors.green[800],
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          // १०. मुख्य लॉजिक: जर फोटो सेट केला असेल तर तो दाखवा, नसेल तर डिफॉल्ट लोगो
                          backgroundImage: _imagePath != null
                              ? FileImage(File(_imagePath!)) // युजरचा फोटो
                              : const AssetImage('assets/proimage/pro.png') as ImageProvider, // ११. तुमचा डिफॉल्ट लोगो (image_1.png सारखा)
                          // १२. जर काही एरर आला तर डिफॉल्ट आयकॉन
                          child: _imagePath == null
                              ? null 
                              : null,
                        ),
                      ),
                      // १३. फोटो बदलण्यासाठी कॅमेरा बटण
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.green[100],
                          radius: 20,
                          child: IconButton(
                            icon: Icon(Icons.camera_alt, color: Colors.green[900]),
                            onPressed: _pickAndSaveImage, // कॅमेरा दाबा आणि फोटो निवडा
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    userName, 
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(userLocation, style: const TextStyle(color: Colors.grey, fontSize: 16)),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // २. About Us
            ExpansionTile(
              leading: const Icon(Icons.info_outline, color: Colors.green),
              title: const Text("ॲपबद्दल माहिती (About Us)", style: TextStyle(fontWeight: FontWeight.bold)),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Krushi App (कृषी मित्र)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green)),
                      Divider(),
                      Text("१. ॲपचा मुख्य उद्देश", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("• ग्रामीण भागातील शेतकऱ्यांना तंत्रज्ञानाशी जोडून सक्षम करणे.\n• हवामान, बाजारभाव आणि पीक माहिती एकाच ठिकाणी देणे."),
                      SizedBox(height: 10),
                      Text("२. प्रमुख वैशिष्ट्ये", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("• पूर्णपणे मराठी भाषेला प्राधान्य.\n• रोजचे बाजारभाव आणि पिकांची सखोल माहिती."),
                      SizedBox(height: 10),
                      Text("३. आमची टीम", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("शासकीय तंत्रनिकेतन, जिंतूर येथील CO6K (Third Year) च्या विद्यार्थ्यांनी विकसित केले आहे."),
                      Divider(),
                    ],
                  ),
                ),
              ],
            ),

            // ३. Contact Us
            ExpansionTile(
              leading: const Icon(Icons.contact_phone_outlined, color: Colors.green),
              title: const Text("आमची टीम (Contact Team)", style: TextStyle(fontWeight: FontWeight.bold)),
              children: [
                _contactItem("Onkar Dhembare", "7822091552", "onkardhembare@gmail.com"),
                _contactItem("Ganesh Rengade", "9637219035", "ganeshrengade@gmail.com"),
                _contactItem("Aditya Suryawanshi", "9130310470", "adityasuryawanshi@gmail.com"),
                _contactItem("Krishna Takalkar", "7972723161", "krishnatakalkar@gmail.com"),
              ],
            ),

            const Divider(),

            // ४. लॉगआउट
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("बाहेर पडा (Log Out)", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear(); // १४. लॉगआउट होताना फोटोचा पाथ पण डिलीट होईल

                // २. थेट लॉगिन पेजवर जा
                if(mounted) {
                   Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) =>  LoginPage()), // तुमच्या लॉगिन पेजचे नाव
                    (Route<dynamic> route) => false, 
                  );
                }
              },
            ),

            const SizedBox(height: 20),

            // ५. ॲप व्हर्जन
            const Column(
              children: [
                Text("App Version", style: TextStyle(color: Colors.grey, fontSize: 12)),
                Text("१.०.० (Stable)", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 14)),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _contactItem(String name, String phone, String email) {
    return ListTile(
      leading: const Icon(Icons.person_outline, color: Colors.green),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text("📞 $phone\n📧 $email", style: const TextStyle(fontSize: 13)),
      isThreeLine: true,
      trailing: const Icon(Icons.call, color: Colors.green, size: 20),
    );
  }
}