import 'package:flutter/material.dart';

class DonorRegistrationForm extends StatefulWidget {
  const DonorRegistrationForm({super.key});

  @override
  State<DonorRegistrationForm> createState() => _DonorRegistrationFormState();
}

class _DonorRegistrationFormState extends State<DonorRegistrationForm> {
  bool _agreedToTerms = false;

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Registered successfully!'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss the dialog
                Navigator.of(context).pop();      // Go back to the previous screen (BloodDonationPage)
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F5),
      appBar: AppBar(
        title: const Text('Become a Donor', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.grey[800]),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF28A79F),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Donor Registration Form',
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildTextField(hintText: 'Full Name'),
              const SizedBox(height: 15),
              _buildTextField(hintText: 'Date of Birth', suffixIcon: Icons.calendar_today_outlined),
              const SizedBox(height: 15),
              _buildTextField(hintText: 'Blood Type (A+ O- A+)', suffixIcon: Icons.arrow_drop_down),
              const SizedBox(height: 15),
              _buildTextField(hintText: 'Last Donation Date', suffixIcon: Icons.calendar_today_outlined),
              const SizedBox(height: 15),
              _buildTextField(hintText: 'Contact Number'),
              const SizedBox(height: 15),
              _buildTextField(hintText: 'Emergency Contact Number'),
              const SizedBox(height: 15),
              _buildTextField(hintText: 'Email Address'),
              const SizedBox(height: 10),
              _buildTermsAndConditions(),
              const SizedBox(height: 20),
              _buildRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String hintText, IconData? suffixIcon}) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[600]),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: Colors.grey[600]) : null,
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return Row(
      children: [
        Checkbox(
          value: _agreedToTerms,
          onChanged: (bool? value) {
            setState(() {
              _agreedToTerms = value ?? false;
            });
          },
          activeColor: Colors.white,
          checkColor: const Color(0xFF28A79F),
        ),
        const Expanded(
          child: Text(
            'Your information is confidential and will be used for blood donation purposes only.',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _showSuccessDialog, // Call the method to show the dialog
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0E857C), // A slightly darker shade for contrast
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: const Text(
          'Register as Donor',
          style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
