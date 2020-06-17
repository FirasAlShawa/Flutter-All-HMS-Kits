import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hmsallkitsflutter/app/ui/widgets/header.dart';
import 'package:huawei_site/model/coordinate.dart';
import 'package:huawei_site/model/detail_search_request.dart';
import 'package:huawei_site/model/detail_search_response.dart';
import 'package:huawei_site/model/nearby_search_request.dart';
import 'package:huawei_site/model/nearby_search_response.dart';
import 'package:huawei_site/model/query_suggestion_request.dart';
import 'package:huawei_site/model/query_suggestion_response.dart';
import 'package:huawei_site/model/text_search_request.dart';
import 'package:huawei_site/model/text_search_response.dart';
import 'package:huawei_site/search_service.dart';

class SitePage extends StatelessWidget {
  SitePage();

  @override
  Widget build(BuildContext context) {
    return SitePageStateful(
      title: "HMS Site Kit",
    );
  }
}

class SitePageStateful extends StatefulWidget {
  SitePageStateful({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SitePageState createState() => _SitePageState();
}

class _SitePageState extends State<SitePageStateful> {
  final myController = TextEditingController();
  SearchService searchService = new SearchService();
  String _logs = " ";

  @override
  void initState() {}

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  Widget generateButton(String title, String searchType) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        child: new Text(
          title,
        ),
        onPressed: () => {
          if (searchType == 'text_search')
            {_textSearch()}
          else if (searchType == 'place_detail')
            {_placeDetail()}
          else if (searchType == 'query_suggestion')
            {_querySuggestion()}
          else if (searchType == 'nearby_search')
            {_nearByPlaces()}
        },
        color: Color.fromRGBO(35, 151, 239, 1),
        textColor: Color.fromRGBO(255, 255, 255, 1),
      ),
    );
  }

  void showD() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // Retrieve the text the user has entered by using the
          // TextEditingController.
          content: Text(myController.text),
        );
      },
    );
  }

  void _textSearch() async {
    TextSearchRequest request = new TextSearchRequest();
    request.query = myController.text;
//    request.location = Coordinate(lat: 48.893478, lng: 2.334595);
    request.language = "en";
    request.countryCode = "SA";
    request.pageIndex = 1;
    request.pageSize = 5;
    request.radius = 5000;

    // Create TextSearchResponse object.
    // Call textSearch() method.
    // Assing the results.
    TextSearchResponse response = await searchService.textSearch(request);
    if (response != null) {
      setState(() {
        _logs = _logs + response.toJson() + "\n";
      });
    }
  }

  void _placeDetail() async {
    // Declare a SearchService object and instantiate it.
    SearchService searchService = new SearchService();

    // Create NearbySearchRequest and its body.
    DetailSearchRequest request = DetailSearchRequest();
    request.siteId = "977B75943A9F01D561FF2073AE1D9353";
    request.language = "en";

    DetailSearchResponse response = await searchService.detailSearch(request);
    if (response != null) {
      setState(() {
        _logs = _logs + response.toJson() + "\n";
      });
    }
  }

  void _querySuggestion() async {
    // Declare a SearchService object and instantiate it.
    SearchService searchService = new SearchService();

    // Create NearbySearchRequest and its body.
    QuerySuggestionRequest request = QuerySuggestionRequest();
    request.query = myController.text;
//    request.location = Coordinate(
//        lat: 48.893478,
//        lng: 2.334595
//    );
    request.language = "en";
    request.countryCode = "SA";
    request.radius = 5000;

    // Create QuerySuggestionResponse object.
    // Call querySuggestion() method.
    // Assing the results.
    QuerySuggestionResponse response =
        await searchService.querySuggestion(request);
    if (response != null) {
      setState(() {
        _logs = _logs + response.toJson() + "\n";
      });
    }
  }

  void _nearByPlaces() async {
    // Declare a SearchService object and instantiate it.
    SearchService searchService = new SearchService();

    // Create NearbySearchRequest and its body.
    NearbySearchRequest request = NearbySearchRequest();
    request.query = myController.text;
    request.location = Coordinate(lat: 48.893478, lng: 2.334595);
    request.language = "en";
    request.pageIndex = 1;
    request.pageSize = 5;
    request.radius = 5000;

    // Create NearbySearchResponse object.
    // Call nearbySearch() method.
    // Assing the results.
    NearbySearchResponse response = await searchService.nearbySearch(request);
    if (response != null) {
      setState(() {
        _logs = _logs + response.toJson() + "\n";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:
      SingleChildScrollView(
        child:
        new Column(
          children: <Widget>[
            HeaderWidget(
              title: "HMS Site Kit",
            ),
            new Container(
                padding: EdgeInsets.all(20),
                child: new Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Input Search Term'),
                      controller: myController,
                    ),
                    generateButton("Text Search", "text_search"),
                    generateButton("Place Detail", "place_detail"),
                    generateButton("Query Suggestion", "query_suggestion"),
                    generateButton("NearBy Search", "nearby_search"),
                    Text(
                      "Logs:",
                      style: Theme.of(context).textTheme.headline5,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      _logs,
                    )
                  ],
                )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            _logs = "";
          });
        },
        icon: Icon(Icons.restore),
        label: Text("Clear Log"),
        backgroundColor: Colors.red,
      ),
    );
  }
}
