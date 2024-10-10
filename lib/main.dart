import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wisata Bandung',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const DetailScreen(),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wisata Bandung'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextContainer('farm', 30),
            _buildInfoRow(),
            _buildTextContainer('Deskripsi', 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTextContainer(String text, double fontSize) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }

  Widget _buildInfoRow() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildInfoColumn(Icons.calendar_today, 'Open Everyday'),
          _buildInfoColumn(Icons.access_time, '09:00 - 20:00'),
          _buildInfoColumn(Icons.monetization_on, 'Rp 25.000'),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon),
        const SizedBox(height: 8),
        Text(text),
      ],
    );
  }
}