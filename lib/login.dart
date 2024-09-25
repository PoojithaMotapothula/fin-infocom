// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_firestore_app/home.dart';
// import 'package:http/http.dart' as http;

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   Future<void> loginUser() async {
//     final response = await http.post(
//       // Uri.parse('http://localhost:3000/login'),
//       Uri.parse('http://10.0.2.2:3000/login'),
//       headers: <String, String>{'Content-Type': 'application/json'},
//       body: jsonEncode(<String, String>{
//         'email': _emailController.text,
//         'password': _passwordController.text,
//       }),
//     );

//   if (response.statusCode == 200) {
//     final data = jsonDecode(response.body);
//     if (data['role'] == 'Admin') {
//       Navigator.push(context, MaterialPageRoute(builder: (context) => AdminHomeScreen()));
//     } else {
//       Navigator.push(context, MaterialPageRoute(builder: (context) => ViewerHomeScreen()));
//     }
//   } else {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed')));
//   }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Login')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               // controller: _emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               // controller: _passwordController,
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: loginUser,
//               child: Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_firestore_app/home.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();  // Form key to validate the form
  bool _obscureText = true; // For showing/hiding password

  // Email validation regex
  final String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

  // Password validation regex (At least 1 uppercase, 1 symbol, 8 characters minimum)
  final String passwordPattern = r'^(?=.*[A-Z])(?=.*\W).{8,}$';

  // Future<void> loginUser() async {
  //   if (_formKey.currentState!.validate()) {
  //     final response = await http.post(
  //       Uri.parse('http://10.0.2.2:3000/login'),
  //       headers: <String, String>{'Content-Type': 'application/json'},
  //       body: jsonEncode(<String, String>{
  //         'email': _emailController.text,
  //         'password': _passwordController.text,
  //       }),
  //     );

  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       if (data['role'] == 'Admin') {
  //         Navigator.push(context, MaterialPageRoute(builder: (context) => AdminHomeScreen()));
  //       } else {
  //         Navigator.push(context, MaterialPageRoute(builder: (context) => ViewerHomeScreen()));
  //       }
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed')));
  //     }
  //   }
  // }

  Future<void> loginUser() async {
  // Perform validation first
  if (_formKey.currentState!.validate()) {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/login'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Debug: Print role for verification
        print('User role: ${data['role']}');

        // Role-based navigation
        if (data['role'] == 'admin') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AdminHomeScreen()));
        } else if (data['role'] == 'user') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ViewerHomeScreen()));
        } else {
          // Optional: Handle unknown roles
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Unknown role')));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed')));
      }
    } catch (e) {
      // Debug: Print error
      print('Login error: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error logging in')));
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,  // Wrap the form with the Form widget
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  } else if (!RegExp(emailPattern).hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                obscureText: _obscureText,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (!RegExp(passwordPattern).hasMatch(value)) {
                    return 'Password must be at least 8 characters,\ninclude 1 uppercase and 1 symbol';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: loginUser,
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
