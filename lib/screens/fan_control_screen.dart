import 'dart:math' as math;
import 'package:atom_fan_control/models/fan.dart';
import 'package:flutter/material.dart';
import 'package:atom_fan_control/services/default_data.dart'; // 🔥 required to update list

class FanControlScreen extends StatefulWidget {
  final Fan fan;
  const FanControlScreen({super.key, required this.fan});

  @override
  State<FanControlScreen> createState() => _FanControlScreenState();
}

class _FanControlScreenState extends State<FanControlScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    if (widget.fan.isOn) {
      _controller!.repeat();
    }
  }

  // 🔥 Update global fan list when changed
  void updateFanInList() {
    final index = mockFanJson.indexWhere((f) => f['id'] == widget.fan.id);

    if (index != -1) {
      mockFanJson[index]['power'] = widget.fan.isOn;
      mockFanJson[index]['speed'] = widget.fan.speed;
    }
  }

  void _togglePower(bool value) {
    setState(() {
      widget.fan.isOn = value;

      updateFanInList(); 
      if (value) {
        _controller?.repeat();
      } else {
        _controller?.stop();
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 229, 189),
      appBar: AppBar(title: Text(widget.fan.name)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // =============================
            // FAN ANIMATION
            // =============================
            AnimatedBuilder(
              animation: _controller ?? AlwaysStoppedAnimation(0),
              builder: (_, child) {
                return Transform.rotate(
                  angle: widget.fan.isOn
                      ? (_controller?.value ?? 0) * 2 * math.pi
                      : 0,
                  child: child,
                );
              },
              child: Icon(
                Icons.cyclone,
                size: 140,
                color: widget.fan.isOn ? Colors.green : Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            // =============================
            // POWER SWITCH
            // =============================
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: SwitchListTile(
                title: const Text(
                  "Power",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                value: widget.fan.isOn,
                activeColor: Colors.green,
                onChanged: _togglePower,
                secondary: Icon(
                  widget.fan.isOn ? Icons.power : Icons.power_off,
                  size: 32,
                  color: widget.fan.isOn ? Colors.green : Colors.red,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // =============================
            // SPEED CONTROL
            // =============================
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Fan Speed",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(5, (i) {
                      final speed = i + 1;
                      final isSelected = widget.fan.speed == speed;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.fan.speed = speed;

                            updateFanInList();

                            if (widget.fan.isOn) {
                              _controller?.duration = Duration(
                                milliseconds: (2500 ~/ speed),
                              );
                              _controller?.repeat();
                            }
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.blue.withOpacity(0.15)
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.blue
                                  : Colors.grey.shade300,
                            ),
                          ),
                          child: Text(
                            speed.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  isSelected ? Colors.blue : Colors.grey.shade600,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
