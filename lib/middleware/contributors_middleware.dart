import 'package:fogosmobile/actions/contributors_actions.dart';
import 'package:fogosmobile/models/contributor.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fogosmobile/models/app_state.dart';
import 'package:fogosmobile/constants/endpoints.dart';

List<Middleware<AppState>> contributorsMiddleware() {
  final loadContributors = _createLoadContributors();

  return [
    TypedMiddleware<AppState, LoadContributorsAction>(loadContributors),
  ];
}

/// Get list of contributors
Middleware<AppState> _createLoadContributors() {
  return (Store store, action, NextDispatcher next) async {
    next(action);

    try {
      String url = Endpoints.getMobileContributors;
      final response = await http.get(url);
      final responseData = json.decode(response.body);
      List<Contributor> contributors = Contributor.fromList(responseData);
      print("load contributors");
      store.dispatch(new ContributorsLoadedAction(contributors));
    } catch (e) {
      print(e);
      print(e.stackTrace);
      store.dispatch(new ContributorsLoadedAction([]));
    }
  };
}
