import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:krushi_app/news_card.dart'; 
import 'crop_info_page.dart';
import 'crop_selection_page.dart';
import 'db_helper.dart';
import 'market_price_page.dart';
import 'weather_page.dart';
import 'data/maharashtra_data.dart';
import 'district_page.dart';
import 'schemes_page.dart';
import 'fertilizers_page.dart';
import 'advice_page.dart';
import 'machinery_page.dart';
import 'help_page.dart';
import 'profile_page.dart';

// १. 🟢 AUTO-LOGIN साठी 'main' फंक्शनमध्ये बदल
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userName = prefs.getString('user_name');

  runApp(MaterialApp(
    // जर 'user_name' मेमरीमध्ये असेल, तर थेट 'MainHolder' उघडा, नाहीतर 'LoginPage'
    home: userName != null ? const MainHolder() : LoginPage(), 
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.green),
  ));
}

// 📱 MAIN HOLDER (Navigation Bar)
class MainHolder extends StatefulWidget {
  const MainHolder({super.key});

  @override
  State<MainHolder> createState() => _MainHolderState();
}

class _MainHolderState extends State<MainHolder> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const WeatherPage(),
    MarketPricePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green[800],
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'मुख्य पान'),
          BottomNavigationBarItem(icon: Icon(Icons.cloud), label: 'हवामान'),
          BottomNavigationBarItem(icon: Icon(Icons.currency_rupee), label: 'बाजारभाव'),
        ],
      ),
    );
  }
}

// 🔐 नवीन आणि प्रोफेशनल LOGIN PAGE
// 🔐 सुधारित LOGIN PAGE (डेव्हलपर माहितीसह)
class LoginPage extends StatelessWidget {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  LoginPage({super.key});

