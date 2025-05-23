import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            // settings
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [],
              ),
            ),
            // license
            Text(
              '''
bus? 1.0

Static and realtime data for rapidPenang, rapidKL and rapidPahang buses sourced from Prasarana's GTFS endpoints via data.gov.my which is used under CC BY 4.0.
                      
Map data © OpenStreetMap Contributors. Retrieved via Nominatim.
                      
Do note that data could be inaccurate for realtime data. Please check official sources, such as myRapid PULSE for accurate realtime data information.''',
              textAlign: TextAlign.center,
            ),
            Center(
              child: ElevatedButton(
                child: Text('Show Licenses'),
                onPressed:
                    () => showDialog(
                      context: context,
                      builder:
                          (BuildContext context) => AboutDialog(
                            applicationLegalese: '''
Copyright 2025 Tan (weareblahs)
                      
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
                      
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
                      
THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
                      ''',
                            applicationName: 'bus?',
                            applicationVersion: '1.0',
                          ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
