import 'package:rxdart/rxdart.dart';

import '../../objects/campaign.dart';

class CampaignsBloc {
  final BehaviorSubject campaigns = BehaviorSubject<List<Campaign>>();
  final BehaviorSubject isLoading = BehaviorSubject.seeded(false);
  Stream<CampaignsObjectState> stream;

  CampaignsBloc(List<Campaign> campaigns) {
    stream = CombineLatestStream([this.campaigns, isLoading],
        (values) => CampaignsObjectState(campaigns: values[0], isLoading: values[1]));
    updateCampaigns(campaigns);
    updateIsLoading(false);

  }

  void dispose() {
    campaigns.close();
    isLoading.close();
  }

  updateIsLoading(bool isLoading) {
    this.isLoading.sink.add(isLoading);
  }

  updateCampaigns(List<Campaign> campaigns) {
    this.campaigns.sink.add(campaigns);
  }
}

class CampaignsObjectState {
  final List<Campaign> campaigns;
  final bool isLoading;

  CampaignsObjectState({
    this.campaigns,
    this.isLoading,
  });
}
