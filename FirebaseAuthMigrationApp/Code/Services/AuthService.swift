import Foundation
import Firebase

/** Firebase Auth
 
 1. User is not sign in:
 - UUID is null
 
 2. User signs in anonymously
 - An anonymous user with unique UUID is given upon sign in. After sign out user record remains (default).
 - A diferent anonymous user with different UUID will be asigned after sign out.
 
 3. User signs in with Email
 - The first time createUser method is used to login a user.
 - Atempting to create a user twice will throw an error.
 - The second time and after, signIn method is used instead.
 - Atempting to sign in a user without creating it first will throw an error.
 
 
 */

enum Result<T> {
    case success(result: T)
    case error(error: Error)
}

struct AuthService {
    func isSignIn(completion: (Bool)->()) {
        completion(Auth.auth().currentUser?.uid != nil)
    }
    
    func signInAnonymously(completion: @escaping (Result<AuthDataResult>)->()) {
        Auth.auth().signInAnonymously { result, error in
            guard error == nil, let result = result else {
                    return completion(Result.error(error: error!))
            }
            completion(Result.success(result: result))
        }
    }
    
    func createUserWithEmail(completion: @escaping (Result<AuthDataResult>)->()) {
        Auth.auth().createUser(withEmail: "test@cchan.tv", password: "123qweASD") { result, error in
            guard error == nil, let result = result else {
                return completion(Result.error(error: error!))
            }
            completion(Result.success(result: result))
        }
    }
    
    func signInWithEmail(completion: @escaping (Result<AuthDataResult>)->()) {
        Auth.auth().signIn(withEmail: "test@cchan.tv", password: "123qweASD") { result, error in
            guard error == nil, let result = result else {
                return completion(Result.error(error: error!))
            }
            completion(Result.success(result: result))
        }
    }
}


