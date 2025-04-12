import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/components/bottomNavigation.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import '../theme/colors.dart';
import 'package:helafix_mobile_app/components/appbar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class JobDone extends StatelessWidget {
  const JobDone({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final ValueNotifier<bool> isWaiting = ValueNotifier(true);
    final ValueNotifier<Color> buttonColor =
        ValueNotifier(const Color.fromRGBO(217, 217, 217, 1));
    final ValueNotifier<int> currentStep = ValueNotifier(1);
    final TextEditingController priceController = TextEditingController();
    final ValueNotifier<String> matchMessage = ValueNotifier('');
    final ValueNotifier<String> matchStatus = ValueNotifier("");

    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: themeProvider.isDarkMode
          ? AppColours.primaryDark
          : AppColours.primaryLight,
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: themeProvider.isDarkMode
              ? AppColours.backgroundGradientDark
              : AppColours.backgroundGradientLight,
        ),
        child: Column(
          //JOB ONE Part

          // children: [
          //   ValueListenableBuilder(
          //     valueListenable: currentStep,
          //     builder: (context, step, _) {
          //       return Container(
          //         padding: EdgeInsets.all(70),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             for (int i = 1; i <= 3; i++) ...[
          //               CircleAvatar(
          //                 radius: 20,
          //                 backgroundColor:
          //                     i < step ?  const Color.fromARGB(255, 0, 255, 8) : Colors.white,
          //                 child: Text(
          //                   '$i',
          //                   style: TextStyle(
          //                     color: Colors.black,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ),
          //               ),
          //               if (i != 3)
          //                 Container(
          //                   width: 40,
          //                   height: 2,
          //                   color: const Color.fromARGB(255, 255, 255, 255),
          //                 ),
          //             ]
          //           ],
          //         ),
          //       );
          //     },
          //   ),
          //   ValueListenableBuilder(
          //     valueListenable: isWaiting,
          //     builder: (context, value, child) {
          //       return Container(
          //         padding: EdgeInsets.all(40),
          //         child: Text(
          //           value
          //               ? 'Service Provider Confirmation'
          //               : 'The service providers refused a request for confirmation that the work was completed.',
          //           textAlign: TextAlign.center,
          //           style: TextStyle(
          //             color: themeProvider.isDarkMode
          //                 ? AppColours.dark
          //                 : AppColours.light,
          //             fontSize: 25,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          //   ValueListenableBuilder(
          //     valueListenable: isWaiting,
          //     builder: (context, value, child) {
          //       return Container(
          //         padding: EdgeInsets.all(40),
          //         child: Text(
          //           value
          //               ? 'Waiting for service provider response.....'
          //               : 'If the job is not yet finished, you can go back and continue the job, or if there is any problem with the job, you can select the special inquiry button. ',
          //           textAlign: TextAlign.center,
          //           style: TextStyle(
          //             color: themeProvider.isDarkMode
          //                 ? AppColours.dark
          //                 : AppColours.light,
          //             fontSize: 16,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          //   ValueListenableBuilder(
          //     valueListenable: isWaiting,
          //     builder: (context, value, child) {
          //       return value
          //           ? Container(
          //               alignment: Alignment.center,
          //               padding: EdgeInsets.all(40),
          //               child: SpinKitFadingCircle(
          //                 color: themeProvider.isDarkMode
          //                     ? Colors.white
          //                     : Colors.black,
          //                 size: 100.0,
          //               ),
          //             )
          //           : SizedBox.shrink();
          //     },
          //   ),
          //   Container(
          //     padding: EdgeInsets.all(40),
          //     child: ValueListenableBuilder(
          //       valueListenable: buttonColor,
          //       builder: (context, color, child) {
          //         return ElevatedButton(
          //           style: ElevatedButton.styleFrom(
          //             foregroundColor: const Color.fromARGB(255, 0, 0, 0),
          //             backgroundColor: color,
          //             padding:
          //                 EdgeInsets.symmetric(horizontal: 80, vertical: 15),
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(10),
          //             ),
          //           ),
          //           onPressed: () {
          //             isWaiting.value = false;
          //             buttonColor.value = Colors.red;
          //           },
          //           child: Text(
          //             'Special Inquiries',
          //             style: TextStyle(
          //               color: Colors.black,
          //               fontSize: 20,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //         );
          //       },
          //     ),
          //   ),
          // ],

          //JOB TWO Part

          children: [
            ValueListenableBuilder(
              valueListenable: currentStep,
              builder: (context, step, _) {
                return Container(
                  padding: EdgeInsets.all(70),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 1; i <= 3; i++) ...[
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: i < step
                              ? const Color.fromARGB(255, 0, 255, 8)
                              : Colors.white,
                          child: Text(
                            '$i',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (i != 3)
                          Container(
                            width: 40,
                            height: 2,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                      ]
                    ],
                  ),
                );
              },
            ),
            Container(
              padding: EdgeInsets.all(0),
              child: Text(
                'Cost Checking',
                style: TextStyle(
                  color: themeProvider.isDarkMode
                      ? AppColours.dark
                      : AppColours.light,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Proceed with this step only when both parties agree on the same cost.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: themeProvider.isDarkMode
                      ? AppColours.dark
                      : AppColours.light,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: SizedBox(
                width: 250.0,
                child: TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    labelText: "Enter your final price",
                    prefixText: "LKR ",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: ValueListenableBuilder(
                valueListenable: buttonColor,
                builder: (context, color, child) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 30, 255, 0),
                      padding:
                          EdgeInsets.symmetric(horizontal: 45, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      final inputText =
                          priceController.text.replaceAll(',', '').trim();
                      final inputPrice = double.tryParse(inputText);
                      isWaiting.value = false;
                      if (inputPrice == 180000.00) {
                        matchStatus.value = "matched";
                      } else {
                        matchStatus.value = "unmatched";
                      }
                      buttonColor.value = const Color.fromARGB(255, 30, 255, 0);
                    },
                    child: Text(
                      'Submit Price',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(
              color: Colors.black,
              thickness: 1.0,
              indent: 15.0,
              endIndent: 15.0,
            ),
            ValueListenableBuilder(
              valueListenable: isWaiting,
              builder: (context, value, child) {
                return Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    value
                        ? 'Waiting for service provider response.....'
                        : 'The service provider responded',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: themeProvider.isDarkMode
                          ? AppColours.dark
                          : AppColours.light,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable: isWaiting,
              builder: (context, value, child) {
                return value
                    ? SizedBox.shrink()
                    : Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.0),
                            width: 250.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'LKR 180,000.00',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          ValueListenableBuilder(
                            valueListenable: matchMessage,
                            builder: (context, msg, _) {
                              return msg.isEmpty
                                  ? Column(
                                      children: [

                                        //Check value part

                                        // Container(
                                        //   padding: EdgeInsets.all(20),
                                        //   child: Text(
                                        //     'Checking values......',
                                        //     textAlign: TextAlign.center,
                                        //     style: TextStyle(
                                        //       color: themeProvider.isDarkMode
                                        //           ? AppColours.dark
                                        //           : AppColours.light,
                                        //       fontSize: 14,
                                        //       fontWeight: FontWeight.bold,
                                        //     ),
                                        //   ),
                                        // ),
                                        // Container(
                                        //   alignment: Alignment.center,
                                        //   padding: EdgeInsets.all(0),
                                        //   child: SpinKitFadingCircle(
                                        //     color: themeProvider.isDarkMode
                                        //         ? Colors.white
                                        //         : Colors.black,
                                        //     size: 60.0,
                                        //   ),
                                        // ),

                                        Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(20),
                                          child: Image.asset(
                                            'assets/images/check.png',
                                            height: 60,
                                          ),
                                        ),

                                        SizedBox(height: 0),
                                        Text(
                                          'Values Matched.',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ),
                                        ),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                height: 50,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:  const Color.fromARGB(255, 30, 255, 0),
                                                    shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(10),
                                                    ),
                                                  ),
                                                  onPressed: () {},
                                                  child: const Text(
                                                    'Try again',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                                width:10), 
                                            Expanded(
                                              child: SizedBox(
                                                height: 50,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:const Color.fromARGB(255, 226, 226, 226),
                                                    shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(10),
                                                    ),
                                                  ),
                                                  onPressed: () {},
                                                  child: const Text(
                                                    'Special Inquiries',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        msg,
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                            },
                          ),
                        ],
                      );
              },
            ),
            ValueListenableBuilder(
              valueListenable: isWaiting,
              builder: (context, value, child) {
                return value
                    ? Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(0),
                        child: SpinKitFadingCircle(
                          color: themeProvider.isDarkMode
                              ? Colors.white
                              : Colors.black,
                          size: 100.0,
                        ),
                      )
                    : SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          currentStep.value = currentStep.value < 4 ? currentStep.value + 1 : 1;
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.refresh),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        onItemTapped: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/bookmarks');
          }
        },
      ),
    );
  }
}
