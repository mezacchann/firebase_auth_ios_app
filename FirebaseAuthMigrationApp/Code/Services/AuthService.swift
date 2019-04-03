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
 
 
 =======================================
 
 Importing/Exporting
 
 Email/Password user:

 {
 "localId": "ePwXHHyUcJY2JKiiy8G0YuQ3EtD3",
 "email": "test@cchan.tv",
 "emailVerified": false,
 "passwordHash": "wqGWk4WiPqG8eDSGqF/dhfriGiFD21tOB2LipNDLF077nl9sIdgbqQ7VwQKro14JZ1/woGyESa4l8HOJAV5bkw==",
 "salt": "hPMiuY26Nw2mCw==",
 "lastSignedInAt": "1554273912318",
 "createdAt": "1554273912318",
 "providerUserInfo": []
 }
 
 Facebook user:
 
 {
 "localId": "Nz2VZk4dNiTSGsAKWDVTkEkehFN2",
 "displayName": "Jeany Meza",
 "photoUrl": "https://graph.facebook.com/10209292904399815/picture",
 "lastSignedInAt": "1554279706440",
 "createdAt": "1554279706438",
 "providerUserInfo": [{
 "providerId": "facebook.com",
 "rawId": "10209292904399815",
 "displayName": "Jeany Meza",
 "photoUrl": "https://graph.facebook.com/10209292904399815/picture"
 }]
 }
 
 
 =======================================
 
 1    UID                    String             Required
 2    Email                  String             Optional
 3    Email Verified         Boolean            Optional
 4    Password Hash          String             Optional
 5    Password Salt          String             Optional
 6    Name                   String             Optional
 7    Photo URL              String             Optional
 8    Google ID              String             Optional
 9    Google Email           String             Optional
 10   Google Display Name    String             Optional
 11   Google Photo URL       String             Optional
 12   Facebook ID            String             Optional
 13   Facebook Email         String             Optional
 14   Facebook Display Name  String             Optional
 15   Facebook Photo URL     String             Optional
 16   Twitter ID             String             Optional
 17   Twitter Email          String             Optional
 18   Twitter Display Name   String             Optional
 19   Twitter Photo URL      String             Optional
 20   GitHub ID              String             Optional
 21   GitHub Email           String             Optional
 22   GitHub Display Name    String             Optional
 23   GitHub Photo URL       String             Optional
 24   User Creation Time     Long               Optional. Epoch Unix Timestamp in milliseconds.
 25   Last Sign-In Time      Long               Optional. Epoch Unix Timestamp in milliseconds.
 26   Phone Number           String             Optional
 
 =============================================
 
 //            let token = result.token!
 //            let appID = token.appID
 //            let expirationDate = token.dataAccessExpirationDate
 //            let facebookUserID = token.userID
 //            let tokenString = token.tokenString
 
 // USER PICTURE
 // graph.facebook.com/___USER_FACEBOOK_ID___?fields=picture.width(720)
 
 */

import Foundation
import Firebase
import FBSDKLoginKit

enum Result<T> {
    case success(result: T)
    case error(error: Error?)
}

enum AuthError: Error {
    case noUserSignedIn
    case userCancelledSignIn
}


struct AuthService {
    
    private let email = "test@cchan.tv"
    private let password = "123qweASD"
    
    func isSignIn(completion: (Bool)->()) {
        completion(Auth.auth().currentUser?.uid != nil)
    }
    
    func signInAnonymously(completion: @escaping (Result<AuthDataResult>)->()) {
        Auth.auth().signInAnonymously { result, error in
            guard error == nil, let result = result else {
                    return completion(Result.error(error: error))
            }
            completion(Result.success(result: result))
        }
    }
    
    func createUserWithEmail(completion: @escaping (Result<AuthDataResult>)->()) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard error == nil, let result = result else {
                return completion(Result.error(error: error))
            }
            completion(Result.success(result: result))
        }
    }
    
    func signInWithEmail(completion: @escaping (Result<AuthDataResult>)->()) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard error == nil, let result = result else {
                return completion(Result.error(error: error))
            }
            completion(Result.success(result: result))
        }
    }
    
    func isRegisteredWithFacebookSDK() -> Bool {
        guard let token = FBSDKAccessToken.current() else { return false }
        return !token.isExpired
    }
    
    func registerWithFacebookSDK(_ viewController: UIViewController, completion: @escaping (Result<FBSDKAccessToken>)->()) {
        let manager = FBSDKLoginManager()
        manager.logOut()
        manager.logIn(withReadPermissions: [""], from: viewController) { result, error in
            guard error == nil, let result = result else {
                return completion(Result.error(error: error))
            }
            
            if result.isCancelled {
                return completion(Result.error(error: AuthError.userCancelledSignIn))
            }
            
            return completion(Result.success(result: result.token!))
        }
    }
    
    func signInWithFacebook(completion: @escaping (Result<AuthDataResult>)->()) {
        guard let facebookToken = FBSDKAccessToken.current()?.tokenString else {
            return completion(Result.error(error: AuthError.noUserSignedIn))
        }
        let credential = FacebookAuthProvider.credential(withAccessToken: facebookToken)
        
        Auth.auth().signInAndRetrieveData(with: credential, completion: {result, error in
            guard error == nil, let result = result else {
                return completion(Result.error(error: error))
            }
            completion(Result.success(result: result))
        })
    }
    
    func linkAccountWithProvider(credentials: AuthCredential, completion: @escaping (Result<AuthDataResult>)->()) {
        guard let user = Auth.auth().currentUser else {
            return completion(Result.error(error: AuthError.noUserSignedIn))
        }

        user.linkAndRetrieveData(with: credentials) { result, error in
            guard error == nil, let result = result else {
                return completion(Result.error(error: error))
            }
            completion(Result.success(result: result))
        }
    }
}


