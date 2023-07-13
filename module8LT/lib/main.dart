import 'package:flutter/material.dart';

void main() {
  runApp(ContactApp());
}

class ContactApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ContactListScreen(),
    );
  }
}

class Contact {
  final String name;
  final String email;
  final String phoneNumber;

  Contact({required this.name, required this.email, required this.phoneNumber});
}

class ContactListScreen extends StatelessWidget {
  final List<Contact> contacts = [
    Contact(name: 'Rokeya', email: 'rokeya@example.com', phoneNumber: '+88 0164275****'),
    Contact(name: 'Yasmin', email: 'yasmin@example.com', phoneNumber: '+88 0174275****'),
    Contact(name: 'Mim', email: 'mim@example.com', phoneNumber: '+88 0184275****'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contacts')),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(contacts[index].name),
            onTap: () {
              _showContactDetails(context, contacts[index]);
            },
          );
        },
      ),
    );
  }

  void _showContactDetails(BuildContext context, Contact contact) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Contact Details:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Name: ${contact.name}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                'Email: ${contact.email}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                'Phone: ${contact.phoneNumber}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          ),
        );
      },
    ).whenComplete(() {
    });
  }
}
