import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/src/app/app.dart';

class HomePageBanner extends StatelessWidget {
  const HomePageBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    const defaultProfilePic = 'lib/src/assets/images/podium_logo.png';

    CircleAvatar getProfilePic() {
      if (user.photo != null) {
        return CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 50,
          backgroundImage:
              Image.network(user.photo ?? 'https:www.google.com').image,
        );
      } else {
        return const CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 50,
          backgroundImage: AssetImage(defaultProfilePic),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 20, 4, 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .5,
            child: Text(
              'Welcome, ${user.name ?? "Guest"}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          getProfilePic(),
        ],
      ),
    );
  }
}
