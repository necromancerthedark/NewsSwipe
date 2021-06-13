import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class NewsCard extends StatefulWidget {
  String ImgURL;
  String Title;
  String Description;
  String SourceName;
  String URL;

  NewsCard(
      this.Title, this.Description, this.ImgURL, this.SourceName, this.URL);

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("Error!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.grey,
                BlendMode.multiply,
              ),
              fit: BoxFit.cover,
              image: NetworkImage(
                widget.ImgURL,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "NewsSwipe",
                style: GoogleFonts.caveat(fontSize: 35),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  child: FadeInImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(widget.ImgURL, scale: 2),
                    placeholder: AssetImage("assets/placeholder.jpg"),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(15),
                child: Text(
                  widget.Title,
                  style: GoogleFonts.lora(
                      fontSize: 23,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ),
              Divider(
                endIndent: 20.0,
                indent: 20.0,
                color: Colors.white,
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: Text(
                  widget.Description,
                  style: GoogleFonts.inconsolata(
                    fontSize: 20,
                    //fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Spacer(),
              Text(
                "Source: " + widget.SourceName,
                style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    tooltip: "Read in Browser",
                    icon: Icon(
                      Icons.web_stories,
                      size: 30,
                    ),
                    onPressed: () {
                      launchURL(widget.URL);
                    },
                  ),
                  IconButton(
                    tooltip: "Share",
                    icon: Icon(Icons.share_rounded, size: 30),
                    onPressed: () {
                      Share.share(widget.URL);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
