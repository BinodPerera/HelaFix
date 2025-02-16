import 'package:flutter/material.dart';

// import components
//import '../components/appbar.dart';

class Login extends StatelessWidget{
  const Login({super.key});


  @override
  Widget build(BuildContext context){
    return Scaffold(

      backgroundColor: const Color.fromARGB(255, 255, 255, 255),

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100), 
        child: Container(
          margin: const EdgeInsets.only(top: 40), 
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0, 
            title: Image.asset(
              'assets/images/logo_bg_light.png',
              height: 60,
            ),
            centerTitle: true,
          ),
        ),
      ),


      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [

            SizedBox( height: 70),
            
            Center(
              child: Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),

            SizedBox( height: 35),

            TextField(
              decoration: InputDecoration(
                hintText: "Email Address",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0), // Rounded corners
                ),
              ),
            ),

            SizedBox( height: 25),

            TextField(
              decoration: InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0), // Rounded corners
                ),
              ),
            ),

            SizedBox( height: 25),

            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  // Respond to button press
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: const Color.fromARGB(255, 0, 255, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0), // Rounded corners
                  ),
                ),
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SizedBox( height: 85),

            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  // Respond to button press
                },
                child: Text('Forgot Password?'),
              ),
            ),

            Divider(
              color: Colors.black,
              thickness: 1, height: 50,
            ),


            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  // Respond to button press
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: const Color.fromARGB(255, 240, 240, 240),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0), // Rounded corners
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/google.png', // Path to your image
                      height: 30, // Adjust height
                    ),

                    SizedBox(width: 10),

                    Text(
                      'Login with Google', 
                      style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}