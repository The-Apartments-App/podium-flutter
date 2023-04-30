import 'package:flutter/material.dart';

class ResidentLoginContainer extends StatelessWidget {
  const ResidentLoginContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      width: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 5,
            color: Colors.grey.withOpacity(0.3),
            offset: const Offset(-2, 2),
          )
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Elevate your lifestyle with Podium',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                """Find your perfect Podium pad, whether it's a cozy condo, chic city flat, or serene suburban retreat""",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 48.5,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      shadowColor: MaterialStatePropertyAll(Colors.transparent),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Resident Login',
                      style: TextStyle(
                        letterSpacing: .55,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onPressed: () => {},
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 48.5,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      shadowColor: MaterialStatePropertyAll(Colors.transparent),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Partnership Request',
                      style: TextStyle(
                        letterSpacing: .55,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onPressed: () => {},
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
