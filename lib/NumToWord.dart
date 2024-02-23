import 'package:flutter/material.dart';
import 'package:int_to_word/NumToRom.dart';

class NumToWord extends StatefulWidget {
  NumToWord({super.key});

  @override
  State<NumToWord> createState() => _NumToWordState();
}

class _NumToWordState extends State<NumToWord> {
  String textWord = "";

  TextEditingController controller = TextEditingController();
// ---------------------------------------------------------------------------

  List<String> ones = [
    "",
    "one ",
    "two ",
    "three ",
    "four ",
    "five ",
    "six ",
    "seven ",
    "eight ",
    "nine ",
    "ten ",
    "eleven ",
    "twelve ",
    "thirteen ",
    "fourteen ",
    "fifteen ",
    "sixteen ",
    "seventeen ",
    "eighteen ",
    "nineteen "
  ];

  List<String> tens = [
    "",
    "",
    "twenty ",
    "thirty ",
    "fourty ",
    "fifty ",
    "sixty ",
    "seventy ",
    "eighty ",
    "ninty "
  ];

  String ConvertToWord(int n, String s) {
    String ans = "";
    if (n < 20) {
      ans += ones[n];
    } else {
      ans += tens[(n / 10).toInt()] + ones[n % 10];
    }
    if (n != 0) ans += s;
    return ans;
  }

  bool exe = false;

  String IntToWord(int n) {
    if (n > 999999999) {
      exe = true;
      return 'Number limit exceed !!';
    }
    if (n < 999999999) {
      exe = false;
    }
    String result = "";
    result += ConvertToWord((n / 10000000).toInt(), "crore ");
    result += ConvertToWord((n / 100000).toInt() % 100, "lakh ");
    result += ConvertToWord((n / 1000).toInt() % 100, "thousand ");
    result += ConvertToWord((n / 100).toInt() % 10, "hundred ");
    if (n > 100 && (n % 100 != 0)) {
      result += "and ";
    }
    result += ConvertToWord(n % 100, "");
    return result;
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
            'Sharma\'s Pay',
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
                    (value == '') ? num = 0 : num = int.parse(value);
                    textWord = IntToWord(num);
                    setState(() {});
                  },
                  style: TextStyle(fontSize: 20),
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: controller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.currency_rupee),
                    prefixIconColor: Colors.black,
                    hintText: 'Enter Amount',
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black38)),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
                child: Text(
                  'In Word',
                  style: TextStyle(color: Colors.black38, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Container(
                  child: Text(
                    textWord,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
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
                    exe ? 'Clear' : 'PAY',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  )),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => NumToRom(),
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
