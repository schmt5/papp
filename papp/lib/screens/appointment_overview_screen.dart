import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/appointments.dart';
import '../widgets/appointment_item.dart';

class AppointmentOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Appointments>(context, listen: false)
          .fetchAndSetAppointments(),
      builder: (ctx, snapshot) {
        return Consumer<Appointments>(
          builder: (ctx, data, child) => data.upcomingItems.length == 0
              ? Column(
                  children: <Widget>[
                    SizedBox(
                      height: 120,
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Icon(
                            Icons.event_busy,
                            size: 72,
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          'Keine Termine',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 36,
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            'Drücke auf das',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          '+',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            'um einen neuen Termin zu erfassen',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : ListView.separated(
                  itemCount: data.upcomingItems.length,
                  itemBuilder: (ctx, i) =>
                      AppointmentItem(data.upcomingItems[i]),
                  separatorBuilder: (ctx, i) {
                    var j = i == (data.upcomingItems.length - 1) ? i : i + 1;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: (data.upcomingItems[i].dateTime.day ==
                                  DateTime.now().day &&
                              data.upcomingItems[j].dateTime.day !=
                                  DateTime.now().day)
                          ? Container(
                              width: double.infinity,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Center(
                                child: Text(
                                  'Nicht mehr heute',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    );
                  },
                ),
        );
      },
    );
  }
}
