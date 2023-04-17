import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/src/login/login.dart';

import 'package:podium/src/login/view/components/login_country_code_dropdown_menu.dart';

class LoginPhoneInput extends StatefulWidget {
  const LoginPhoneInput({super.key});

  @override
  State<LoginPhoneInput> createState() => LoginPhoneInputState();
}

String formatPhoneNumber(String phoneNumber) {
  // Remove all non-digit characters
  final digitsOnly = phoneNumber.replaceAll(RegExp('[^0-9]'), '');

  // Check if the input is a valid phone number with 10 digits
  if (digitsOnly.length != 10) {
    throw ArgumentError('Invalid phone number');
  }

  // Format the digits into the desired format
  return '${digitsOnly.substring(0, 3)}-${digitsOnly.substring(3, 6)}-${digitsOnly.substring(6)}';
}

class LoginPhoneInputState extends State<LoginPhoneInput> {
  bool showError = false;
  TextEditingController phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) =>
          previous.phoneNumber != current.phoneNumber,
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width >= 750
              ? 670
              : MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const CountryCodeDropdown(),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: phoneNumberController,
                style: const TextStyle(height: 1.5),
                key: const Key('loginFormLoginPhoneInput_textField'),
                onChanged: (phoneNumber) {
                  context.read<LoginCubit>().phoneNumberChanged(phoneNumber);
                  setState(() {
                    showError = false;
                  });
                },
                onEditingComplete: () {
                  phoneNumberController.text =
                      formatPhoneNumber(phoneNumberController.text);
                  setState(() {
                    showError = true;
                  });
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelText: 'Phone Number',
                  errorText:
                      phoneNumberController.text.length != 12 && showError
                          ? 'invalid phone number'
                          : null,
                  hintText: '(XXX)-XXX-XXXX',
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'We’ll call or text you to confirm your number. Standard message and data rates apply.',
                style: TextStyle(
                  letterSpacing: .175,
                  fontSize: 12,
                  color: Color(0xFF222222),
                ),
              ),
              const SizedBox(height: 14),
            ],
          ),
        );
      },
    );
  }
}
