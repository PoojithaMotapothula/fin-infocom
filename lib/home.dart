import 'package:flutter/material.dart';
import 'package:flutter_firestore_app/adduserscreen.dart';
import 'package:flutter_firestore_app/login.dart';
import 'package:flutter_firestore_app/profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminHomeScreen extends StatefulWidget {
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  List users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/users'));
    if (response.statusCode == 200) {
      setState(() {
        users = jsonDecode(response.body);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to load users')));
    }
  }

  void _navigateToAddUserScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddUserScreen()));
  }

  void _navigateToProfileScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
  }

  void _logout() {
    // Add your logout logic here, e.g., clearing tokens or session
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()), // Replace with your login screen
      (Route<dynamic> route) => false, // Ensures no back button to home screen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: _navigateToProfileScreen,
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout, // Call logout when pressed
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(users[index]['username']),
                  subtitle: Text(users[index]['role']),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _navigateToAddUserScreen,
            child: Text('Add User'), // Only visible to Admin
          ),
        ],
      ),
    );
  }
}

class ViewerHomeScreen extends StatefulWidget {
  @override
  _ViewerHomeScreenState createState() => _ViewerHomeScreenState();
}

class _ViewerHomeScreenState extends State<ViewerHomeScreen> {
  List users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/users'));
    if (response.statusCode == 200) {
      setState(() {
        users = jsonDecode(response.body);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to load users')));
    }
  }

  void _navigateToProfileScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
  }

  void _logout() {
    // Add your logout logic here, e.g., clearing tokens or session
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()), // Replace with your login screen
      (Route<dynamic> route) => false, // Ensures no back button to home screen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Viewer Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: _navigateToProfileScreen,
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout, // Call logout when pressed
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(users[index]['username']),
            subtitle: Text(users[index]['role']),
          );
        },
      ),
    );
  }
}
