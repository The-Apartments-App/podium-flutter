import 'package:emailjs/emailjs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

class PartnershipsButton extends StatefulWidget {
  const PartnershipsButton({super.key});

  @override
  State<PartnershipsButton> createState() => _PartnershipsButtonState();
}

class _PartnershipsButtonState extends State<PartnershipsButton> {
  final emailTextController = TextEditingController();
  final messageTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Future<void> sendEmail(BuildContext context) async {
    // final privateKey = dotenv.env['EMAILJS_PRIVATE_KEY'];
    // final serviceID =
    //     dotenv.env['EMAILJS_SERVICE_ID'] ?? 'No service ID available';
    // final templateID =
    //     dotenv.env['EMAILJS_TEMPLATE_ID'] ?? 'No template ID available';
    const privateKey = 'tkDacOuC2kK9X6eBYw6LA';
    const serviceID = 'service_lslzt23';
    const templateID = 'template_y5ke9zn';
    try {
      if (emailTextController.text.isEmpty) {
        await showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Failure.'),
            content: const Text('Your message has not been sent.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
        return;
      }
      await EmailJS.send(
        serviceID,
        templateID,
        {
          'user_email': emailTextController.text,
          'message': messageTextController.text,
        },
        const Options(
          publicKey: 'MmTXgvYuIKZsRmifl',
          privateKey: privateKey,
        ),
      );
      debugPrint('SUCCESS!');
      // ignore: use_build_context_synchronously
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Success!'),
          content: const Text('Your message has been sent.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    } catch (error) {
      if (error is EmailJSResponseStatus) {
        debugPrint('ERROR... ${error.status}: ${error.text}');
      }
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return PlatformElevatedButton(
      onPressed: () {
        showModalBottomSheet<void>(
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
                              controller: emailTextController,
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
                            PlatformElevatedButton(
                              onPressed: () => sendEmail(context),
                              // style: PlatformElevatedButton.styleFrom(
                              //   backgroundColor: const Color(0xff098d69),
                              //   shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(10),
                              //   ),
                              //   padding:
                              //       const EdgeInsets.symmetric(vertical: 10),
                              // ),
                              color: const Color(0xFF03795D),
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
      // style: PlatformElevatedButton.styleFrom(
      //   backgroundColor: Colors.white,
      //   side: const BorderSide(
      //     color: Color(0xff098d69),
      //     width: 3,
      //   ),
      //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(10),
      //   ),
      // ),
      color: Colors.white,
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
