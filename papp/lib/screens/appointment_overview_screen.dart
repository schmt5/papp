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
          builder: (ctx, data, child) => ListView.separated(
            itemCount: data.upcomingItems.length,
            itemBuilder: (ctx, i) => AppointmentItem(
              id: data.upcomingItems[i].id,
              category: data.upcomingItems[i].category,
              dateTime: data.upcomingItems[i].dateTime,
              place: data.upcomingItems[i].place,
              supervisor: data.upcomingItems[i].supervisor,
            ),
            separatorBuilder: (ctx, i) {
              var j = i == (data.upcomingItems.length - 1) ? i : i + 1;
              return (data.upcomingItems[i].dateTime.day == DateTime.now().day &&
                      data.upcomingItems[j].dateTime.day != DateTime.now().day)
                  ? Container(
                      width: double.infinity,
                      height: 5,
                      color: Colors.grey,
                    )
                  : Container();
            },
          ),
        );
      },
    );
  }
}
