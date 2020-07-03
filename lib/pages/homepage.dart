import 'dart:convert';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'file:///E:/Downloads/covid_19/lib/pages/countryPage.dart';
import 'package:http/http.dart' as http;
import 'indiaPage.dart';
import 'package:pie_chart/pie_chart.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, double> data = new Map();
  bool _loadChart = false;
  Map worldData;
  fetchWorldWideData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  List countryData;
  fetchCountryData() async {
    http.Response response =
    await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      countryData = json.decode(response.body);
    });
  }


  Future fetchData() async{
    fetchWorldWideData();
    fetchCountryData();
    print('fetchData called');
  }

  @override
  void initState() {
    fetchData();

    super.initState();
  }
  List<Color> _colors = [
    Colors.red[500],
    Colors.blue[500],
    Colors.green[500],
    Colors.black54,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Theme.of(context).brightness==Brightness.light?Icons.lightbulb_outline:Icons.highlight), onPressed: (){
            DynamicTheme.of(context).setBrightness(Theme.of(context).brightness==Brightness.light?Brightness.dark:Brightness.light);
          })
        ],

        centerTitle: false,
        title: Text(
          'COVID-19 ',
        ),
      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  margin: EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  elevation: 10.0,
                  child: Container(
                    height: 230.0,
                    padding: EdgeInsets.all(8.0),
                    color: Colors.green[100],
                    child: PieChart(
                      dataMap: ({
                        'Confirmed': 10809998,
                        'Active': 4258567,
                        'Recovered':6032301,
                        'Deaths':519050
                      }),
                      colorList:
                      _colors, // if not declared, random colors will be chosen
                      animationDuration: Duration(milliseconds: 800),
                      chartLegendSpacing: 50.0,
                      chartRadius: MediaQuery.of(context).size.width / 3, //determines the size of the chart
                      showChartValuesInPercentage: true,
                      showChartValues: false,
                      showChartValuesOutside: false,
                      chartValueBackgroundColor: Colors.grey[200],
                      showLegends: true,
                      legendPosition:
                      LegendPosition.right, //can be changed to top, left, bottom
                      decimalPlaces: 0,
                      showChartValueLabel: false,
                      initialAngle: 143,
                      chartValueStyle: defaultChartValueStyle.copyWith(
                        color: Colors.grey[200].withOpacity(0.1),
                      ),
                      chartType: ChartType.ring, //can be changed to ChartType.ring
                    ),
                  ),
                ) ,
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          width:MediaQuery.of(context).size.width * 0.45,
                          height: 50.0,

                          child: new RaisedButton(
                            color: Colors.orange[400],
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => CountryPage())
                              );
                            },
                            child: Text(
                              'Global',style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          width:MediaQuery.of(context).size.width * 0.45,
                          height: 50.0,

                          child: new RaisedButton(
                            color: Colors.orange[400],
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => indPage())
                              );
                            },
                            child: Text(
                              'India',style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                worldData == null
                    ? Center(child: CircularProgressIndicator())
                    : WorldwidePanel(
                  worldData: worldData,
                ),

              ],
            )),

      ),

    );
  }
}
class WorldwidePanel extends StatelessWidget {
  final Map worldData;

  const WorldwidePanel({Key key, this.worldData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:8.0),
      child:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          color: Colors.white70,
          elevation: 5.0,
          child:Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top:16.0,bottom: 8.0),
                child: Text(
                  'Worldwide',style: TextStyle(fontSize: 20.0,
                    fontWeight: FontWeight.bold),
                ),
              ),
              GridView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 2),
                children: <Widget>[
                  StatusPanel(
                    title: 'CONFIRMED',
                    panelColor: Colors.red[100],
                    textColor: Colors.red,
                    count: worldData['cases'].toString(),
                  ),
                  StatusPanel(
                    title: 'ACTIVE',
                    panelColor: Colors.blue[100],
                    textColor: Colors.blue[900],
                    count: worldData['active'].toString(),
                  ),
                  StatusPanel(
                    title: 'RECOVERED',
                    panelColor: Colors.green[100],
                    textColor: Colors.green,
                    count: worldData['recovered'].toString(),
                  ),
                  StatusPanel(
                    title: 'DEATHS',
                    panelColor: Colors.grey[500],
                    textColor: Colors.grey[900],
                    count: worldData['deaths'].toString(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatusPanel extends StatelessWidget {
  final Color panelColor;
  final Color textColor;
  final String title;
  final String count;

  const StatusPanel(
      {Key key, this.panelColor, this.textColor, this.title, this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.all(10),
      height: 80,
      width: width / 2,
      color: panelColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
          ),
          Text(
            count,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
          )
        ],
      ),
    );
  }
}
