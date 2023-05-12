import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/src/login/login.dart';

class LoginPhoneInput extends StatefulWidget {
  const LoginPhoneInput({super.key});

  @override
  State<LoginPhoneInput> createState() => LoginPhoneInputState();
}

class LoginPhoneInputState extends State<LoginPhoneInput> {
  bool showError = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
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
                style: const TextStyle(height: 1.5),
                key: const Key('loginFormLoginPhoneInput_textField'),
                onChanged: (phoneNumber) {
                  context.read<LoginCubit>().emailChanged(phoneNumber);
                  setState(() {
                    showError = false;
                  });
                },
                onEditingComplete: () {
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
                  errorText: state.email.isNotValid && showError
                      ? 'invalid email'
                      : null,
                  hintText: '(XXX)-XXX-XXXX',
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '''We’ll call or text you to confirm your number. Standard message and data rates apply.''',
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
