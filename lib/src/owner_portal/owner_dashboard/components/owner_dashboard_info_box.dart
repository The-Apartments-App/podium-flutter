import 'package:flutter/material.dart';

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
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: () {
              _overlayEntry?.remove();
              _overlayEntry = null;
            },
            child: Container(
              color: Colors.black54,
            ),
          ),
          // This is your modal dialog
          GestureDetector(
            onTap: () {},
            child: Center(
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                elevation: 10,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 2,
                                ),
                              ),
                              child: CloseButton(
                                onPressed: () {
                                  _overlayEntry?.remove();
                                  _overlayEntry = null;
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      Expanded(child: widget.modalContent),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
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
