import 'package:rxdart/rxdart.dart';

import '../../objects/item.dart';
import '../../repositories/repository.dart';

class ItemsBloc {
  final BehaviorSubject items = BehaviorSubject<List<Item>>();
  final BehaviorSubject<bool> isLoading = BehaviorSubject.seeded(false);
  Stream<ItemsObjectState> stream;
  ItemsBloc(String campaignId) {
    stream = CombineLatestStream(
        [items, isLoading],
        (values) => ItemsObjectState(
              items: values[0],
              isLoading: values[1],
            ));
    updateItems(campaignId);
  }

  updateItems(String campaignId) async {
    items.add(await Repository.getItems(campaignId));
  }

  dispose() {
    items.close();
    isLoading.close();
  }

  updateIsLoading(bool isLoading) {
    this.isLoading.add(isLoading);
  }
}

class ItemsObjectState {
  final List<Item> items;
  final bool isLoading;

  ItemsObjectState({this.items, this.isLoading});
}
