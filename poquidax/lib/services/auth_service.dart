import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  Future<bool> signUp({
    required String email,required String password
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      return true;
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
      return false;
    }
    catch(e){
      return false;
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
      else if(e.code=='invalid-email'){
        message = "Correo inválido.";
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
