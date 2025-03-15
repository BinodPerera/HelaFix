import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final Function(int) onItemTapped;

  const CustomBottomNavBar({super.key, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      right: 16,
      bottom: 30,
      child: SafeArea(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: Offset(0, 4),
                ),
              ],
              border: Border.all(
                color: const Color.fromARGB(255, 0, 0, 0),
                width: 2,
              ),
            ),
            child: BottomAppBar(
              color: Colors.transparent,
              shape: const CircularNotchedRectangle(),
              notchMargin: 8.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.home, size: 45),
                      onPressed: () => onItemTapped(0),
                    ),
                    IconButton(
                      icon: const Icon(Icons.bookmark, size: 45),
                      onPressed: () => onItemTapped(1),
                    ),
                    IconButton(
                      icon: const Icon(Icons.history, size: 45),
                      onPressed: () => onItemTapped(2),
                    ),
                    IconButton(
                      icon: const Icon(Icons.person, size: 45),
                      onPressed: () => onItemTapped(3),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
