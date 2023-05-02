import 'dart:io';
import 'package:authentication_repo/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/src/app/app.dart';
import 'package:podium/src/resident_portal/update_profile/update_profile.dart';

class UpdateProfileDisplayNameForm extends StatefulWidget {
  const UpdateProfileDisplayNameForm({super.key});

  @override
  State<UpdateProfileDisplayNameForm> createState() => _UpdateProfileDisplayNameFormState(); 
}

class _UpdateProfileDisplayNameFormState extends State<UpdateProfileDisplayNameForm> {

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);

    return SizedBox(
      height: 300,
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  const Text('Current Display Name: ',
                   style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                  ),
                  Text(user.name ?? 'Resident',
                        style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                  )
                ],
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              
            },
            child: Row(
              children:  [ const Text('Change Display Name') ], 
                
            ),
          ),
        ],
      ),
    );
  }
}