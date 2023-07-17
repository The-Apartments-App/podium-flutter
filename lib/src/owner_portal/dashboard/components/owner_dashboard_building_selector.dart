import 'package:flutter/material.dart';

class OwnerDashboardBuildingSelector extends StatefulWidget {
  const OwnerDashboardBuildingSelector({
    super.key,
    required this.onBuildingSelected,
  });

  final ValueChanged<String> onBuildingSelected;

  @override
  OwnerDashboardBuildingSelectorState createState() =>
      OwnerDashboardBuildingSelectorState();
}

class OwnerDashboardBuildingSelectorState
    extends State<OwnerDashboardBuildingSelector> {
  final buildings = [
    'Maple Heights Residences',
    'Emerald Grove Towers',
    'Serenity View Apartments',
    'Golden Oak Manor',
  ];
  String _selectedBuilding = 'Maple Heights Residences';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 2,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedBuilding,
          dropdownColor: Colors.white,
          style: const TextStyle(color: Colors.black),
          onChanged: (String? newValue) {
            setState(() {
              _selectedBuilding = newValue!;
              widget.onBuildingSelected(_selectedBuilding);
            });
          },
          items: [
            for (var building in buildings)
              DropdownMenuItem<String>(
                value: building,
                child: Text(building),
              ),
          ],
        ),
      ),
    );
  }
}
