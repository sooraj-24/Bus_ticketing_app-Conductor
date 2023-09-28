import 'package:flutter/material.dart';

import '../constants.dart';

class BusCard extends StatelessWidget {
  const BusCard({
  super.key, required this.startTime, required this.destination, required this.onTap, required this.sessionStarted});

  final DateTime startTime;
  final String destination;
  final VoidCallback onTap;
  final bool sessionStarted;

  @override
  Widget build(BuildContext context) {
    var minute = TimeOfDay.fromDateTime(startTime.toLocal()).minute;
    var hour = TimeOfDay.fromDateTime(startTime.toLocal()).hourOfPeriod;
    var period = TimeOfDay.fromDateTime(startTime.toLocal()).period.toString();
    period = period.substring(10).toUpperCase();
    return Container(
      height: 80,
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(4, 4), // changes position of shadow
          ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(-4, -4), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            decoration: const BoxDecoration(
              color: kYellow,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
            ),
          ),
          Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 30),
                decoration: const BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              minute == 0 ? '$hour:${minute}0' : '$hour:$minute',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            const SizedBox(width: 3,),
                            Text(
                              period,
                              style: const TextStyle(
                                  fontSize: 14
                              ),
                            ),
                          ],
                        ),
                        Text(
                          destination == 'Insti' ? 'Institute' : destination,
                          style: const TextStyle(
                              fontSize: 14
                          ),
                        ),
                      ],
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: onTap,
                        child: Ink(
                          height: 35,
                          width: 85,
                          decoration: BoxDecoration(
                            color: sessionStarted ? Colors.green : kBlue,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              sessionStarted ? "Started" : "Start",
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: kWhite
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}