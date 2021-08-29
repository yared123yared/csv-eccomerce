import 'package:flutter/material.dart';

class FromToDashBoard extends StatefulWidget {
  @override
  State<FromToDashBoard> createState() => _FromToDashBoardState();
}

class _FromToDashBoardState extends State<FromToDashBoard> {
  TextEditingController searchController = TextEditingController();
  bool isFormDate = false;
  bool isToDate = false;
  DateTime dateForm = DateTime.now();

  DateTime dateTo = DateTime.now();

  String dateFromText = "";
  String dateToText = "";

  Future<Null> selectFormTimePicker(BuildContext context) async {
    setState(() {
      isFormDate = true;
    });
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateForm,
      firstDate: DateTime(1940),
      lastDate: DateTime(2030),
    );

    if (picked != null && picked != dateForm) {
      setState(() {
        dateForm = picked;
        dateFromText =
            "${dateForm.day.toString()}-${dateForm.month.toString()}-${dateForm.year.toString()}";
      });

      print(dateFromText);
    }
  }

  Future<Null> selectToTimePicker(BuildContext context) async {
    setState(() {
      isToDate = true;
    });
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateTo,
      firstDate: DateTime(1940),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != dateTo) {
      dateTo = picked;

      setState(() {
        dateToText =
            "${dateTo.day.toString()}-${dateTo.month.toString()}-${dateTo.year.toString()}";

        print(dateToText);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width * 0.40,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(180),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (isFormDate)
                    Text(
                      dateFromText,
                      style: TextStyle(
                        color: Color(0xff414e79),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )
                  else
                    Text(
                      "From",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black45,
                      ),
                    ),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        selectFormTimePicker(context);
                      });
                    },
                    icon: Image.asset(
                      'assets/images/date.png',
                      width: 25,
                      height: 25,
                    ),
                    label: Text(
                      '',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width * 0.40,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(180),
            ),
            //
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isToDate
                      ? Text(
                          dateToText,
                          style: TextStyle(
                            color: Color(0xff414e79),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        )
                      : Text(
                          "To",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black45,
                          ),
                        ),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        selectToTimePicker(context);
                      });
                    },
                    icon: Image.asset(
                      'assets/images/date.png',
                      width: 30,
                      height: 30,
                    ),
                    label: Text(
                      '',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
