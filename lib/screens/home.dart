import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_reminder/constant/pallete.dart';
import 'package:todo_reminder/constant/string_constant.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime now = DateTime.now();
  TimeOfDay timenow = TimeOfDay.now();
  DateTime selectedDate;
  TimeOfDay selectedTime;
  String finaldatewithyear,pickedtime;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (selectedDate != null) {
      finaldatewithyear = DateFormat('dd:MM:yyyy').format(selectedDate);
    }
    if (selectedTime != null){
      pickedtime =selectedTime.format(context);
    }

    // String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    String formattedDate = DateFormat('kk:mm:ss \n EEE MMM').format(now);

    String currentday = DateFormat('d').format(now);
    String currentdateyear = DateFormat('d MMM').format(now);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onPressed: () {}),
        title: Text(
          StringConstants.title,
          style: TextStyle(
              color: Pallete.bgColor,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2),
                  child: Container(
                    height: size.height * .73,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Pallete.bgColor.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RotatedBox(
                                quarterTurns: 3,
                                child: Text(
                                  currentday,
                                  style:
                                      GoogleFonts.dancingScript(fontSize: 45),
                                ),
                              ),
                              Text(
                                formattedDate,
                                style: GoogleFonts.montserrat(fontSize: 20),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.notes),
                              labelStyle: Pallete.khint,
                              labelText: "Remind me for",
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.calendar_today),
                                    labelStyle: Pallete.khint,
                                    labelText: finaldatewithyear == null
                                        ? 'Schedule'
                                        : finaldatewithyear,
                                    // hintText: finaldatewithyear,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () => _selectDate(context),
                                child: Text('PickDate'),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.access_time),
                                    labelStyle: Pallete.khint,
                                    labelText: pickedtime == null
                                        ? 'Time'
                                        : pickedtime,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () => _selectTime(context),
                                child: Text('PickTime'),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.category),
                                      labelStyle: Pallete.khint,
                                      labelText: 'Category'),
                                ),
                              ),
                              DropdownButton<String>(
                                items: <String>['A', 'B', 'C', 'D']
                                    .map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                onChanged: (_) {},
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 15),
                            width: size.width,
                            decoration: new BoxDecoration(
                              border: Border.all(
                                color: Pallete.bgColor,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                            ),
                            child: TextButton(
                              child: new Text(
                                'Add Task',
                                style: Pallete.kbtn2,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(2021),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != now)
      setState(() {
        selectedDate = pickedDate;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
        context: context,
        initialTime: timenow,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (pickedTime != null && pickedTime != timenow)
      setState(() {
        selectedTime = pickedTime;
      });
  }

// Widget buildDatePicker() => Container(
//       height: 180,
//       child: CupertinoDatePicker(
//           maximumYear: DateTime.now().year,
//           minimumYear: 2021,
//           initialDateTime: now,
//           mode: CupertinoDatePickerMode.dateAndTime,
//           onDateTimeChanged: (now) => setState(() {
//                 this.now = now;
//               })),
//     );
}
