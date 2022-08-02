import 'package:rxdart/rxdart.dart';

import '../../objects/item.dart';
import '../../repositories/repository.dart';
import '../../utils/db.dart';

class ItemsBloc {
  final BehaviorSubject items = BehaviorSubject.seeded([]);
  final BehaviorSubject selectedItems = BehaviorSubject<List<Item>>();
  final BehaviorSubject<bool> isLoading = BehaviorSubject.seeded(false);
  Stream<ItemsObjectState> stream;
  DB db = DB();

  ItemsBloc(String campaignId) {
    stream = CombineLatestStream(
        [items, isLoading, selectedItems],
        (values) => ItemsObjectState(
              items: values[0],
              isLoading: values[1],
              selectedItems: values[2],
            ));
    updateItems(campaignId);
    updateSelectedItems([]);
  }

  updateItems(String campaignId) async {
    items.add(await Repository.getItems(campaignId));
  }

  updateSelectedItems(List<Item> selectedItems) {
    this.selectedItems.add(selectedItems);
  }

  addToSelectedItems(Item item) {
    List<Item> selectedItems = this.selectedItems.value;
    selectedItems.add(item);
    this.selectedItems.add(selectedItems);
  }

  removeFromSelectedItems(Item item) {
    List<Item> selectedItems = this.selectedItems.value;
    selectedItems.remove(item);
    this.selectedItems.add(selectedItems);
  }

  dispose() {
    items.close();
    isLoading.close();
    selectedItems.close();
  }

  updateIsLoading(bool isLoading) {
    this.isLoading.add(isLoading);
  }

  purchaseItems(String userId, String locationId) async {
    updateIsLoading(true);
    List<Item> selectedItems = this.selectedItems.value;
    String url = await Repository.createPayment(
        userId, locationId, db.getUser(), selectedItems);
    updateIsLoading(false);
    return url;
  }
}

class ItemsObjectState {
  final List<Item> items;
  final List<Item> selectedItems;
  final bool isLoading;

  ItemsObjectState({this.items, this.isLoading, this.selectedItems});
}
