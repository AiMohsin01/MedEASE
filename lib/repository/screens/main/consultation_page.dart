import 'package:flutter/material.dart';

// A single message in the chat
class _ChatMessage {
  final String text;
  final bool isAi;
  _ChatMessage(this.text, {this.isAi = false});
}

class ConsultationPage extends StatefulWidget {
  const ConsultationPage({super.key});

  @override
  State<ConsultationPage> createState() => _ConsultationPageState();
}

class _ConsultationPageState extends State<ConsultationPage> {
  final TextEditingController _controller = TextEditingController();
  final List<_ChatMessage> _messages = [];
  bool _isLoading = false;

  // Using a Map for a more scalable and conversational approach to responses.
  final Map<List<String>, String> _qaMap = {
    ['hello', 'hi']: 'Hello there! What symptoms are you experiencing?',
    ['thank you', 'thanks']: 'You\'re welcome! Is there anything else I can help you with today?',
    ['how are you']: 'I am just a program, but I am ready to assist you with your health questions!',
    ['headache', 'migraine']: 'For a headache, it is often helpful to rest in a quiet, dark room and drink plenty of water. Are you experiencing any other symptoms, such as fever or dizziness?',
    ['fever']: 'A fever can be managed with over-the-counter medication like paracetamol or ibuprofen, and by staying hydrated. If your temperature is very high or persists for more than three days, you should consult a doctor.',
    ['cough']: 'For a cough, staying hydrated with warm liquids like tea with honey can be soothing. If the cough is persistent, severe, or accompanied by difficulty breathing, it is important to see a doctor.',
    ['sore throat']: 'Gargling with warm salt water can help relieve a sore throat. Lozenges or throat sprays can also provide temporary relief. If it\'s severe or lasts more than a few days, please consult a healthcare professional.',
    ['cold', 'i feel cold']: 'Common cold symptoms can often be managed with rest, plenty of fluids, and over-the-counter decongestants. There is no cure for the common cold, so the focus is on symptom relief.',
    ['flu', 'i feel flu']: 'Flu symptoms are often more severe than a cold and can include high fever, body aches, and fatigue. It is highly recommended to rest and drink fluids. Antiviral medication may be prescribed by a doctor if caught early.',
    ['stomach ache', 'stomach pain']: 'For a mild stomach ache, you can try a BRAT diet (bananas, rice, applesauce, toast). Avoid spicy or fatty foods. If the pain is severe, sharp, or persistent, you should seek medical attention immediately.',
    ['diarrhea']: 'With diarrhea, the most important thing is to stay hydrated by drinking water, broth, or rehydration solutions. If it lasts for more than two days or is accompanied by high fever or severe pain, please see a doctor.',
    ['constipation']: 'To help with constipation, try inacreasing your intake of fiber through fruits, vegetables, and whole grains, and drink plenty of water. Gentle exercise can also help stimulate bowel movements.',
    ['dizzy', 'dizziness']: 'If you feel dizzy, sit or lie down immediately to avoid falling. Drink some water and rest. Dizziness can have many causes, so if it is recurrent or severe, it is important to consult a doctor.',
    ['rash']: 'For a mild skin rash, you can try applying a cold compress or a soothing lotion like calamine. Avoid scratching it. If the rash is widespread, painful, or accompanied by a fever, seek medical advice.',
    ['allergy', 'allergies']: 'Allergies can be managed with over-the-counter antihistamines. Identifying and avoiding your allergy triggers is also key. For severe allergic reactions, like difficulty breathing, seek emergency medical help.',
    ['cut']: 'For a minor cut, clean the wound with mild soap and water, apply an antibiotic ointment, and cover it with a clean bandage. For deep cuts or if bleeding doesn\'t stop with pressure, seek medical attention.',
    ['burn']: 'For a minor burn, immediately run cool (not cold) water over the area for several minutes. You can cover it with a sterile, non-adhesive bandage. Do not use ice or butter. For severe burns, call for emergency help.',
    ['sprain']: 'For a sprain, the R.I.C.E. method is recommended: Rest, Ice (for 20 minutes at a time), Compression (with a bandage), and Elevation (raise the limb). If you cannot bear weight on it or the pain is severe, see a doctor.',
    ['insomnia', 'can\'t sleep']: 'To improve sleep, try establishing a regular sleep schedule, creating a relaxing bedtime routine, and avoiding caffeine or heavy meals before bed. If insomnia persists, a doctor can help identify underlying causes.',
    ['anxiety', 'anxious']: 'Feeling anxious is common. Deep breathing exercises, mindfulness, and regular physical activity can help manage symptoms. For persistent anxiety, speaking with a mental health professional is highly recommended.',
    ['stress']: 'Managing stress is important for overall health. Techniques like exercise, meditation, spending time in nature, or talking to someone you trust can be very effective. A therapist can provide additional coping strategies.',
    ['back pain']: 'For minor back pain, gentle stretching and over-the-counter pain relievers can help. Applying heat or ice can also provide relief. If the pain is severe, chronic, or shoots down your leg, it\'s best to see a doctor.',
    ['nausea']: 'For nausea, try sipping clear fluids and eating small, bland meals. Ginger tea or ginger ale can also be helpful. Avoid strong smells and fatty foods. If it\'s severe or persistent, consult a doctor.',
    ['sunburn']: 'To treat sunburn, cool the skin with a damp cloth or a cool bath. Apply aloe vera gel or a moisturizer. Drink extra water to prevent dehydration. Avoid further sun exposure until your skin has healed.',
    ['nosebleed']: 'For a nosebleed, sit upright and lean forward slightly. Pinch your nostrils closed for 10-15 minutes and breathe through your mouth. If bleeding is heavy or doesn\'t stop after 20 minutes, seek medical care.',
    ['tired', 'fatigue']: 'Feeling tired can be a sign of many things. Ensure you are getting 7-9 hours of quality sleep per night. Also, check your diet and hydration. If chronic fatigue is affecting your daily life, it\'s a good idea to talk to a doctor.',
    ['blister']: 'It\'s best not to pop a blister. Keep it clean and cover it with a loose bandage. If it breaks, gently wash the area with soap and water and apply an antibiotic ointment before covering it.',
    ['bruise']: 'For a fresh bruise, you can apply a cold pack for 15-20 minutes to reduce swelling. After a day or two, applying a warm compress can help with healing. Most bruises fade on their own.',
    ['muscle cramp']: 'When you get a muscle cramp, gently stretch and massage the affected muscle. Applying heat can also help it relax. Staying well-hydrated, especially during exercise, can help prevent cramps.',
    ['heartburn']: 'To manage heartburn, you can try over-the-counter antacids. It also helps to avoid trigger foods like spicy or fatty meals, and to not lie down right after eating. If it happens frequently, consult a doctor.',
    ['pink eye', 'conjunctivitis']: 'Pink eye can be contagious. It\'s important to wash your hands frequently and avoid touching your eyes. A doctor can determine the cause (viral, bacterial, or allergic) and prescribe the right treatment, such as eye drops.',
    ['acne', 'pimple']: 'For acne, it\'s important to gently wash your face twice a day and use non-comedogenic products. Over-the-counter treatments with benzoyl peroxide or salicylic acid can be effective. For persistent acne, a dermatologist can offer more advanced treatments.',
    ['earache']: 'An earache can be caused by many things. Applying a warm compress to the outside of the ear can sometimes help with pain. However, it\'s important to see a doctor to diagnose the cause, especially if there is a fever or fluid drainage.',
    ['toothache']: 'For a toothache, rinse your mouth with warm salt water and gently floss to remove any trapped food. You can take an over-the-counter pain reliever. It is essential to see a dentist as soon as possible to find the cause.',
    ['depression']: 'Feeling down is different from clinical depression, which requires a diagnosis. If you have persistent feelings of sadness, hopelessness, or loss of interest, it is very important to talk to a mental health professional.',
    ['diabetes']: 'Diabetes is a serious condition where your blood glucose is too high. Common symptoms include frequent urination, increased thirst, and unexplained weight loss. If you suspect you have diabetes, you must see a doctor for testing and management.',
    ['high blood pressure', 'hypertension']: 'High blood pressure often has no symptoms but can lead to serious health problems. The best way to know if you have it is to get it checked regularly. Lifestyle changes like a healthy diet, exercise, and reducing salt intake are crucial.',
    ['cholesterol']: 'High cholesterol can increase your risk of heart disease. It can be managed with a diet low in saturated and trans fats, regular exercise, and sometimes medication prescribed by a doctor. A blood test is needed to check your levels.',
    ['asthma']: 'Asthma is a chronic disease that affects your airways. It\'s managed with inhalers (relievers and controllers). It is critical to work with a doctor to create an asthma action plan and to identify your triggers.',
    ['bronchitis']: 'Acute bronchitis often develops from a cold or flu and usually resolves on its own. Rest, fluids, and a humidifier can help. If you\'re coughing up mucus or have a fever, see a doctor as it could be bacterial.',
    ['pneumonia']: 'Pneumonia is a serious lung infection. Symptoms include cough, fever, chills, and difficulty breathing. It requires a doctor\'s diagnosis and is typically treated with antibiotics.',
    ['uti', 'urinary tract infection']: 'A urinary tract infection (UTI) can cause a burning feeling when you urinate and a frequent urge to go. It\'s important to see a doctor for diagnosis and antibiotic treatment. Drinking plenty of water can help.',
    ['kidney stone']: 'Kidney stones can cause severe pain in your back and side. It is very important to drink a lot of water to help pass the stone. A doctor can provide pain management and determine if other treatment is needed.',
    ['eczema']: 'Eczema involves dry, itchy skin. Keeping the skin moisturized is key. A doctor or dermatologist can recommend specific creams or ointments, including steroid creams for flare-ups.',
    ['psoriasis']: 'Psoriasis is an autoimmune condition that causes skin cells to build up rapidly. A dermatologist can diagnose it and recommend treatments, which may include topical creams, light therapy, or medications.',
    ['arthritis']: 'Arthritis involves joint inflammation and pain. There are many types. Management often includes exercise, physical therapy, and medication. A doctor can help diagnose the specific type and create a treatment plan.',
    ['gout']: 'Gout is a type of arthritis that causes sudden, severe attacks of pain, often in the big toe. It is caused by too much uric acid. A doctor can prescribe medication to treat an attack and prevent future ones.',
    ['osteoporosis']: 'Osteoporosis weakens bones, making them more likely to break. It is diagnosed with a bone density scan. Getting enough calcium and vitamin D, plus weight-bearing exercise, is important for bone health.',
    ['anemia']: 'Anemia is a condition where you lack enough healthy red blood cells. The most common cause is iron deficiency. Symptoms include fatigue and shortness of breath. A doctor can diagnose it with a blood test and recommend treatment, like iron supplements.',
    ['thyroid']: 'Thyroid problems can cause a wide range of symptoms, from fatigue and weight gain (hypothyroidism) to weight loss and anxiety (hyperthyroidism). A doctor can check your thyroid function with a simple blood test.',
    ['menstrual pain', 'period cramp']: 'For menstrual cramps, over-the-counter pain relievers like ibuprofen can be effective. Using a heating pad on your lower abdomen can also provide relief. If pain is severe, a gynecologist can help.',
    ['pregnancy']: 'If you think you might be pregnant, a home pregnancy test is a good first step. It is very important to see a doctor or an OB/GYN as soon as possible to confirm the pregnancy and begin prenatal care.',
    ['menopause']: 'Menopause is a natural biological process. Symptoms can include hot flashes and mood changes. A doctor can discuss various management options, from lifestyle adjustments to hormone therapy.',
    ['how to lose weight']: 'Healthy weight loss involves a combination of a balanced, calorie-controlled diet and regular physical activity. It\'s best to aim for gradual, sustainable changes rather than crash diets. A registered dietitian can provide personalized advice.',
    ['how to eat healthy']: 'A healthy diet is rich in fruits, vegetables, whole grains, and lean proteins. It\'s also important to limit processed foods, sugary drinks, and unhealthy fats. Drinking plenty of water is also key.',
    ['how to exercise']: 'A good exercise routine includes both cardiovascular activity (like walking, running, or swimming) and strength training. Aim for at least 150 minutes of moderate-intensity cardio per week. It\'s always a good idea to check with a doctor before starting a new exercise program.',
    ['insect bite', 'bug bite']: 'For a common insect bite that is itchy, try not to scratch. Applying a cold pack or hydrocortisone cream can help. If you see signs of an allergic reaction, like swelling beyond the bite area or difficulty breathing, seek medical help.',
    ['hiccup']: 'Hiccups are usually temporary. You can try holding your breath for a short period, drinking a glass of water quickly, or gargling with water. They typically go away on their own.',
    ['dehydration']: 'Signs of dehydration include thirst, dark yellow urine, and fatigue. The best treatment is to drink water or a rehydration solution. Severe dehydration may require medical attention.',
    ['food poisoning']: 'Symptoms of food poisoning often include nausea, vomiting, and diarrhea. The most important thing is to rest and drink plenty of fluids to prevent dehydration. It usually resolves on its own, but see a doctor if symptoms are severe or don\'t improve.',
    ['sinus infection', 'sinusitis']: 'For sinus congestion, you can try a saline nasal spray, a humidifier, or inhaling steam from a bowl of hot water. If you have significant pain, pressure, or a fever, a doctor may prescribe antibiotics.',
    ['what is first aid']: 'First aid is the immediate assistance given to any person suffering from either a minor or serious illness or injury, with care provided to preserve life, prevent the condition from worsening, or to promote recovery.',
    ['how to check pulse']: 'To check your pulse on your wrist, place two fingers between the bone and the tendon over your radial artery — which is located on the thumb side of your wrist. When you feel your pulse, count the number of beats in 15 seconds. Multiply this number by four to calculate your beats per minute.',
    ['heart attack symptoms']: 'Common heart attack symptoms include chest pain (pressure, squeezing), pain in the left arm, jaw, or back, shortness of breath, and cold sweats. If you suspect a heart attack, call emergency services immediately.',
    ['stroke symptoms']: 'Key stroke symptoms can be remembered with the acronym F.A.S.T.: Face drooping, Arm weakness, Speech difficulty, Time to call emergency services. Quick medical attention is critical.',
    ['good morning', 'morning']: 'Good morning! ☀️ I hope you’re feeling okay today. How can I help?',
    ['good night', 'night']: 'Good night 🌙 Take care and get some good rest. I’m here if you need help tomorrow.',
    ['what can you do', 'help']: 'I can help answer basic health questions, give self-care tips, and guide you on when to see a doctor.',

    ['chest pain']: 'Chest pain should never be ignored ⚠️. If it feels heavy, tight, or spreads to your arm or jaw, seek emergency help immediately.',
    ['shortness of breath', 'breathing problem']: 'Trouble breathing can be serious 😮‍💨. Sit upright and try to stay calm. If it gets worse or sudden, seek emergency care.',
    ['vomiting']: 'Vomiting can leave you dehydrated 🤢. Take small sips of water and rest. If it doesn’t stop or includes blood, see a doctor.',
    ['gas', 'bloating']: 'Gas and bloating can be uncomfortable 😖. Eating slowly, avoiding fizzy drinks, and gentle walking may help.',
    ['indigestion']: 'Indigestion often causes burning or discomfort after eating 🔥. Try eating smaller meals and avoid spicy or oily foods.',
    ['loss of appetite']: 'Not feeling hungry can happen due to stress or illness 🍽️. Eat light meals and stay hydrated. If it lasts long, consult a doctor.',
    ['weight gain']: 'Unexpected weight gain can be due to lifestyle or medical reasons ⚖️. Balanced eating and activity help, but a doctor can rule out causes.',
    ['weight loss']: 'Sudden or unplanned weight loss may need medical attention ⚠️. A doctor can help find the cause.',
    ['body pain', 'body ache']: 'Body aches can come from fatigue, flu, or stress 😣. Rest, hydration, and light stretching may help.',
    ['neck pain']: 'Neck pain is often caused by poor posture 💻. Gentle stretches and warm compresses can help relieve stiffness.',
    ['leg pain']: 'Leg pain can have many causes 🦵. Rest and gentle massage may help, but severe or sudden pain should be checked.',
    ['swelling']: 'Swelling can be due to injury or fluid retention 🤕. Elevate the area and monitor it. Sudden swelling needs medical advice.',
    ['itching']: 'Itching can be caused by allergies or dry skin 😖. Moisturizers or antihistamines may help. Persistent itching should be checked.',
    ['hair loss']: 'Hair loss can be linked to stress, nutrition, or hormones 💇‍♀️. A doctor can help identify the cause.',
    ['dry skin']: 'Dry skin can feel tight and itchy 🧴. Use a good moisturizer and avoid hot showers.',
    ['eye pain']: 'Eye pain or discomfort 👁️ should not be ignored. Avoid rubbing and see a doctor if pain or vision changes occur.',
    ['blurred vision']: 'Blurred vision can happen due to eye strain or health issues 👓. If it happens suddenly, seek medical care.',
    ['frequent urination']: 'Needing to urinate often 🚽 may be linked to infection or blood sugar issues. A doctor can check the cause.',
    ['burning urination']: 'Burning while urinating can be a sign of infection ⚠️. Drinking water helps, but medical treatment is usually needed.',
    ['memory problem', 'forgetfulness']: 'Occasional forgetfulness happens 🧠, especially with stress or lack of sleep. Persistent memory issues should be checked.',
    ['panic attack']: 'Panic attacks can feel very frightening 😰. Slow breathing and grounding techniques can help. A professional can provide support.',
    ['mood swings']: 'Mood swings can be caused by stress or hormones 💭. Tracking triggers and talking to a professional may help.',
    ['low energy']: 'Low energy can result from poor sleep, diet, or stress 🔋. Rest and proper nutrition are important.',
    ['feeling weak']: 'Feeling weak may be due to dehydration or illness 😔. Rest and fluids help, but ongoing weakness needs evaluation.',
    ['chills']: 'Chills often occur with fever or infection 🥶. Keep warm and monitor your temperature.',
    ['night sweats']: 'Night sweats can be uncomfortable 🌙. If frequent or severe, it’s best to see a doctor.',
    ['food allergy']: 'Food allergies can cause itching, swelling, or stomach issues 🍤. Avoid triggers and seek emergency help for breathing problems.',
    ['motion sickness']: 'Motion sickness can cause nausea 🤢. Sitting still and looking forward may help.',
    ['snoring']: 'Snoring can affect sleep quality 😴. Sleeping on your side and maintaining a healthy weight may reduce it.',
    ['frequent headache']: 'Frequent headaches may be linked to stress, dehydration, or vision issues 🤕. A doctor can help identify the cause.',
    ['check blood pressure']: 'Blood pressure can be checked using a home monitor or at a clinic 🩺. Regular checks are important for heart health.',
    ['healthy lifestyle']: 'A healthy lifestyle includes balanced eating, regular activity, good sleep, and stress management 🌱.',

  };

