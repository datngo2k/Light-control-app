import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:light_controller_app/Data/Models/Bulb.dart';
import 'package:light_controller_app/Presentation/Screens/Admin/component/manage_bulb.dart';
import 'package:light_controller_app/constant/constant.dart';

class DeviceScreen extends StatelessWidget {

  Future<void> _bulbInfoDialog(BuildContext context, Bulb bulb, String roomId) async {
    return showDialog(
        context: context,
        builder: (_) {
          return BulbManageDialog(
            bulb: bulb,
            roomId: roomId,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        ListTile(
          leading: Icon(Icons.meeting_room),
          title: Text("H2-201", style: kTextStyle),
          tileColor: kBaseColor,
        ),
        SizedBox(height: 20),
        Container(
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 90,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemCount: 4,
              shrinkWrap: true,
              itemBuilder: (BuildContext ctx, deviceIndex) {
                return GestureDetector(
                  onTap: () {
                    _bulbInfoDialog(
                        context,
                        Bulb(id: "den 1", intensity: 10, currentStatus: false),
                        "H2-201");
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(children: [
                      Image.asset(
                        "asset/img/light.png",
                        height: 40,
                      ),
                      Text("Den 1"),
                    ]),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                );
              }),
        )
      ]),
    ));
  }
}
