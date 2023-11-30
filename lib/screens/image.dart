import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;

void main() {
  runApp(Imagescreen());
}

class Imagescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Amazon Image Viewer'),
        ),
        body: ImageFromAmazonUrlWidget(),
      ),
    );
  }
}

class ImageFromAmazonUrlWidget extends StatefulWidget {
  @override
  _ImageFromAmazonUrlWidgetState createState() =>
      _ImageFromAmazonUrlWidgetState();
}

class _ImageFromAmazonUrlWidgetState extends State<ImageFromAmazonUrlWidget> {
  TextEditingController _urlController = TextEditingController();
  Future<String?>? _imageUrlFuture;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _urlController,
            decoration: InputDecoration(
              labelText: 'Enter Amazon Product URL',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _imageUrlFuture = getImageUrlFromAmazon(_urlController.text);
            });
          },
          child: Text('Load Image'),
        ),
        SizedBox(height: 20),
        FutureBuilder<String?>(
          future: _imageUrlFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return Image.network(
                snapshot.data!,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              );
            } else {
              return Container(); // Placeholder when no image is loaded yet
            }
          },
        ),
      ],
    );
  }
}

Future<String?> getImageUrlFromAmazon(String productUrl) async {
  try {
    final response = await http.get(Uri.parse(productUrl));

    if (response.statusCode == 200) {
      final document = htmlParser.parse(response.body);

      // This is a simplified example. You should inspect the actual HTML structure of the Amazon page
      // and update this code accordingly.
      final imageElement = document.querySelector('#imageBlock img');

      if (imageElement != null) {
        return imageElement.attributes['src'];
      }
    }
  } catch (e) {
    print('Error fetching image: $e');
  }

  return null;
}
