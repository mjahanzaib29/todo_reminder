import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_reminder/constant/pallete.dart';
import 'package:todo_reminder/constant/string_constant.dart';
import 'package:intl/intl.dart';
import 'package:todo_reminder/model/networkhandler.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  NetworkHandler networkHandler = NetworkHandler();
  DateTime now = DateTime.now();
  TimeOfDay timenow = TimeOfDay.now();
  DateTime selectedDate,datetime;
  TimeOfDay selectedTime;
  String finaldatewithyear, pickedtime;
  final TextEditingController _currentdatetime = TextEditingController();
  final TextEditingController _note = TextEditingController();
  final TextEditingController _selecteddate = TextEditingController();
  final TextEditingController _selectedtime = TextEditingController();
  final TextEditingController _category = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;



    if (selectedDate != null) {
      finaldatewithyear = DateFormat('yyyy:MM:dd').format(selectedDate);
    }
    if (selectedTime != null) {
      // pickedtime = selectedTime.format(context);
      pickedtime = DateFormat('HH:mm').formatDuration();
      // pickedtime = "${selectedTime.hour}:${selectedTime.minute.remainder(60)}";
      String _printDuration(Duration duration) {
        String twoDigits(int n) => n.toString().padLeft(2, "0");
        String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
        String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
        return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
      }

    }

    // String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    String formattedDate = DateFormat('kk:mm \n EEE MMM').format(now);
    String currentschedule = DateFormat('dd:MM:yyyy').format(now);
    _currentdatetime.text = currentschedule;

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
                                  controller: _selectedtime,
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
                                  "currentDate": _selecteddate.text,
                                  "work": _note.text,
                                  "reminderTime": _selectedtime.text,
                                  "categoryId": "38"
                                };
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

  Future pickDateTime(BuildContext context) async{
    final date = await _selectDate(context);
    if(date == null )return;
    final time = await _selectTime(context);
    if(time == null )return;
    setState(() {
      datetime =DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
        time.second
      );
    });
  }
  Future<DateTime> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(2021),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != now)
      setState(() {
        selectedDate = pickedDate;
        return pickedDate;
      });
  }

  Future<DateTime> _selectTime(BuildContext context) async {
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
