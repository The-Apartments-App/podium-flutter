import 'package:flutter/material.dart';

class FAQ extends StatefulWidget {
  const FAQ({super.key, required this.question, required this.answer});
  final String question;
  final String answer;

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  bool answerIsRevealed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        setState(
          () => {answerIsRevealed = !answerIsRevealed},
        )
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .425,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    widget.question,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
                if (answerIsRevealed)
                  const Icon(Icons.arrow_upward)
                else
                  const Icon(Icons.arrow_downward)
              ],
            ),
            if (answerIsRevealed)
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: Text(
                  widget.answer,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Colors.black54,
                  ),
                ),
              )
            else
              const Text(''),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
