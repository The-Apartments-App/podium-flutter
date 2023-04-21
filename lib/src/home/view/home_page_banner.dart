import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/src/app/app.dart';

class HomePageBanner extends StatelessWidget {
  const HomePageBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    const defaultProfilePic = 'lib/src/assets/images/apple-touch-icon.png';

    Widget getProfilePic() {
      if (user.photo != null) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            user.photo!,
          ),
        );
      } else {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            defaultProfilePic,
          ),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 60, 0, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 40),
            child: Text(
              'Profile',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(
                height: 60,
                width: 60,
                child: getProfilePic(),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                    child: Text(
                      user.name ?? 'Resident',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
