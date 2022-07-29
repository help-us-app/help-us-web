import 'dart:developer';

import 'package:dio/dio.dart';
import '../objects/campaign.dart';
import '../objects/item.dart';
import '../objects/location.dart';
import '../objects/user.dart';

class Repository {
  static Dio dio = Dio();
  static String directusUrl = "https://help-us.directus.app/";
  static String directusToken = "VjL2EY9ju8efp37w8ZUobcrcn99vL4ce";
  static String herokuUrl = "https://help-us-api.herokuapp.com/";
  static String herokuToken = "";

  static getUserById(String userId) async {
    try {
      Response response = await dio.get("${directusUrl}items/User/$userId",
          options:
              Options(headers: {"Authorization": "Bearer $directusToken"}));
      log("getUserById");
      return User.fromJson(response.data["data"]);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<Map<String, dynamic>> getRemoteConfigurations() async {
    try {
      Response response = await dio.get(
          "${directusUrl}items/remote_configurations",
          options:
              Options(headers: {"Authorization": "Bearer $directusToken"}));
      log("getRemoteConfigurations");
      return response.data["data"];
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static getCampaigns(String locationId) async {
    try {
      Response response = await dio.get(
        "${directusUrl}items/Campaign?filter[location_id][_eq]=$locationId",
        options: Options(headers: {"Authorization": "Bearer $directusToken"}),
      );
      List<Campaign> campaigns = [];
      for (var campaign in response.data["data"]) {
        campaigns.add(Campaign.fromJson(campaign));
      }
      log("getCampaigns");
      return campaigns;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static getItems(String campaignId) async {
    try {
      Response response = await dio.get(
        "${directusUrl}items/Item?filter[campaign_id][_eq]=$campaignId",
        options: Options(headers: {"Authorization": "Bearer $directusToken"}),
      );
      List<Item> items = [];
      for (var item in response.data["data"]) {
        items.add(Item(
          id: item["id"].toString(),
          title: item["title"],
          productLink: item["link"],
          productImage: item["thumbnail"],
          price: item["price"],
          purchased: item["purchased"],
        ));
      }
      log("getItems");
      return items;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static getLocationById(String locationId, String userId) async {
    try {
      Response response =
          await dio.get("${herokuUrl}location/$locationId?user_id=$userId");
      log("getLocationById");
      return Location.fromJson(response.data['location']);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static createPayment(String userId, String locationId, String buyerEmail,
      List<Item> lineItems) async {
    try {
      Response response = await dio.post(
        "${herokuUrl}payment",
        data: {
          "user_id": userId,
          "location_id": locationId,
          "buyer_email": buyerEmail,
          "line_items": lineItems.map((item) => item.toJson()).toList(),
        },
      );
      log("createPayment");
      return response.data['payment_link']['url'];
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
