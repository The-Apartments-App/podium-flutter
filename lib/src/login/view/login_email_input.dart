import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/src/login/login.dart';

class LoginEmailInput extends StatefulWidget {
  const LoginEmailInput({super.key});

  @override
  State<LoginEmailInput> createState() => LoginEmailInputState();
}

class LoginEmailInputState extends State<LoginEmailInput> {
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
          child: TextField(
            style: const TextStyle(height: 1.5),
            key: const Key('loginFormLoginEmailInput_textField'),
            onChanged: (email) {
              context.read<LoginCubit>().emailChanged(email);
              setState(() {
                showError = false;
              });
            },
            onEditingComplete: () {
              setState(() {
                showError = true;
              });
            },
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              labelText: 'Email',
              helperText: '',
              errorText:
                  state.email.isNotValid && showError ? 'invalid email' : null,
            ),
          ),
        );
      },
    );
  }
}
