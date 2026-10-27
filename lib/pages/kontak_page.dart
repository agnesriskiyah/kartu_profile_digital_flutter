import 'package:flutter/material.dart';

class KontakPage extends StatelessWidget {
  const KontakPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(
          leading: Icon(Icons.email_outlined),
          title: Text('Email'),
          subtitle: Text('agnesriskiyah@example.com'),
        ),
        ListTile(
          leading: Icon(Icons.code),
          title: Text('GitHub'),
          subtitle: Text('github.com/agnsrskyh'),
        ),
        ListTile(
          leading: Icon(Icons.link),
          title: Text('LinkedIn'),
          subtitle: Text('linkedin.com/in/agnsrskyh'),
        ),
      ],
    );
  }
}