import 'dart:async';
import 'package:logging/logging.dart';

class AdafruitFeed {

  var _feedController = StreamController<String>.broadcast();
  // Expose the stream so a StreamBuilder and use it.
  Stream<String> get sensorStream => _feedController.stream;
//
// TODO: add takes in a string, but forces the feed to be an int
  void add(String value) {
    Logger log = Logger('Adafruit_feed.dart');
    try {
      _feedController.add(value);
      log.info('---> added value to the Stream... the value is: $value');
    } catch (e) {
      log.severe(
          '$value was published to the feed.  Error adding to the Stream: $e');
    }
  }

  void dispose(){
    _feedController.close();
  }
}
