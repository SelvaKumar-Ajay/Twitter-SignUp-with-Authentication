import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
// import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/models/user_model.dart';

final userApiProvider = Provider(
  (ref) {
    return UserApi(db: ref.watch(appWriteDataBaseProvider));
  },
);

abstract class IUserAPI {
  FutureEitherVoid saveUserData(UserModel userModel);
}

class UserApi implements IUserAPI {
  final Databases _db;
  UserApi({required Databases db}) : _db = db;

  @override
  FutureEitherVoid saveUserData(UserModel userModel) async {
    try {
      await _db.createDocument(
          databaseId: AppWriteConstants.dataBaseId,
          collectionId: AppWriteConstants.collectionId,
          documentId: ID.unique(),
          data: userModel.toMap());
      return right(null);
    } on AppwriteException catch (e, stackTrcae) {
      return left(Failure(
          e.message ?? "Some Unexpected error has Occured", stackTrcae));
    } catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }
}
