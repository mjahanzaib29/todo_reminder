import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_reminder/Util/sharedprefs.dart';
import 'package:todo_reminder/constant/pallete.dart';
import 'package:todo_reminder/constant/string_constant.dart';
import 'package:intl/intl.dart';
import 'package:todo_reminder/main.dart';
import 'package:todo_reminder/model/networkhandler.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  NetworkHandler networkHandler = NetworkHandler();
  DateTime now = DateTime.now();
  DateTime dateTime;
  String ReminderTime, CurrentTimeForReminder;
  final TextEditingController _currentdatetime = TextEditingController();
  final TextEditingController _note = TextEditingController();
  final TextEditingController _selecteddate = TextEditingController();
  final TextEditingController _selectedtime = TextEditingController();
  final TextEditingController _category = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    String currentday = DateFormat('d').format(now);
    String formattedDate =
        DateFormat('kk:mm \n EEE MMM ').format(now); // 02:43 mon dec

    String currentschedule = DateFormat('dd:MM:yyyy').format(now);
    _currentdatetime.text = currentschedule;

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
                            controller: _note,
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
                                  controller: _selecteddate,
                                  enabled: false,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.calendar_today),
                                    labelStyle: Pallete.khint,
                                    labelText: getDateTime(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () => pickDateTime(context),
                                  child: Text('PickDateTime'),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _category,
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
                              onPressed: () async {
                                Map<String, String> Taskdata = {
                                  "currentDate": CurrentTimeForReminder,
                                  "work": _note.text,
                                  "reminderTime": ReminderTime,
                                  "categoryId": "38"
                                };
                                scheduleAlarm();
                                print(Taskdata);
                                await networkHandler.insertTasks(Taskdata);
                              },
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

  String getDateTime() {
    if (dateTime == null) {
      return 'Schedule ';
    } else {
      setState(() {
        CurrentTimeForReminder = DateFormat('yyyy-MM-dd').format(dateTime);
        ReminderTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
      });

      MySharedPreferences.instance.setStringValue("remindertime", ReminderTime);
      print(ReminderTime + CurrentTimeForReminder);
      return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
    }
  }

  Future pickDateTime(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null) return;

    final time = await pickTime(context);
    if (time == null) return;

    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<DateTime> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: dateTime ?? initialDate,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return null;

    return newDate;
  }

  Future<TimeOfDay> pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: dateTime != null
          ? TimeOfDay(hour: dateTime.hour, minute: dateTime.minute)
          : initialTime,
    );

    if (newTime == null) return null;

    return newTime;
  }

// Future pickDateTime(BuildContext context) async {
//   final date = await selectDate(context);
//   if (date == null) return;
//   final time = await selectTime(context);
//   if (time == null) return;
//   setState(() {
//     datetime = DateTime(
//         date.year, date.month, date.day, time.hour, time.minute, time.second);
//   });
// }
//
// Future<DateTime> selectDate(BuildContext context) async {
//   final DateTime pickedDate = await showDatePicker(
//       context: context,
//       initialDate: now,
//       firstDate: DateTime(2021),
//       lastDate: DateTime(2050));
//   if (pickedDate != null && pickedDate != now)
//     setState(() {
//       selectedDate = pickedDate;
//       return pickedDate;
//     });
//   return null;
// }
//
// Future<DateTime> selectTime(BuildContext context) async {
//   final TimeOfDay pickedTime = await showTimePicker(
//     context: context,
//     initialTime: datetime != null
//         ? TimeOfDay(hour: datetime.hour, minute: datetime.minute)
//         : pickedtime,
//   );
//
//   if (pickedTime != null && pickedTime != timenow)
//     setState(() {
//       selectedTime = pickedTime;
//       return pickedTime;
//     });
//   return null;
// }
}
