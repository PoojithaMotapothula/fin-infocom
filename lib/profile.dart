import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  Future<void> changePassword() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/change-password'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'email': 'user@example.com',  // Fetch user email dynamically
        'currentPassword': _currentPasswordController.text,
        'newPassword': _newPasswordController.text,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password changed successfully')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to change password')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Change Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _currentPasswordController,
              decoration: InputDecoration(labelText: 'Current Password'),
              obscureText: true,
            ),
            TextField(
              controller: _newPasswordController,
              decoration: InputDecoration(labelText: 'New Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: changePassword,
              child: Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class ProfileScreen extends StatefulWidget {
//   final String userEmail; // Pass the email dynamically

//   ProfileScreen({required this.userEmail});

//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   final TextEditingController _currentPasswordController = TextEditingController();
//   final TextEditingController _newPasswordController = TextEditingController();

//   Future<void> changePassword() async {
//     try {
//       final response = await http.post(
//         Uri.parse('http://10.0.2.2:3000/change-password'),
//         headers: <String, String>{'Content-Type': 'application/json'},
//         body: jsonEncode(<String, String>{
//           'email': widget.userEmail, // Pass the actual user email
//           'currentPassword': _currentPasswordController.text,
//           'newPassword': _newPasswordController.text,
//         }),
//       );

//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Password changed successfully')),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to change password: ${response.body}')),
//         );
//         print('Failed: ${response.statusCode}, ${response.body}'); // Debug response
//       }
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $error')),
//       );
//       print('Error: $error'); // Log the error
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Change Password')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _currentPasswordController,
//               decoration: InputDecoration(labelText: 'Current Password'),
//               obscureText: true,
//             ),
//             TextField(
//               controller: _newPasswordController,
//               decoration: InputDecoration(labelText: 'New Password'),
//               obscureText: true,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: changePassword,
//               child: Text('Change Password'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
