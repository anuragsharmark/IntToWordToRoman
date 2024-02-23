import 'package:flutter/material.dart';
import 'package:int_to_word/NumToWord.dart';

class NumToRom extends StatefulWidget {
  NumToRom({super.key});

  @override
  State<NumToRom> createState() => _NumToRomState();
}

class _NumToRomState extends State<NumToRom> {
  String textWord = "";

  TextEditingController controller = TextEditingController();
// ---------------------------------------------------------------------------

  List<String> one = [
    "",
    "I",
    "II",
    "III",
    "IV",
    "V",
    "VI",
    "VII",
    "VIII",
    "IX"
  ];

  List<String> two = [
    "",
    "X",
    "XX",
    "XXX",
    "XL",
    "L",
    "LX",
    "LXX",
    "LXXX",
    "XC"
  ];

  List<String> three = [
    "",
    "C",
    "CC",
    "CCC",
    "CD",
    "D",
    "DC",
    "DCC",
    "DCCC",
    "CM"
  ];

  List<String> four = ["", "M", "MM", "MMM"];

  String romanConverter(int n) {
    String result = "";

    if (n >= 1000 && n <= 3000) {
      n = (n / 1000).toInt();
      result += four[n];
    } else if (n >= 100 && n <= 900) {
      n = (n / 100).toInt();
      result += three[n];
    } else if (n >= 10 && n <= 90) {
      n = (n / 10).toInt();
      result += two[n];
    } else {
      result += one[n];
    }

    return result;
  }

  String intToRoman(int temp) {
    int num = temp;
    int len = 0;

    // Count the number of digits in 'num'
    while (temp > 0) {
      temp ~/= 10;
      len++;
    }

    List<int> arr = [];

    int count = 0;
    // Extract digits and store them in the array
    for (int i = 0; i < len; i++) {
      int val = num % 10;
      int pow = power(count);
      arr.add(val * pow);
      num ~/= 10;
      count++;
    }

    String ans = "";
    for (int j = len - 1; j >= 0; j--) {
      if (arr[j] > 3999) {
        ans = "Number limit exceed !!";
        break;
      }

      ans += romanConverter(arr[j]);
    }

    return ans;
  }

  int power(int count) {
    if (count == 0) {
      return 1;
    }
    int val = 1;
    for (int i = 0; i < count; i++) {
      val = val * 10;
    }
    return val;
  }

// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Numeric to Roman Converter',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: TextField(
                  onChanged: (value) {
                    int num;
                    (value == "") ? num = 0 : num = int.parse(value);
                    textWord = intToRoman(num);
                    setState(() {});
                  },
                  style: TextStyle(fontSize: 20),
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: controller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.edit_note_rounded),
                    prefixIconColor: Colors.black,
                    hintText: 'Enter Number',
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black38)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 20,
                child: Text(
                  'In Roman',
                  style: TextStyle(color: Colors.black38, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Container(
                  child: Text(
                    textWord,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 60, fontFamily: 'Myfont'),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  onPressed: () {
                    controller.clear();
                    textWord = "";
                    setState(() {});
                  },
                  child: Text(
                    'Clear',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => NumToWord(),
              )),
          child: Icon(
            Icons.swap_horiz,
            size: 34,
          ),
        ),
      ),
    );
  }
}
