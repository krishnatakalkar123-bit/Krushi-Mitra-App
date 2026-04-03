import 'package:flutter/material.dart';

class CropInfoPage extends StatelessWidget {
  final String cropName;

  const CropInfoPage({Key? key, required this.cropName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cropName),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            // ✅ Image (error safe)
            Image.asset(
              getCropImage(cropName),
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset("assets/images/default.jpg");
              },
            ),

            SizedBox(height: 10),

            // ✅ Info
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                getCropInfo(cropName),
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================
  // 🌾 Crop Info (Marathi)
  // ===========================
  String getCropInfo(String crop) {
  switch (crop) {

    case "Wheat":
      return "🌾 गहू (Wheat)\n\n"
          "📌 प्रकार: रब्बी पीक\n"
          "📅 पेरणी: ऑक्टोबर–नोव्हेंबर\n"
          "📅 कापणी: मार्च–एप्रिल\n\n"
          "🌍 हवामान: थंड (10–25°C)\n"
          "🌧 पाऊस: 50–100 सेमी\n"
          "🌱 माती: मध्यम ते काळी, pH 6–7.5\n\n"
          "💧 पाणी: 4–5 वेळा सिंचन आवश्यक\n"
          "🌿 खत: NPK (120:60:40) + सेंद्रिय खत\n\n"
          "🌾 बियाणे दर: 100–125 kg/हेक्टर\n"
          "🚜 लागवड पद्धत: ड्रिल/प्रसारण\n\n"
          "🐛 कीड/रोग:\n"
          "- रतुआ\n"
          "- करपा\n\n"
          "🛡 नियंत्रण:\n"
          "- योग्य फवारणी\n"
          "- रोगप्रतिरोधक जाती\n\n"
          "📊 उत्पादन: 30–50 क्विंटल/हेक्टर\n\n"
          "🍞 उपयोग:\n"
          "- पीठ\n"
          "- ब्रेड\n"
          "- बिस्कीट";

    case "Rice":
      return "🌾 तांदूळ (Rice)\n\n"
          "📌 प्रकार: खरीप पीक\n"
          "📅 पेरणी: जून–जुलै\n"
          "📅 कापणी: ऑक्टोबर–नोव्हेंबर\n\n"
          "🌍 हवामान: उष्ण व दमट (20–35°C)\n"
          "🌧 पाऊस: 100–200 सेमी\n"
          "🌱 माती: चिकणमाती, पाणी धरून ठेवणारी\n\n"
          "💧 पाणी: 1200–1500 mm\n"
          "🚜 पद्धत: रोपवाटिका (Transplanting)\n\n"
          "🌿 खत: NPK + सेंद्रिय खत\n\n"
          "🐛 रोग:\n"
          "- ब्लास्ट\n"
          "- बॅक्टेरियल ब्लाइट\n\n"
          "📊 उत्पादन: 40–60 क्विंटल/हेक्टर\n\n"
          "🍚 उपयोग:\n"
          "- मुख्य अन्न\n"
          "- पोहे\n"
          "- तांदूळ";

    case "Cotton":
      return "🌾 कापूस (Cotton)\n\n"
          "📌 प्रकार: नगदी पीक\n"
          "📅 पेरणी: जून–जुलै\n\n"
          "🌍 हवामान: उष्ण (25–35°C)\n"
          "🌱 माती: काळी जमीन\n\n"
          "💧 पाणी: मध्यम\n"
          "🌿 खत: NPK + सूक्ष्म अन्नद्रव्ये\n\n"
          "🐛 मुख्य कीड:\n"
          "- बोंडअळी (Bollworm)\n\n"
          "🛡 नियंत्रण:\n"
          "- Bt बियाणे\n"
          "- कीटकनाशक फवारणी\n\n"
          "📊 उत्पादन: 15–25 क्विंटल/हेक्टर\n\n"
          "👕 उपयोग:\n"
          "- सूत\n"
          "- कपडे\n"
          "- वस्त्र उद्योग";

    case "Sugarcane":
      return "🌾 ऊस (Sugarcane)\n\n"
          "📌 प्रकार: नगदी पीक\n"
          "⏳ कालावधी: 10–18 महिने\n\n"
          "🌍 हवामान: उष्ण व दमट\n"
          "🌱 माती: खोल, सुपीक\n\n"
          "💧 पाणी: 1500–2500 mm\n"
          "🚜 लागवड: सेट्स (ऊसाचे तुकडे)\n\n"
          "🌿 खत: जास्त NPK\n\n"
          "🐛 रोग:\n"
          "- रेड रॉट\n\n"
          "📊 उत्पादन: 80–120 टन/हेक्टर\n\n"
          "🍬 उपयोग:\n"
          "- साखर\n"
          "- गूळ\n"
          "- इथेनॉल";

    case "Soybean":
     return "🌾 सोयाबीन (Soybean)\n\n"
      "प्रकार: खरीप पीक\n"
      "पेरणी: जून–जुलै\n"
      "कापणी: सप्टेंबर–ऑक्टोबर\n\n"
      "🌍 हवामान: उष्ण व आर्द्र\n"
      "🌱 माती: मध्यम ते काळी, निचरा चांगला\n"
      "💧 पाणी: मध्यम\n\n"
      "🌿 विशेष: नायट्रोजन फिक्सेशन\n"
      "📊 उत्पादन: 20–25 क्विंटल/हेक्टर\n"
      "🛢 उपयोग: तेल, प्रथिने, पशुखाद्य";

case "Maize":
  return "🌾 मका (Maize)\n\n"
      "प्रकार: खरीप/रब्बी\n"
      "पेरणी: जून–जुलै / ऑक्टोबर\n\n"
      "🌍 हवामान: उष्ण व मध्यम पाऊस\n"
      "🌱 माती: निचरा चांगला, हलकी ते मध्यम\n"
      "💧 पाणी: मध्यम\n\n"
      "📊 उत्पादन: 40–60 क्विंटल/हेक्टर\n"
      "🌽 उपयोग: अन्न, पशुखाद्य, स्टार्च, पॉपकॉर्न";

case "Bajra":
  return "🌾 बाजरी (Bajra)\n\n"
      "प्रकार: खरीप\n"
      "पेरणी: जून–जुलै\n\n"
      "🌍 हवामान: उष्ण व कोरडे\n"
      "🌱 माती: हलकी व वालुकामय\n"
      "💧 पाणी: कमी\n\n"
      "🔥 विशेष: दुष्काळ सहनशक्ती जास्त\n"
      "📊 उत्पादन: 10–20 क्विंटल/हेक्टर\n"
      "🥖 उपयोग: भाकरी";

case "Jowar":
  return "🌾 ज्वारी (Jowar)\n\n"
      "प्रकार: खरीप/रब्बी\n"
      "पेरणी: जून–जुलै / सप्टेंबर\n\n"
      "🌍 हवामान: उष्ण\n"
      "💧 पाणी: कमी\n\n"
      "📊 उत्पादन: 20–30 क्विंटल/हेक्टर\n"
      "🌾 उपयोग: अन्न + पशुखाद्य";

case "Tur":
  return "🌱 तूर (Tur)\n\n"
      "कालावधी: 4–6 महिने\n"
      "पेरणी: जून\n\n"
      "🌱 माती: मध्यम\n"
      "💧 पाणी: कमी\n\n"
      "🌿 विशेष: जमिनीत नायट्रोजन वाढवते\n"
      "📊 उत्पादन: 10–15 क्विंटल/हेक्टर\n"
      "🍲 उपयोग: डाळ";

case "Gram":
  return "🌱 हरभरा (Gram)\n\n"
      "प्रकार: रब्बी\n"
      "पेरणी: ऑक्टोबर–नोव्हेंबर\n\n"
      "🌱 माती: काळी\n"
      "💧 पाणी: कमी\n\n"
      "📊 उत्पादन: 15–20 क्विंटल/हेक्टर\n"
      "🥜 उपयोग: चणे, बेसन";

case "Moong":
  return "🌱 मूग (Moong)\n\n"
      "कालावधी: 60–70 दिवस\n"
      "पेरणी: जून / मार्च\n\n"
      "🌱 माती: हलकी\n"
      "💧 पाणी: कमी\n\n"
      "📊 उत्पादन: 8–12 क्विंटल/हेक्टर\n"
      "🥗 उपयोग: डाळ";

case "Urad":
  return "🌱 उडीद (Urad)\n\n"
      "पेरणी: जून–जुलै\n"
      "🌱 माती: मध्यम\n\n"
      "📊 उत्पादन: 8–10 क्विंटल/हेक्टर\n"
      "🍲 उपयोग: डाळ, पापड";

case "Groundnut":
  return "🌻 शेंगदाणा (Groundnut)\n\n"
      "प्रकार: खरीप\n"
      "पेरणी: जून\n\n"
      "🌱 माती: वालुकामय\n"
      "💧 पाणी: मध्यम\n\n"
      "📊 उत्पादन: 15–25 क्विंटल/हेक्टर\n"
      "🛢 उपयोग: तेल, खाणे";

case "Sunflower":
  return "🌻 सूर्यफूल (Sunflower)\n\n"
      "कालावधी: 90–100 दिवस\n"
      "🌱 माती: हलकी\n\n"
      "📊 उत्पादन: 10–15 क्विंटल/हेक्टर\n"
      "🛢 उपयोग: तेल";

case "Mustard":
  return "🌻 मोहरी (Mustard)\n\n"
      "प्रकार: रब्बी\n"
      "पेरणी: ऑक्टोबर\n\n"
      "📊 उत्पादन: 10–15 क्विंटल/हेक्टर\n"
      "🛢 उपयोग: तेल";

case "Onion":
  return "🧅 कांदा\n\n"
      "कालावधी: 3–5 महिने\n"
      "🌱 माती: हलकी ते मध्यम\n\n"
      "📦 साठवणूक शक्य\n"
      "🍽 उपयोग: स्वयंपाक";

case "Potato":
  return "🥔 बटाटा\n\n"
      "🌍 हवामान: थंड\n"
      "पेरणी: ऑक्टोबर\n\n"
      "📊 उत्पादन: 200–300 क्विंटल/हेक्टर\n"
      "🍟 उपयोग: सर्व भाजीपदार्थ";

case "Tomato":
  return "🍅 टोमॅटो\n\n"
      "📊 वर्षभर लागवड\n"
      "🌱 माती: मध्यम\n\n"
      "📦 उत्पादन जास्त\n"
      "🍝 उपयोग: भाजी, सॉस";

case "Chili":
  return "🌶 मिरची\n\n"
      "🌍 उष्ण हवामान\n"
      "💧 पाणी: मध्यम\n\n"
      "🔥 उपयोग: तिखट, मसाला";

case "Brinjal":
  return "🍆 वांगी\n\n"
      "📊 वर्षभर लागवड\n"
      "🌱 माती: मध्यम\n\n"
      "🍽 उपयोग: भाजी";

case "Cabbage":
  return "🥬 कोबी\n\n"
      "❄ थंड हवामान\n"
      "🌱 माती: सुपीक\n\n"
      "🥗 उपयोग: पानभाजी";

case "Cauliflower":
  return "🥦 फुलकोबी\n\n"
      "❄ थंड हवामान\n"
      "🌱 माती: सुपीक\n\n"
      "🥗 पोषक भाजी";

case "Spinach":
  return "🥬 पालक\n\n"
      "⏱ जलद वाढ\n"
      "💪 लोखंडयुक्त\n\n"
      "🥗 पालेभाजी";

case "Fenugreek":
  return "🌿 मेथी\n\n"
      "❄ हिवाळी\n"
      "💊 औषधी गुणधर्म\n\n"
      "🥗 पालेभाजी";

case "Coriander":
  return "🌿 कोथिंबीर\n\n"
      "⏱ जलद वाढ\n"
      "🌸 सुगंधी\n\n"
      "🍽 सजावट";

case "Garlic":
  return "🧄 लसूण\n\n"
      "❄ थंड हवामान\n"
      "💊 औषधी\n\n"
      "🛡 रोगप्रतिकार वाढवतो";

case "Ginger":
  return "🌿 आले\n\n"
      "🌧 ओलसर हवामान\n"
      "💊 औषधी\n\n"
      "🍵 मसाला";

case "Papaya":
  return "🍈 पपई\n\n"
      "⏱ 6–8 महिने\n"
      "🌍 उष्ण हवामान\n\n"
      "💪 पचनासाठी चांगली";

case "Banana":
  return "🍌 केळी\n\n"
      "🌍 उष्ण हवामान\n"
      "💧 जास्त पाणी\n\n"
      "⚡ ऊर्जा देणारे";

case "Mango":
  return "🥭 आंबा\n\n"
      "👑 फळांचा राजा\n"
      "🌞 उन्हाळ्यात येतो\n\n"
      "📦 निर्यात मोठ्या प्रमाणात";

case "Grapes":
  return "🍇 द्राक्षे\n\n"
      "🌍 कोरडे हवामान\n"
      "💧 नियंत्रित पाणी\n\n"
      "🍷 रस, मनुका";

default:
  return "या पिकाची माहिती उपलब्ध नाही.";
    }
  }

