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
        return Padding(
          padding: const EdgeInsets.all(2),
          child: SizedBox(
            width: MediaQuery.of(context).size.width > 768 ? 670 : 250,
            child: TextField(
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
                errorText: state.email.isNotValid && showError
                    ? 'invalid email'
                    : null,
              ),
            ),
          ),
        );
      },
    );
  }
}
