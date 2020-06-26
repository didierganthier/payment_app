import 'package:flutter/material.dart';
import 'package:flutter_rave/flutter_rave.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterWave',
      theme: ThemeData(primaryColor: Colors.orange),
      home: MyHomePage(title: 'FlutterWave'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Builder(
          builder: (context) => SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: InkWell(
                onTap: ()=> _pay(context),
                child: Card(
                  color: Colors.orangeAccent,
                  elevation: 15,
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Card Payment",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.payment,
                            color: Colors.black,
                            size: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _pay(BuildContext context){
    final snackBar_onFailure = SnackBar(content: Text("Transaction failed"));
    final snackBar_onClosed = SnackBar(content: Text("Transaction closed"));
    final _rave = RaveCardPayment(
      isDemo: true,
      encKey: "7fab82b347f5c9714fd377d8",
      publicKey: "FLWPUBK-1bd6903f58e093d7bbdc9d1c38df6078-X",
      transactionRef: "hvHPvKYaRuJLlJWSPWGGKUyaAfWeZKnm",
      amount: 100,
      email: "didierganthierperan@gmail.com",
      onSuccess: (response){
        if(mounted){
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Transaction Sucessful!"),
              backgroundColor: Colors.green,
              duration: Duration(
                seconds: 5,
              ),
            ),
          );
        }
      },
      onFailure: (err) => Scaffold.of(context).showSnackBar(snackBar_onFailure),
      onClosed: () => Scaffold.of(context).showSnackBar(snackBar_onClosed),
      context: context
    );
    _rave.process();
  }
}
