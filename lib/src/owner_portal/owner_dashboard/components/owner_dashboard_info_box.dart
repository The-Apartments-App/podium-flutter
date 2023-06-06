import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class OwnerDashboardInfoBox extends StatefulWidget {
  const OwnerDashboardInfoBox({
    super.key,
    required this.boxTitle,
    required this.icon,
    required this.boxInfo,
    required this.modalContent,
  });
  final String boxTitle;
  final String boxInfo;
  final IconData icon;
  final Widget modalContent;

  @override
  OwnerDashboardInfoBoxState createState() => OwnerDashboardInfoBoxState();
}

class OwnerDashboardInfoBoxState extends State<OwnerDashboardInfoBox> {
  OverlayEntry? _overlayEntry;

  void _showOverlay(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned.fill(
        top: 50,
        right: 50,
        bottom: 50,
        left: 50,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 10,
                spreadRadius: 500,
              ),
            ],
          ),
          child: Material(
            animationDuration: const Duration(milliseconds: 500),
            elevation: 10,
            shadowColor: Colors.black54,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width * 0.8,
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        widget.boxTitle,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Divider(),
                    Expanded(child: widget.modalContent),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 32),
                      child: PlatformElevatedButton(
                        onPressed: () {
                          _overlayEntry?.remove();
                          _overlayEntry = null;
                        },
                        child: const Text('Close'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showOverlay(context),
      child: SizedBox(
        height: 150,
        width: 150,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(widget.icon),
                    Text(
                      widget.boxInfo,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    widget.boxTitle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
