// update message for buses
import 'package:osm_nominatim/osm_nominatim.dart';

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
                      
Map data © OpenStreetMap Contributors. Retrieved via Nominatim. OSRM instance hosted by Project OSRM, which the project is under a BSD-2-Clause license.
                      
Do note that data could be inaccurate for realtime data. Please check official sources, such as myRapid PULSE for accurate realtime data information.

Icon from Font Awesome. Licensed under a CC BY 4.0 License. See https://creativecommons.org/licenses/by/4.0/ for license.
''';
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
const String confirmBtn = "Confirm";
const String delete = "Delete";
const String from = "from";
const String to = "to";

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
const String osmErrorMsg =
    "Failed to retrieve location. Do note that location can still be viewed via any navigation app with the button at the right.";

String osmMessage(Place reverseSearchResult) {
  return "near ${(reverseSearchResult.address?['road'] != null) ? "${reverseSearchResult.address?['road']}, " : ""}${(reverseSearchResult.address?['suburb'] != null) ? "${reverseSearchResult.address?['suburb']}, " : ""}${(reverseSearchResult.address?['city'] != null) ? "${reverseSearchResult.address?['city']}" : ""}";
}

String stationRemaining(double distance, double duration) {
  return "${distance}m (${duration >= 60.0 ? "${(duration / 60).round()} minutes" : "< 1 minute"}) left to station";
}

// tabs (global)
const String busStatus = "Status";
const String roadStatus = "Traffic";
const String settings = "Settings";
const String arrivals = "Arrivals";

// road status
const String roadStatusText =
    "This is a page for commuters to submit traffic information, so that other commuters can expect if there is any delays on the arrival of a bus.";
const String deleteInfoConfirmationMessage =
    "Are you sure you want to delete this entry? This cannot be undone!";
const String signInPreText = "Want to submit information?";
const String signInWithGoogle = "Sign in with Google";

// submit information wizard
const String selectARoute = "Select a route";
const String confirmRouteSelectionMessage =
    "Please confirm if the selected route is correct.";

// info card
const String accident = "Accident";
const String trafficJam = "Traffic jam";

// submit info wizard
const String addDataSuccess = "Data addition successful";
const String submissionConfirmation = "Confirm submission";
const String route = "Route";
const String stationRange = "Station range";
String totalStations(int length) {
  return "Total $length stations";
}

const String dataConfirmation =
    "Please ensure that the data is accurate. Data will be deleted 2 hours after your submission.";

const String submit = "Submit";
const String selectStationRange = "Select a station range";
const String fromStationDropdown = "From which station?";
const String toStationDropdown = "To which station?";
const String selectType = "Select a type";
const String finalizeBtn = "Finalize submission";

// arrivals page
const String lessThan1Min = "< 1 min";
String getTimeFromDuration(double duration) {
  return "${(duration / 60).toStringAsFixed(0)} min${((duration / 60).toStringAsFixed(0) == 1) ? "" : "s"}";
}

String stopsAway(int stops) {
  return "$stops stop${stops == 1 ? "" : "s"} away";
}

String passed(String licensePlate, double stopsAway) {
  return "$licensePlate has passed from station (${stopsAway.abs().toInt()} stops)";
}

// data card notification message
const String accidentNotificationMessage =
    "User report: Accident happened between roads of this bus. Do expect delays.";
const String trafficJamNotificationMessage =
    "User report: Traffic jam between roads of this bus. Do expect delays.";
const String trafficJamShortenedMessage = "Expect delays: Traffic jam";
const String accidentShortenedMessage = "Expect delays: Traffic accident";
