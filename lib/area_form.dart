import 'package:flutter/material.dart';

class AddForm extends StatefulWidget {
  final String areaName;
  final String latitude1;
  final String longitude1;
  final String latitude2;
  final String longitude2;
  final String latitude3;
  final String longitude3;
  final String latitude4;
  final String longitude4;
  final String status;

  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedLatitude1;
  final ValueChanged<String> onChangedLongitude1;
  final ValueChanged<String> onChangedLatitude2;
  final ValueChanged<String> onChangedLongitude2;
  final ValueChanged<String> onChangedLatitude3;
  final ValueChanged<String> onChangedLongitude3;
  final ValueChanged<String> onChangedLatitude4;
  final ValueChanged<String> onChangedLongitude4;
  final ValueChanged<String> onChangedStatus;

  final VoidCallback onSavedArea;

  const AddForm({
    Key? key,
    this.status = '',
    this.areaName = '',
    this.latitude1 = '',
    this.longitude1 = '',
    this.latitude2 = '',
    this.longitude2 = '',
    this.latitude3 = '',
    this.longitude3 = '',
    this.latitude4 = '',
    this.longitude4 = '',
    required this.onChangedTitle,
    required this.onChangedLatitude1,
    required this.onChangedLongitude1,
    required this.onChangedLatitude2,
    required this.onChangedLongitude2,
    required this.onChangedLatitude3,
    required this.onChangedLongitude3,
    required this.onChangedLatitude4,
    required this.onChangedLongitude4,
    required this.onChangedStatus,
    required this.onSavedArea,
  }) : super(key: key);

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  @override
  //Area Name' i build etme yeri
  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: widget.areaName,
        onChanged: widget.onChangedTitle,
        validator: (areaName) {
          if (areaName!.isEmpty) {
            return 'The Area Name cannot be empty';
          }
          return null;
        }, //doldurulduğundan emin olmak için
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Area Name',
        ),
      );

  Widget buildLatLon1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 110,
          child: TextFormField(
            initialValue: widget.latitude1,
            onChanged: widget.onChangedLatitude1,
            decoration: InputDecoration(
              labelText: 'Latitude - 1',
              border: UnderlineInputBorder(),
            ),
          ),
        ),
        Container(
          width: 110,
          child: TextFormField(
            initialValue: widget.longitude1,
            onChanged: widget.onChangedLongitude1,
            decoration: InputDecoration(
              labelText: 'Longitude - 1',
              border: UnderlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLatLon2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 110,
          child: TextFormField(
            initialValue: widget.latitude2,
            onChanged: widget.onChangedLatitude2,
            decoration: InputDecoration(
              labelText: 'Latitude - 2',
              border: UnderlineInputBorder(),
            ),
          ),
        ),
        Container(
          width: 110,
          child: TextFormField(
            initialValue: widget.longitude2,
            onChanged: widget.onChangedLongitude2,
            decoration: InputDecoration(
              labelText: 'Longitude - 2',
              border: UnderlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLatLon3() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 110,
          child: TextFormField(
            initialValue: widget.latitude3,
            onChanged: widget.onChangedLatitude3,
            decoration: InputDecoration(
              labelText: 'Latitude - 3',
              border: UnderlineInputBorder(),
            ),
          ),
        ),
        Container(
          width: 110,
          child: TextFormField(
            initialValue: widget.longitude3,
            onChanged: widget.onChangedLongitude3,
            decoration: InputDecoration(
              labelText: 'Longitude - 3',
              border: UnderlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLatLon4() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 110,
          child: TextFormField(
            initialValue: widget.latitude4,
            onChanged: widget.onChangedLatitude4,
            decoration: InputDecoration(
              labelText: 'Latitude - 4',
              border: UnderlineInputBorder(),
            ),
          ),
        ),
        Container(
          width: 110,
          child: TextFormField(
            initialValue: widget.longitude4,
            onChanged: widget.onChangedLongitude4,
            decoration: InputDecoration(
              labelText: 'Longitude - 4',
              border: UnderlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  String dropdownValue = 'None Selected';
  Widget buildStatus1(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: DropdownButton<String>(
        value: dropdownValue,
        isExpanded: true,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
            widget.onChangedStatus(dropdownValue);
          });
        },
        items: <String>[
          'None Selected',
          'Fuel Field',
          'Working Zone',
          'No Entry Zone'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget buildButton() => ElevatedButton(
        onPressed: widget.onSavedArea,
        child: Text('Save Area'),
      );

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          buildTitle(),
          SizedBox(
            height: 8,
          ),
          buildLatLon1(),
          buildLatLon2(),
          buildLatLon3(),
          buildLatLon4(),
          buildStatus1(context),
          SizedBox(height: 30),
          buildButton(),
        ],
      ),
    );
  }
}
