import 'package:flutter/material.dart';
import '../models/fan.dart';

class FanListTile extends StatelessWidget {
  final Fan fan;
  final VoidCallback onTap;

  const FanListTile({required this.fan, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(fan.isOn ? Icons.air : Icons.air_outlined, size: 32),
      title: Text(fan.name),
      subtitle: Text("Speed: ${fan.speed}"),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
