import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  Future<void> signUp({
    required String email,required String password
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    }
    on FirebaseAuthException catch(e){
      String message = "";
      if(e.code=='weak-password'){
        message = "La contraseña es débil";
      }
      else if(e.code=='email-already-in-use'){
        message = "Ya existe una cuenta con ese correo";
      }
      Fluttertoast.showToast(msg: message);
    }
    catch(e){

    }
  }

  Future<bool> signIn({
    required String email,required String password
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    }
    on FirebaseAuthException catch(e){
      String message = "";
      if(e.code=='user-not-found'){
        message = "Usuario no encontrado.";
      }
      else if(e.code=='wrong-password'){
        message = "Contraseña incorrecta.";
      }
      Fluttertoast.showToast(msg:"Error ${e.code}: $message");
      return false;
    }
    catch(e){
      Fluttertoast.showToast(msg: "No se pudo iniciar sesión. Verifique su conexión");
      return false;
    }
    return true;
  }
}
