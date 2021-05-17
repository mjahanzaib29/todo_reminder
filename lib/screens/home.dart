import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_reminder/Util/sharedprefs.dart';
import 'package:todo_reminder/constant/pallete.dart';
import 'package:todo_reminder/constant/string_constant.dart';
import 'package:intl/intl.dart';
import 'package:todo_reminder/main.dart';
import 'package:todo_reminder/model/categoryinfo.dart';
import 'package:todo_reminder/model/networkhandler.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  NetworkHandler networkHandler = NetworkHandler();
  DateTime now = DateTime.now();
  DateTime now1;
  DateTime dateTime;
  String ReminderTime, CurrentTimeForReminder, currentschedule;
  final TextEditingController _currentdatetime = TextEditingController();
  final TextEditingController _note = TextEditingController();
  final TextEditingController _selecteddate = TextEditingController();
  final TextEditingController _selectedtime = TextEditingController();
  final TextEditingController _category = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<Welcome> _categorylist;
    setState(() {
      _categorylist = networkHandler.getcategory();
    });
    Size size = MediaQuery.of(context).size;

    // String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    String currentday = DateFormat('d').format(now);
    String formattedDate =
        DateFormat('kk:mm \n EEE MMM ').format(now); // 02:43 mon dec
    // this is current year:month:day

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
                              FutureBuilder<Welcome>(
                                future: _categorylist,
                                builder: (context, snapshot) {
                              if(snapshot.hasData){
                                return DropdownButton<String>(
                                  items: <String>['A', 'B', 'C', 'D']
                                      .map((String value) {
                                    return new DropdownMenuItem<String>(
                                      value: value,
                                      child: new Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (_) {},
                                );
                              }
                              else{
                                return null;
                              }
                                },
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
                                  "currentDate": _currentdatetime.text,
                                  "work": _note.text,
                                  "reminderTime": ReminderTime,
                                  "categoryId": ""
                                };
                                MySharedPreferences.instance.setStringValue(
                                    "remindertime", ReminderTime);
                                MySharedPreferences.instance
                                    .setStringValue("note", _note.text);
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
        now1 = DateTime.now();
        currentschedule = DateFormat('yyyy-MM-dd').format(now1);
        _currentdatetime.text = currentschedule;
        // CurrentTimeForReminder = DateFormat('yyyy-MM-dd').format(dateTime);
        ReminderTime = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
      });

      print(ReminderTime);
      return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
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
}