  // टीम मेंबर्ससाठी हेल्पर फंक्शन
  Widget _buildTeamMember(String name, String role) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          Text(role, style: TextStyle(fontSize: 11, color: Colors.green[700])),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // हेडर डिझाईन
            Container(
              height: 280,
              decoration: BoxDecoration(
                color: Colors.green[800],
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(100)),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: Image.asset(
                        'assets/logoimage/logo.png',
                        height: 90,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.eco, size: 70, color: Colors.green),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text("कृषी मित्र", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  TextField(
                    controller: username,
                    decoration: InputDecoration(
                      labelText: "Username",
                      prefixIcon: const Icon(Icons.person_outline, color: Colors.green),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: const Icon(Icons.lock_outline, color: Colors.green),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      onPressed: () async {
                        String user = username.text;
                        String pass = password.text;
                        bool isValid = await DBHelper.loginCheck(user, pass);

                        if (isValid) {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setString('user_name', user); 
                          if (context.mounted) {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainHolder()));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("चुकीचा युजरनेम किंवा पासवर्ड!"), backgroundColor: Colors.red));
                        }
                      },
                      child: const Text("लॉगिन करा", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage())),
                    child: const Text("नवीन खाते उघडण्यासाठी येथे क्लिक करा", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // --- डेव्हलपर ऑप्शन इकडे ॲड केला आहे ---
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            title: const Column(
                              children: [
                                Icon(Icons.groups, color: Colors.green, size: 40),
                                SizedBox(height: 10),
                                Text("Project Team", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
                              ],
                            ),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: [
                                  const Divider(color: Colors.green),
                                  _buildTeamMember("Omkar Dhembare", "App Testing & QA"),
                                  _buildTeamMember("Ganesh Rengade", "System Analyst & Documentation"),
                                  _buildTeamMember("Aditya Suryawanshi", "Backend & Database Expert"),
                                  _buildTeamMember("Krishna Takalkar", "Lead Developer & UI Design"),      
                                  const Divider(color: Colors.green),
                                  const SizedBox(height: 10),
                                  Text("3rd Year (CO6K) Students\nGovt. Poly, Jintur",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Close", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text("@developer", 
                        style: TextStyle(
                          fontSize: 14, 
                          fontStyle: FontStyle.italic, 
                          decoration: TextDecoration.underline, 
                          color: Colors.grey[600]
                        )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🏠 सुधारित HOME PAGE
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // हलका राखाडी रंग
      appBar: AppBar(
        title: const Text(
          "कृषी मित्र",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[800],
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white, size: 32),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage())),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // १. हवामान कार्ड (Weather Section)
            _buildWeatherCard(),

            // २. मुख्य सेवा (Services Title)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "आमच्या सेवा",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ),

            // ३. गोलाकार बटणांची ग्रीड
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                mainAxisSpacing: 15,
                crossAxisSpacing: 5,
                children: [
                  _circleMenu(context, "पिके", Icons.eco, Colors.green, CropSelectionPage()),
                  _circleMenu(context, "बाजारभाव", Icons.trending_up, Colors.orange, MarketPricePage()),
                  _circleMenu(context, "हवामान", Icons.cloud, Colors.blue, const WeatherPage()),
                  _circleMenu(context, "योजना", Icons.description, Colors.red, const SchemesPage()),
                  _circleMenu(context, "खते", Icons.science, Colors.teal, const FertilizersPage()),
                  _circleMenu(context, "सल्ला", Icons.psychology, Colors.purple, const AdvicePage()),
                  _circleMenu(context, "यंत्रे", Icons.settings_input_component, Colors.brown, const MachineryPage()),
                  _circleMenu(context, "मदत", Icons.help, Colors.blueGrey, const HelpPage()),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ४. ताज्या बातम्या विभाग (News Banner)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "ताज्या अपडेट्स",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ),

            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NewsListPage())),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5)),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Image.asset(
                        "assets/images/wheat.jpg",
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        height: 180,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "शेतकरी बातम्या वाचण्यासाठी क्लिक करा",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // --- UI डिझाईन फंक्शन्स ---

  Widget _buildWeatherCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green[700]!, Colors.green[900]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(color: Colors.green.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("आजचे हवामान", style: TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 5),
              const Text("30°C", style: TextStyle(color: Colors.white, fontSize: 38, fontWeight: FontWeight.bold)),
              const Text("मानवत, महाराष्ट्र", style: TextStyle(color: Colors.white, fontSize: 14)),
            ],
          ),
          const Icon(Icons.wb_sunny_rounded, size: 70, color: Colors.orangeAccent),
        ],
      ),
    );
  }

  Widget _circleMenu(BuildContext context, String label, IconData icon, Color color, Widget page) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: color.withOpacity(0.1), blurRadius: 10, spreadRadius: 2),
              ],
              border: Border.all(color: color.withOpacity(0.2), width: 1),
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
// REGISTRATION PAGE (तुमच्या कोडप्रमाणेच)
class RegistrationPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Navin Krushi Mitra"), backgroundColor: Colors.green),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Center(child: Text("Nondani Kara", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green))),
            const SizedBox(height: 30),
            TextField(controller: nameController, decoration: const InputDecoration(labelText: "Full Name", border: OutlineInputBorder())),
            const SizedBox(height: 15),
            TextField(controller: mobileController, decoration: const InputDecoration(labelText: "Mobile", border: OutlineInputBorder())),
            const SizedBox(height: 15),
            TextField(controller: addressController, decoration: const InputDecoration(labelText: "Gav/City", border: OutlineInputBorder())),
            const SizedBox(height: 15),
            TextField(controller: usernameController, decoration: const InputDecoration(labelText: "Username", border: OutlineInputBorder())),
            const SizedBox(height: 15),
            TextField(controller: passwordController, obscureText: true, decoration: const InputDecoration(labelText: "Password", border: OutlineInputBorder())),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () async {
                  // १. युजरनेम आणि पासवर्ड रिकामा नाही ना हे तपासा
                  if (usernameController.text.isNotEmpty && passwordController.text.isNotEmpty) {
                    
                    // २. डेटाबेसमध्ये युजर रजिस्टर करा
                    await DBHelper.registerUser(usernameController.text, passwordController.text);

                    // ३. ✅ यशस्वी झाल्याचा मेसेज (SnackBar) दाखवा
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("नोंदणी यशस्वी झाली! आता लॉगिन करा."),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2), // मेसेज २ सेकंद दिसेल
                      ),
                    );

                    // ४. मेसेज दिसल्यावर २ सेकंद थांबून लॉगिन पेजवर परत जा
                    Future.delayed(const Duration(seconds: 2), () {
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    });

                  } else {
                    // ❌ जर माहिती अपूर्ण असेल तर लाल मेसेज दाखवा
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("कृपया सर्व माहिती भरा!"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text("REGISTER", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}