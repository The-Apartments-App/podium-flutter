import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/src/app/app.dart';

class OwnerDashboard extends StatefulWidget {
  const OwnerDashboard({super.key});

  @override
  State<OwnerDashboard> createState() => _OwnerDashboardState();
}

class _OwnerDashboardState extends State<OwnerDashboard> {
  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);

    const defaultProfilePic = 'lib/src/assets/images/podium_logo_square.png';

    Widget getProfilePic() {
      // if (user.photo != null) {
      //   return ClipRRect(
      //     borderRadius: BorderRadius.circular(10),
      //     child: Image.network(
      //       user.photo!,
      //     ),
      //   );
      // } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          height: 48,
          width: 48,
          defaultProfilePic,
        ),
      );
      // }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(64),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getProfilePic(),
                const SizedBox(height: 36),
                Text(
                  'Good Afternoon, ${user.name}',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rental earnings for June',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          r'$420,069',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('New residents for {month}'),
                        Text('{new_residents}'),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Upcoming Inspections for {month}'),
                        Text('{number_of_inspections}'),
                      ],
                    ),
                    SizedBox(height: 48),
                    Text('Rental Requests'),
                    Text("You're all caught up!"),
                    SizedBox(height: 48),
                    Text('To-dos'),
                    Text("You're all caught up!"),
                  ],
                )
              ],
            ),
            const Column(
              children: [
                Row(
                  children: [
                    Text("What's happening {time_period}"),
                    // TabBar(
                    //   tabs: [
                    //     Tab(
                    //       child: Text('TODAY'),
                    //     ),
                    //     Tab(
                    //       child: Text('THIS WEEK'),
                    //     ),
                    //     Tab(
                    //       child: Text('THIS MONTH'),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          boxShadow: [BoxShadow(color: Colors.grey)],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [Icon(Icons.key), Text('0')],
                            ),
                            Text('Move-ins'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Column(
                        children: [
                          Row(
                            children: [Icon(Icons.exit_to_app), Text('0')],
                          ),
                          Text('Move-outs'),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Column(
                        children: [
                          Row(
                            children: [Icon(Icons.handyman), Text('0')],
                          ),
                          Text('Tasks in Progress'),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Column(
                        children: [
                          Row(
                            children: [Icon(Icons.star), Text('5.0')],
                          ),
                          Text('Guest Satisfaction'),
                        ],
                      ),
                    )
                  ],
                ),
                Divider(),
                Text('Ways to get more rentals'),
                Text('Enroll in our cleaning services program')
              ],
            )
          ],
        ),
      ),
    );
  }
}
