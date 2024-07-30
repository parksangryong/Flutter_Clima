import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 100.0,
);

const kMessageTextStyle =
    TextStyle(fontFamily: 'Spartan MB', fontSize: 45.0, color: Colors.white);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 120.0,
);

InputDecoration InputDecorationStyle = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  icon: const Icon(Icons.location_city, color: Colors.white),
  hintText: 'Enter City Name',
  hintStyle: const TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
      borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(10)
  )
);
