import 'package:rxdart/rxdart.dart';

class WrapperBloc {
  BehaviorSubject location = BehaviorSubject();

  WrapperBloc(String location) {
    updateLocation(location);
  }

  updateLocation(String location) async {
    if (location != null) {
      this.location.add(location);
      return;
    } else {
      this.location.addError("no_location_found");
    }
  }

  dispose() {
    location.close();
  }
}
