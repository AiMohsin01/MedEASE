import 'package:flutter/material.dart';
import 'package:medease/repository/screens/main/blood_donation_page.dart';
import 'package:medease/repository/screens/main/doctor_recommendation_page.dart';
import 'package:medease/repository/screens/main/upload_documents_page.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNav({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    const activeColor = Color(0xFF28A79F);
    final inactiveColor = Colors.grey.shade600;

    return SafeArea(
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: activeColor,
        unselectedItemColor: inactiveColor,
        currentIndex: currentIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: activeColor),
        unselectedLabelStyle: const TextStyle(fontSize: 12, color: Colors.grey),
        selectedIconTheme: const IconThemeData(size: 26, color: activeColor),
        unselectedIconTheme: const IconThemeData(size: 24, color: Colors.grey),
        iconSize: 24,
        elevation: 8,
        onTap: (index) {
          if (index == currentIndex) return;
          // Navigate by replacing the current route so tabs don't stack
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const BloodDonationPage()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DoctorRecommendationPage()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const UploadDocumentsPage()),
            );
          } else if (index == 3) {
            // TODO: wire consultation screen
          }
        },
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.water_drop_outlined, color: currentIndex == 0 ? activeColor : Colors.grey),
                const SizedBox(height: 2),
                Text('Blood', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: currentIndex == 0 ? activeColor : inactiveColor)),
                Text('Donation', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: currentIndex == 0 ? activeColor : inactiveColor)),
              ],
            ),
            label: '',
            tooltip: 'Blood Donation',
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.medical_services_outlined, color: currentIndex == 1 ? activeColor : Colors.grey),
                const SizedBox(height: 2),
                Text('Doctor', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: currentIndex == 1 ? activeColor : inactiveColor)),
                Text('Recommendation', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: currentIndex == 1 ? activeColor : inactiveColor)),
              ],
            ),
            label: '',
            tooltip: 'Doctor Recommendation',
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.document_scanner_outlined, color: currentIndex == 2 ? activeColor : Colors.grey),
                const SizedBox(height: 2),
                Text('Upload', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: currentIndex == 2 ? activeColor : inactiveColor)),
                Text('Documents', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: currentIndex == 2 ? activeColor : inactiveColor)),
              ],
            ),
            label: '',
            tooltip: 'Upload Documents',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline, color: currentIndex == 3 ? activeColor : Colors.grey),
            label: 'Consultation',
          ),
        ],
      ),
    );
  }
}

