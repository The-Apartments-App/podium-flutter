import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:podium/src/app/app.dart';
import 'package:podium/src/owner_portal/owner_dashboard/components/owner_dashboard_components.dart';
import 'package:podium/src/owner_portal/owner_dashboard/modal_content/modal_content.dart';
import 'package:podium/src/shared/shared_index.dart';

class OwnerDashboard extends StatefulWidget {
  const OwnerDashboard({super.key});

  @override
  State<OwnerDashboard> createState() => _OwnerDashboardState();
}

class _OwnerDashboardState extends State<OwnerDashboard> {
  int activeTabIndex = 0;
  final timeLengths = [
    'TODAY',
    'TOMORROW',
    'THIS WEEK',
  ];
  void handleTabTap(int index) {
    setState(() {
      activeTabIndex = index;
    });
  }

  String currentBuilding = 'Maple Heights Residences';

  void updateBuilding(String selectedBuilding) {
    setState(() {
      currentBuilding = selectedBuilding;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    final appBloc = context.select((AppBloc bloc) => bloc);
    void signOut() {
      appBloc.add(AppLogoutRequested());
      context.go('/');
    }

    return Scaffold(
      body: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.grey.shade300),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 404),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getProfilePic(),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 32),
                      child: Text(
                        'Good Afternoon, ${user.name ?? ''}',
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w600,
                        ),
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
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              r'$431,449',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('New residents for June'),
                            Text('12'),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Upcoming Inspections for June'),
                            Text('2'),
                          ],
                        ),
                        SizedBox(height: 80),
                        Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Rental Requests',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios_rounded)
                            ],
                          ),
                        ),
                        Text("You're all caught up!"),
                        SizedBox(height: 80),
                        Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'To-dos',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios_rounded)
                            ],
                          ),
                        ),
                        Text("You're all caught up!"),
                      ],
                    ),
                    const Expanded(child: SizedBox()),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 500,
                          minHeight: 64,
                        ),
                        child: OutlinedButton(
                          style: ButtonStyle(
                            side: MaterialStateProperty.all(
                              const BorderSide(width: 1.25),
                            ), // Heavy border
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ), // Shape
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.all(10),
                            ), // Inner padding
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                          ),
                          onPressed: signOut,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Icon // Spacing
                              Text(
                                'Log out',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ), // Text
                            ],
                          ),
                        ),
                      ),
                    ),
                    const PodiumFooter(),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(100),
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  size: MediaQuery.of(context).size,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(minWidth: 710),
                            child: Text(
                              """What's happening ${timeLengths[activeTabIndex].toLowerCase()} at $currentBuilding""",
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            CustomTab(
                              title: 'TODAY',
                              tabIndex: 0,
                              activeTabIndex: activeTabIndex,
                              onTabSelected: handleTabTap,
                            ),
                            CustomTab(
                              title: 'TOMORROW',
                              tabIndex: 1,
                              activeTabIndex: activeTabIndex,
                              onTabSelected: handleTabTap,
                            ),
                            CustomTab(
                              title: 'THIS WEEK',
                              tabIndex: 2,
                              activeTabIndex: activeTabIndex,
                              onTabSelected: handleTabTap,
                            ),
                          ],
                        ),
                        OwnerDashboardBuildingSelector(
                          onBuildingSelected: updateBuilding,
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 64, bottom: 128),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OwnerDashboardInfoBox(
                            boxTitle: 'Move-ins',
                            icon: Icons.key,
                            boxInfo: '4',
                            modalContent: MoveInsModal(),
                          ),
                          OwnerDashboardInfoBox(
                            boxTitle: 'Move-outs',
                            icon: Icons.exit_to_app,
                            boxInfo: '1',
                            modalContent: MoveOutsModal(),
                          ),
                          OwnerDashboardInfoBox(
                            boxTitle: 'Maintenance',
                            icon: Icons.handyman,
                            boxInfo: '2',
                            modalContent: MaintenanceModal(),
                          ),
                          OwnerDashboardInfoBox(
                            boxTitle: 'Guest Reviews',
                            icon: Icons.star,
                            boxInfo: '4.97',
                            modalContent: GuestReviewsModal(),
                          ),
                          OwnerDashboardInfoBox(
                            boxTitle: 'Occupancy Rate',
                            icon: Icons.home,
                            boxInfo: '98%',
                            modalContent: OccupancyRateModal(),
                          ),
                          OwnerDashboardInfoBox(
                            boxTitle: 'Rental Income',
                            icon: Icons.attach_money_rounded,
                            boxInfo: '452,719',
                            modalContent: RentalIncomeModal(),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 64, 16, 64),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Ways to get more Rentals',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 24),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Enroll in the new cleaning protocol',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios_rounded)
                              ],
                            ),
                            const SizedBox(height: 24),
                            Text(
                              """We'll show a special cleaning highlight at the top of the listing you've opted in.""",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                LinearProgressIndicator(
                                  minHeight: 2,
                                  value: 0.5,
                                  backgroundColor: Colors.grey.shade300,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                    Color(0xFF03795D),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Text(
                                      '0/1',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTab extends StatelessWidget {
  const CustomTab({
    super.key,
    required this.title,
    required this.tabIndex,
    required this.activeTabIndex,
    required this.onTabSelected,
  });

  final String title;
  final int tabIndex;
  final int activeTabIndex;
  // ignore: inference_failure_on_function_return_type
  final Function(int) onTabSelected;

  @override
  Widget build(BuildContext context) {
    final isSelected = tabIndex == activeTabIndex;

    return InkWell(
      onTap: () => onTabSelected(tabIndex),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF03795D) : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
