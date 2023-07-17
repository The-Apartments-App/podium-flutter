import 'package:authentication_repo/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/src/app/app.dart';
import 'package:podium/src/shared/shared_index.dart';

class ProfilePageCard extends StatelessWidget {
  const ProfilePageCard({super.key});

  static Widget getProfilePic(User user) {
    if (user.photo != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Image.network(
          user.photo!,
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Image.asset(podiumLogoRound),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);

    return Card(
      color: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      shadowColor: Colors.black,
      elevation: 20,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: 175,
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: 80,
                      width: 80,
                      child: getProfilePic(user),
                    ),
                  ),
                  if (user.name != null)
                    Text(
                      user.name!,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  const Text(
                    'Resident',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '2',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Years on Podium',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 10),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
