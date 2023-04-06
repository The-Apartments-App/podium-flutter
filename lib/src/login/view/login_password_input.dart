import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/src/login/login.dart';

class LoginPasswordInput extends StatefulWidget {
  const LoginPasswordInput({super.key});

  @override
  PasswordState createState() => PasswordState();
}

class PasswordState extends State<LoginPasswordInput> {
  @override
  void initState() {
    super.initState();
  }

  bool obscureTextSet = true;
  bool showError = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(2),
          child: TextField(
            key: const Key('loginFormLoginpasswordInput_textField'),
            onChanged: (password) {
              context.read<LoginCubit>().passwordChanged(password);
              setState(() {
                showError = false;
              });
            },
            onEditingComplete: () {
              setState(() {
                showError = true;
              });
            },
            obscureText: obscureTextSet,
            decoration: InputDecoration(
              labelText: 'password',
              helperText: '',
              errorText: state.password.isNotValid && showError
                  ? 'invalid password'
                  : null,
              suffixIcon: IconButton(
                icon: Icon(
                  obscureTextSet ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () => {
                  setState(() {
                    obscureTextSet = !obscureTextSet;
                  })
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
