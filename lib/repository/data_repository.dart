import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:votely/model/choice_model.dart';

import 'auth_repository.dart';

class DataRepository {
  static const choicesKey = "choices";
  static final DataRepository _instance = DataRepository.intenal();
  factory DataRepository() => _instance;
  DataRepository.intenal();
  final Firestore firestore = Firestore.instance;
  CollectionReference get choiceCollection => firestore.collection(choicesKey);

  Stream<List<ChoiceModel>> choices() {
    return choiceCollection.snapshots().map(snapshotToList);
  }

  Future<void> voteForChoice(String id) async {
    String userId = await AuthRepository().getUserId();
    var document = await choiceCollection.document(id).get();
    var choice = ChoiceModel.fromMap(document.data, id);
    if (!choice.uid.contains(userId)) {
      choice.uid.add(userId);
    } else {
      choice.uid.remove(userId);
    }
    return choiceCollection.document(id).updateData(choice.toMap());
  }

  List<ChoiceModel> snapshotToList(snapshot) {
    return snapshot.documents
        .map<ChoiceModel>((DocumentSnapshot document) =>
            ChoiceModel.fromMap(document.data, document.documentID))
        .toList();
  }
}
