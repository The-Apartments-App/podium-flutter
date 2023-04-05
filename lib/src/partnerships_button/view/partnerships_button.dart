import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class PartnershipsButton extends StatefulWidget {
  const PartnershipsButton({super.key});

  @override
  State<PartnershipsButton> createState() => _PartnershipsButtonState();
}

class _PartnershipsButtonState extends State<PartnershipsButton> {
  @override
  Widget build(BuildContext context) {
    final bodyTextController = TextEditingController();
    final subjectTextController = TextEditingController();
    final messageTextController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    Future<void> send() async {
      final email = Email(
        body: bodyTextController.text,
        subject: subjectTextController.text,
        recipients: ['dylanvia@podiumapartments.com'],
      );

      String platformResponse;

      try {
        await FlutterEmailSender.send(email);
        platformResponse = 'Email sent';
      } catch (error) {
        debugPrint('error: $error');
        platformResponse = error.toString();
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(platformResponse),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }

    // Future<void> submitForm() async {
    //   if (formKey.currentState!.validate()) {
    //     const url = 'https://formsubmit.co/dylanvia@podiumapartments.com';
    //     final response = await http.post(
    //       Uri.parse(url),
    //       body: {
    //         'email': emailTextController.text,
    //         'message': messageTextController.text,
    //       },
    //     );
    //     debugPrint(
    //         'response.statusCode from posting email: ${response.statusCode}');
    //     if (response.statusCode != 200) {
    //       showDialog(
    //         context: context,
    //         builder: (context) => AlertDialog(
    //           title: const Text('Error'),
    //           content: const Text(
    //               'There was an error submitting the form. Please try again later.'),
    //           actions: [
    //             TextButton(
    //               onPressed: () {
    //                 Navigator.of(context).pop();
    //               },
    //               child: const Text('OK'),
    //             ),
    //           ],
    //         ),
    //       );
    //     } else {
    //       showDialog(
    //         context: context,
    //         builder: (context) => AlertDialog(
    //           title: const Text('Success'),
    //           content: const Text('Thank you for your submission!'),
    //           actions: [
    //             TextButton(
    //               onPressed: () {
    //                 Navigator.of(context).pop();
    //               },
    //               child: const Text('OK'),
    //             ),
    //           ],
    //         ),
    //       );
    //       emailTextController.clear();
    //       messageTextController.clear();
    //     }
    //   }
    // }

    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          useSafeArea: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(25)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close,
                                color: Colors.black,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Partnerships',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'questrialFont',
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff098d69),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              controller: subjectTextController,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: messageTextController,
                              decoration: InputDecoration(
                                hintText: 'Message',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                              ),
                              minLines: 5,
                              maxLines: 5,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: send,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff098d69),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                              ),
                              child: const Text(
                                'Submit',
                                style: TextStyle(
                                  fontFamily: 'questrialFont',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: const BorderSide(
          color: Color(0xff098d69),
          width: 3,
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text(
        'Partnerships',
        style: TextStyle(
          fontFamily: 'questrialFont',
          fontSize: 22,
          color: Color(0xff098d69),
        ),
      ),
    );
  }
}
