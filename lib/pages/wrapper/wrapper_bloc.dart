import 'package:help_us_web/repositories/repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../objects/campaign.dart';
import '../../objects/location.dart';
import '../../objects/user.dart';

class WrapperBloc {
  BehaviorSubject location = BehaviorSubject();
  BehaviorSubject user = BehaviorSubject();
  BehaviorSubject campaigns = BehaviorSubject();
  Stream<WrapperObjectState> stream;

  WrapperBloc(String locationId, String userId) {
    stream = CombineLatestStream(
        [location, user, campaigns],
        (values) => WrapperObjectState(
            location: values[0], user: values[1], campaigns: values[2]));
    updateLocation(locationId, userId);
    updateUser(userId);
    updateCampaigns(locationId);
  }

  updateLocation(String locationId, String userId) async {
    if (locationId != null) {
      location.add(await Repository.getLocationById(locationId, userId));
      return;
    } else {
      location.addError("no_location_found");
    }
  }

  updateUser(String userId) async {
    if (userId != null) {
      user.add(await Repository.getUserById(userId));
      return;
    } else {
      user.addError("no_user_found");
    }
  }

  updateCampaigns(String userId) async {
    campaigns.add(await Repository.getCampaigns(userId));
  }

  dispose() {
    location.close();
  }
}

class WrapperObjectState {
  final Location location;
  final User user;
  final List<Campaign> campaigns;

  WrapperObjectState({this.location, this.user, this.campaigns});
}
