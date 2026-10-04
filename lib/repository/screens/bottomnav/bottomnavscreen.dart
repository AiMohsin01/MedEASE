import 'package:flutter/material.dart';
import 'package:medease/repository/screens/main/blood_donation_page.dart';
import 'package:medease/repository/screens/main/doctor_recommendation_page.dart';
import 'package:medease/repository/screens/main/upload_documents_page.dart';
import 'package:medease/repository/screens/main/consultation_page.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const BloodDonationPage(),
    const DoctorRecommendationPage(),
    const UploadDocumentsPage(),
    const ConsultationPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MEDEASE', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF28A79F),
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(backgroundColor: Colors.white),
          ),
        ],
      ),
      body: IndexedStack( // Use IndexedStack to preserve the state of each page
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return SafeArea(
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF28A79F),
        unselectedItemColor: Colors.grey.shade600,
        currentIndex: _currentIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF28A79F)),
        unselectedLabelStyle: const TextStyle(fontSize: 12, color: Colors.grey),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.water_drop_outlined),
            label: 'Blood Donation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_outlined),
            label: 'Doctor Reco...',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.document_scanner_outlined),
            label: 'Documents',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Consultation',
          ),
        ],
      ),
    );
  }
}
