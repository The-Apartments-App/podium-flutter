import 'package:flutter/material.dart';
import 'package:podium/src/login/view/components/login_phone_code_input.dart';
import 'package:podium/src/login/view/components/login_phone_code_submit_button.dart';
import 'package:podium/src/login/view/components/login_submit_button.dart';

class PhoneNumberCodeScreen extends StatefulWidget {
  const PhoneNumberCodeScreen({super.key, required this.returnToMain});
  final Function returnToMain;

  @override
  State<PhoneNumberCodeScreen> createState() => _PhoneNumberCodeScreenState();
}

class _PhoneNumberCodeScreenState extends State<PhoneNumberCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFFFFFFF),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 0),
            child: Stack(
              children: [
                SizedBox(
                  height: 52,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: const [
                      Expanded(
                        child: Text(
                          'Confirm your number',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 10,
                  child: Transform.scale(
                    scale: .85,
                    child: const BackButton(),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey.shade200,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: Wrap(
              children: const [
                LoginPhoneCodeInput(),
                SizedBox(
                  height: 70,
                ),
                LoginPhoneCodeSubmitButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
