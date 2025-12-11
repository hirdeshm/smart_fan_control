import 'package:atom_fan_control/models/fan.dart';
import 'package:atom_fan_control/services/default_data.dart';
import 'package:flutter/material.dart';
import 'fan_control_screen.dart';

class FanListScreen extends StatefulWidget {
  const FanListScreen({super.key});

  @override
  State<FanListScreen> createState() => _FanListScreenState();
}

class _FanListScreenState extends State<FanListScreen> {
  @override
  Widget build(BuildContext context) {
    final fans = mockFanJson.map((e) => Fan.fromJson(e)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Available Fans",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        elevation: 1,
      ),
      backgroundColor: const Color.fromARGB(255, 242, 229, 189),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView.separated(
          itemCount: fans.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final fan = fans[index];

            return GestureDetector(
              onTap: () async {
                // 🔥 WAIT until returning from details screen
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => FanControlScreen(fan: fan)),
                );

                // 🔥 REFRESH list so updates show
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                      color: Colors.black.withOpacity(0.08),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: fan.isOn
                          ? Colors.green.withOpacity(0.15)
                          : Colors.red.withOpacity(0.15),
                      child: Icon(
                        Icons.wind_power,
                        size: 32,
                        color: fan.isOn ? Colors.green : Colors.red,
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Fan info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fan.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6),

                          Row(
                            children: [
                              Icon(
                                fan.isOn
                                    ? Icons.power_settings_new
                                    : Icons.power_off,
                                size: 18,
                                color: fan.isOn ? Colors.green : Colors.red,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                fan.isOn ? "ON" : "OFF",
                                style: TextStyle(
                                  color: fan.isOn ? Colors.green : Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Speed chip
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Speed: ${fan.speed}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                        ),
                      ),
                    ),

                    const SizedBox(width: 6),

                    const Icon(Icons.arrow_forward_ios, size: 18),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
