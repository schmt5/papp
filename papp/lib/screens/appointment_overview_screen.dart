import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/appointments.dart';
import '../widgets/appointment_item.dart';

class AppointmentOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Appointments>(
      builder: (ctx, data, child) => ListView.separated(
        itemCount: data.items.length,
        itemBuilder: (ctx, i) => AppointmentItem(
          id: data.items[i].id,
          category: data.items[i].category,
          dateTime: data.items[i].dateTime,
          place: data.items[i].place,
          supervisor: data.items[i].supervisor,
        ),
        separatorBuilder: (ctx, i) {
          var j = i == (data.items.length - 1) ? i : i + 1;
          return (data.items[i].dateTime.day == DateTime.now().day &&
                  data.items[j].dateTime.day != DateTime.now().day)
              ? Container(
                  width: double.infinity,
                  height: 5,
                  color: Colors.grey,
                )
              : Container();
        },
      ),
    );
  }
}
