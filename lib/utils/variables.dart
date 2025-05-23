// update message for buses
const String busSearchStart = "Searching for buses...";
String busUpdated(int count) {
  return "Found ${count.toString()} bus${count > 1 ? "es" : ""} in this route";
}

// settings
const String resetDataMessage =
    "Resets bus? to its first-run state. If you want to change provider, please use this option for changing.";
const String resetDataConfirmationMessage =
    "Are you sure you want to reset bus? to its original state?";
const String resetData = "Reset data";
const String licenseText = '''
bus? 1.0

Static and realtime data for rapidPenang, rapidKL and rapidPahang buses sourced from Prasarana's GTFS endpoints via data.gov.my which is used under CC BY 4.0.
                      
Map data © OpenStreetMap Contributors. Retrieved via Nominatim.
                      
Do note that data could be inaccurate for realtime data. Please check official sources, such as myRapid PULSE for accurate realtime data information.''';
const String legalText = '''
Copyright 2025 Tan (weareblahs)
                      
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
                      
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
                      
THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
                      ''';
const String showLicensesBtn = 'Show Licenses';
// global
const String yes = "Yes";
const String no = "No";
const String confirm = "Confirm Selection";
const String cancel = "Cancel";

// landing screen
const String welcome = "Welcome to bus?";
const String landingWelcomeMsg = "To start, select a bus provider below.";
String selected(String providerName) {
  return "You selected $providerName. When you press Yes, it will show $providerName buses by default when you start the app. You can change it at the Settings tab. The app will restart. Do you want to continue?";
}

// home / data card
const String dataRefreshSnackbar = "Possible new data found! Refreshing...";
const String dataUnavailableHeader = "Realtime data unavailable.";
const String dataUnavailableText = "Please select another route and try again.";