  // ===========================
  // 🖼 Image Path
  // ===========================
  String getCropImage(String crop) {
    switch (crop) {
      case "Wheat":
        return "assets/images/wheat.jpg";
      case "Rice":
        return "assets/images/rice.jpg";
      case "Cotton":
        return "assets/images/cotton.jpg";
      case "Sugarcane":
        return "assets/images/sugarcane.jpg";
      case "Soybean":
        return "assets/images/soybean.jpg";
      case "Maize":
        return "assets/images/maize.jpg";
      case "Bajra":
        return "assets/images/bajra.jpg";
      case "Jowar":
        return "assets/images/jowar.jpg";
      case "Onion":
        return "assets/images/onion.jpg";
      case "Potato":
        return "assets/images/potato.jpg";
      case "Tomato":
        return "assets/images/tomato.jpg";
      case "Chili":
        return "assets/images/chili.jpg";  
      case "Brinjal":
        return "assets/images/brinjal.jpg"; 
      case "Cabbage":
        return "assets/images/cabbage.jpg"; 
      case "Cauliflower": 
        return "assets/images/cauliflower.jpg";
      case "Spinach": 
        return "assets/images/spinach.jpg";
      case "Fenugreek":
        return "assets/images/fenugreek.jpg";
      case "Coriander":
        return "assets/images/coriander.jpg";
      case "Garlic":
        return "assets/images/garlic.jpg";
      case "Ginger":
        return "assets/images/ginger.jpg";
      case "Papaya":
        return "assets/images/papaya.jpg";
      case "Banana":
        return "assets/images/banana.jpg";
      case "Mango": 
        return "assets/images/mango.jpg";
      case "Grapes":
       return "assets/images/grapes.jpg";
      default:
        return "assets/images/default.jpg";
    }
  }
}