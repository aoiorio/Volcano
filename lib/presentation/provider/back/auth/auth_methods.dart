// TODO create class with Provider and it will give me some methods such as signUp, signIn and signOut
// TODO use FutureProvider for loading page
// I think I don't need to create a class though

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/entity/volcano_user.dart';
import 'package:volcano/presentation/provider/back/auth/auth_providers.dart';
import 'package:volcano/presentation/provider/front/sign_up/sign_up_page_providers.dart';

// final signUpFutureProvider =
//     FutureProvider<Either<AuthError, VolcanoUser>>((ref) async {
//   final result = await ref.watch(authUseCaseProvider).executeSignUp(
//       email: ref.read(emailTextControllerProvider).text,
//       password: ref.read(passwordTextControllerProvider).text,
//       confirmPassword: ref.read(confirmPasswordTextControllerProvider).text);
//   print(result);
//   // await Future.delayed(const Duration(seconds: 2), () {});
//   // これ！！！！！！！
  
//   print('done');
//   return result;
// });
