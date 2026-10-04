import 'package:flutter/material.dart';

class DoctorRecommendationPage extends StatefulWidget {
  const DoctorRecommendationPage({super.key});

  @override
  State<DoctorRecommendationPage> createState() => _DoctorRecommendationPageState();
}

class _DoctorRecommendationPageState extends State<DoctorRecommendationPage> {
  // Appointments stored in state so scheduling updates the UI
  final List<Map<String, String>> _appointments = [
    {
      'name': 'Dr. Sarah Chen',
      'speciality': 'Cardiologist',
      'dateTime': 'Dec 15, 2024 at 10:00 AM',
      'image': 'assets/images/dr_sarah.png',
    },
    {
      'name': 'Dr. Ben Carter',
      'speciality': 'General Physician',
      'dateTime': 'Dec 16, 2024 at 2:30 AM',
      'image': 'assets/images/dr_ben.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F5),
      // The AppBar is now managed by BottomNavScreen
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("My Appointments", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 20),
            const Text("Upcoming Appointments", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 15),
            // Build appointment cards dynamically from _appointments
            ..._appointments.asMap().entries.map((entry) {
              final int idx = entry.key;
              final ap = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: _buildAppointmentCard(context, idx, ap['name']!, ap['speciality']!, ap['dateTime']!, ap['image']!),
              );
            }).toList(),
          ],
        ),
      ),
      // The bottom navigation is now managed by BottomNavScreen
    );
  }

  Widget _buildAppointmentCard(BuildContext context, int index, String name, String speciality, String dateTime, String imagePath) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: AssetImage(imagePath),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(speciality, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                  const SizedBox(height: 5),
                  Text(dateTime, style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => _pickDateTime(context, index),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF28A79F),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text("Schedule"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDateTime(BuildContext context, int index) async {
    final DateTime now = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
    );

    if (pickedDate == null) return;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    final DateTime scheduled = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    final String formattedDate = '${scheduled.day}/${scheduled.month}/${scheduled.year} at ${_formatTimeOfDay(pickedTime, context)}';

    setState(() {
      _appointments[index]['dateTime'] = formattedDate;
    });

    if (!mounted) return;
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Appointment Scheduled'),
        content: Text('Your appointment with ${_appointments[index]['name']} is scheduled for $formattedDate.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('OK')),
        ],
      ),
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Scheduled with ${_appointments[index]['name']} on $formattedDate')),
      );
    }
  }

  String _formatTimeOfDay(TimeOfDay time, BuildContext context) {
    return time.format(context);
  }
}
