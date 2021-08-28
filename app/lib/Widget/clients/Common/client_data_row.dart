import 'package:flutter/material.dart';

import 'pill_text.dart';

class ClientDataRow extends StatelessWidget {
  final String property;
  final String value;
  const ClientDataRow({
    required this.property,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 90,
            child: Text(
              this.property,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          (this.property == 'STATUS')
              //Colors.greenAccent.shade700
              ? ((this.value == 'ACTIVE')
                  ? PillText(
                      text: 'ACTIVE',
                      bgColor: Colors.greenAccent.shade700,
                      fgColor: Colors.white,
                    )
                  : PillText(
                      text: this.value,
                      bgColor: Colors.grey,
                      fgColor: Colors.black,
                    ))
              : Text(
                  this.value,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
        ],
      ),
    );
  }
}

class AddressDataRow extends StatelessWidget {
  final String property;
  final String value;
  const AddressDataRow({
    required this.property,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 150,
            child: Text(
              this.property,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          (this.property == 'STATUS')
              //Colors.greenAccent.shade700
              ? ((this.value == 'ACTIVE')
                  ? PillText(
                      text: 'ACTIVE',
                      bgColor: Colors.greenAccent.shade700,
                      fgColor: Colors.white,
                    )
                  : PillText(
                      text: this.value,
                      bgColor: Colors.grey,
                      fgColor: Colors.black,
                    ))
              : Text(
                  this.value,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
        ],
      ),
    );
  }
}
