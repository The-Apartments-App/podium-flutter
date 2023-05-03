import 'dart:io';
import 'package:authentication_repo/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:podium/src/app/app.dart';
import 'package:podium/src/resident_portal/update_profile/update_profile.dart';

class UpdateProfileDisplayNameForm extends StatefulWidget {
  const UpdateProfileDisplayNameForm({super.key});

  @override
  State<UpdateProfileDisplayNameForm> createState() =>
      _UpdateProfileDisplayNameFormState();
}

class _UpdateProfileDisplayNameFormState
    extends State<UpdateProfileDisplayNameForm> {
  final nameController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userName = context.select((AppBloc bloc) => bloc.state.user.name);
    final _formUsername = GlobalKey<FormState>();
    final changeUserNameFunction =
        context.select((UpdateProfileCubit cubit) => cubit);
    final user = context.select((AppBloc bloc) => bloc.state.user);

    debugPrint(user.toString());

    return SizedBox(
      height: 300,
      width: 300,
      child: Form(
        key: _formUsername,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    const Text(
                      'Current Display Name: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      userName ?? 'Resident',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Text(
                      'New Display Name: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      // sized box used to fix "Error: Cannot hit test a render box with no size."
                      width: 200,
                      child: TextFormField(
                        controller: nameController,
                        validator: (name) {
                          if (name == null || name.isEmpty) {
                            return 'Please enter a new username';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (_formUsername.currentState!.validate()) {
                  debugPrint(nameController.text);
                  changeUserNameFunction.userNameChanged(nameController.text);
                  debugPrint(user.toString());
                }
              },
              child: Row(
                children: const [Text('Change Display Name')],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
