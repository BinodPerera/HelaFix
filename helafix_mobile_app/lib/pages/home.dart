import 'package:flutter/material.dart';



class Home extends StatelessWidget{
  const Home({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100], 
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo
              Row(
                children: [
                  Image.asset('assets/images/Logo-light.png', height: 40),
                  const SizedBox(width: 8),
                ],
              ),

              const SizedBox(height: 40),

              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: "Search Experts here.....",
                  prefixIcon: const Icon(Icons.search, color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Categories
              const Text(
                "Categories",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),


              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 0,
                ),
                children: [
                  categoryItem("Repairs", "assets/images/repair.png"),
                  categoryItem("Maintenance", "assets/images/maintenance.png"),
                  categoryItem("Cleaning", "assets/images/cleaning.png"),
                  categoryItem("Pets Services", "assets/images/pet.png"),
                ],
              ),

              const SizedBox(height: 20),

              // Recent On-Going Activities
              const Text(
                "Recent On-Going Activities",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Column(
                children: [
                  ongoingActivityCard(),
                  ongoingActivityCard(),
                  ongoingActivityCard(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Category Item Widget
  Widget categoryItem(String title, String imagePath) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(19),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 5),
            ],
          ),
          child: Image.asset(imagePath, height: 40), 
        ),
        const SizedBox(height: 5),
        Text(title, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  

  // Recent On-Going Activity Card Widget
  Widget ongoingActivityCard() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 5),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Cleaning > Home Cleaning > Deep Cleaning",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2), 
                  borderRadius: BorderRadius.circular(5), 
                ),
                padding: const EdgeInsets.all(2), 
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6), 
                  child: Image.asset("assets/images/exone.jpg", height: 40, width: 40, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  "Damro Cleaning Service\n02/02/2025",
                  style: TextStyle(fontSize: 14),
                ),
              ),
              const Row(
                children: [
                  Text("Active", style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold)),
                  Icon(Icons.circle, color: Colors.green, size: 12),
                ],
              ),
            ],
          ),

          const SizedBox(height: 5),
          const Text(
            "Cost: LKR 150,000",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}