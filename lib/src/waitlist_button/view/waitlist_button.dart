import 'package:emailjs/emailjs.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

class WaitlistButton extends StatefulWidget {
  const WaitlistButton({super.key});

  @override
  State<WaitlistButton> createState() => _WaitlistButtonState();
}

class _WaitlistButtonState extends State<WaitlistButton> {
  final emailTextController = TextEditingController();
  final messageTextController = TextEditingController();
  final fullNameTextController = TextEditingController();
  final phoneNumberTextController = TextEditingController();
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
          'full_name': fullNameTextController.text,
        },
        const Options(
          publicKey: 'MmTXgvYuIKZsRmifl',
          privateKey: privateKey,
        ),
      );
      debugPrint('SUCCESS!');
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
    Future<void> showContactModal() async {
      if (MediaQuery.of(context).size.width < 700) {
        await showModalBottomSheet<void>(
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
                            ElevatedButton(
                              onPressed: () => sendEmail(context),
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
      } else {
        await showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
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
                        const Padding(
                          padding: EdgeInsets.only(top: 16, bottom: 16),
                          child: Text(
                            "Let's talk",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(24),
                          child: Text(
                            '''Fill out the form below and we will reach out to learn about your apartment rental needs.''',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: TextFormField(
                                  controller: fullNameTextController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    labelText: 'Full name',
                                    hintText: 'Full name',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: TextFormField(
                                  controller: emailTextController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    labelText: 'Email address',
                                    hintText: 'Email address',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: TextFormField(
                                  controller: phoneNumberTextController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    labelText: 'Phone Number',
                                    hintText: '(XXX)-XXX-XXXX',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: TextFormField(
                                  controller: messageTextController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    labelText: 'Say hello!',
                                    hintText: 'Say hello!',
                                  ),
                                  minLines: 3,
                                  maxLines: 3,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: ElevatedButton(
                                  onPressed: () => sendEmail(context),
                                  style: const ButtonStyle(
                                    shadowColor: MaterialStatePropertyAll(
                                      Colors.transparent,
                                    ),
                                    shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Text(
                                      'Start the conversation',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
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
              ),
            );
          },
        );
      }
    }

    Future<void> goToTypeForm() async {
      await launchUrl(
        Uri.parse('https://xhy4plsbs2i.typeform.com/to/k9E5sWoH'),
      );
    }

    return ElevatedButton(
      onPressed: goToTypeForm,
      style: const ButtonStyle(
        shadowColor: MaterialStatePropertyAll(Colors.transparent),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
      child: const Text(
        'Join the waitlist',
        style: TextStyle(
          letterSpacing: .55,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
