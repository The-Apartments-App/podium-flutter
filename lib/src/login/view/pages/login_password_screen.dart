import 'package:flutter/material.dart';
import 'package:podium/src/login/view/components/login_password_input.dart';
import 'package:podium/src/login/view/components/login_submit_button.dart';

class LoginPasswordScreen extends StatefulWidget {
  const LoginPasswordScreen({super.key, required this.returnToMain});
  final Function returnToMain;

  @override
  State<LoginPasswordScreen> createState() => _LoginPasswordScreenState();
}

class _LoginPasswordScreenState extends State<LoginPasswordScreen> {
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
                          'Log in',
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
                    child: BackButton(
                      onPressed: () {
                        widget.returnToMain();
                      },
                    ),
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
                LoginPasswordInput(),
                SizedBox(
                  height: 70,
                ),
                LoginSubmitButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
