import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';

class SubtaskContainer extends StatelessWidget {
  const SubtaskContainer({
    Key? key,
    required this.taskName,
    required this.taskETA,
  }) : super(key: key);

  final String taskName;
  final Duration taskETA;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kPadding),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(left: kPadding * 2),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  taskName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            const VerticalDivider(
              indent: kPadding,
              endIndent: kPadding,
              thickness: 2,
            ),
            Container(
              margin:
                  const EdgeInsets.only(left: kPadding, right: kPadding * 2),
              child: RichText(
                text: TextSpan(
                  text: 'ETA: ',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600, // Semi-bold
                  ),
                  children: [
                    TextSpan(
                      text: prettyDuration(taskETA),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