  @override
  void initState() {
    super.initState();
    // Start with a default greeting from the AI
    _messages.add(_ChatMessage(
      'Hello! I\'m your AI Health Assistant. How can I help you today?',
      isAi: true,
    ));
  }

  // Get a hardcoded response based on user input
  String _getHardcodedResponse(String userInput) {
    final lowercasedInput = userInput.toLowerCase();

    for (var entry in _qaMap.entries) {
      for (var keyword in entry.key) {
        if (lowercasedInput.contains(keyword)) {
          return entry.value;
        }
      }
    }

    // Default response if no keyword is matched
    return 'I can provide general information, but I am not a real doctor. For a proper diagnosis, please consult a healthcare professional.';
  }

  // Simulate sending a message and getting a response
  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(_ChatMessage(text));
      _isLoading = true; // Show loading indicator
    });

    _controller.clear();

    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 1));

    final String response = _getHardcodedResponse(text);

    setState(() {
      _messages.add(_ChatMessage(response, isAi: true));
      _isLoading = false; // Hide loading indicator
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F5),
      body: Column(
        children: [
          const Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("AI Consultation", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message.text, message.isAi);
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          _buildMessageComposer(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String text, bool isAi) {
    return Align(
      alignment: isAi ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isAi ? const Color(0xFF28A79F) : Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2))],
        ),
        child: Text(text, style: TextStyle(color: isAi ? Colors.white : Colors.black87, fontSize: 16)),
      ),
    );
  }

  Widget _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      color: Colors.white,
      child: SafeArea(
        child: Row(
          children: [
            IconButton(icon: const Icon(Icons.attach_file), onPressed: () {}),
            Expanded(
              child: TextField(
                controller: _controller,
                onSubmitted: _sendMessage,
                decoration: const InputDecoration.collapsed(hintText: 'Type your message...'),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: Color(0xFF28A79F)),
              onPressed: () => _sendMessage(_controller.text),
            ),
          ],
        ),
      ),
    );
  }
}
