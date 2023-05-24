import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final formUsername = GlobalKey<FormState>();
    final changeUserNameCubit =
        context.select((UpdateProfileNameCubit cubit) => cubit);
    final user = context.select((AppBloc bloc) => bloc.state.user);

    return SizedBox(
      height: 300,
      width: 300,
      child: Form(
        key: formUsername,
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
                      user.name ?? 'Resident',
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
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
                    SizedBox(
                      // sized box used to fix "Error: Cannot hit test a render
                      //box with no size."
                      width: 200,
                      child: TextFormField(
                        controller: nameController,
                        onChanged: (name) => context
                            .read<UpdateProfileNameCubit>()
                            .userNameChanged(name),
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
                if (formUsername.currentState!.validate()) {
                  changeUserNameCubit
                      .updateWithNewDisplayName(nameController.text);
                  Navigator.pop(context);
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered)) {
                    return const Color.fromRGBO(54, 106, 79, 1);
                  }
                  return const Color.fromRGBO(76, 150, 111, 1);
                }),
              ),
              child: const Row(
                children: [Text('Change Display Name')],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
