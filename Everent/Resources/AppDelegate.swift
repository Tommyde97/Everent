//
//  AppDelegate.swift
//  Everent
//
//  Created by Tomas D. De Andrade Gomes on 2/6/24.
//

import Firebase
import UIKit
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
//       GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
//           if error != nil || user == nil {
//               // Show the app's signed-out state.
//           } else {
//               // Show the app's signed-in state.
//           }
//       }
        
//        GIDSignIn.sharedInstance.clientID = FirebaseApp.app()?.options.clientID
//        GIDSignIn.sharedInstance.delegate = self
        
        return true
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard error == nil else {
            if let error = error {
                print("Failed to sign in with Google: \(error)")
            }
            return
        }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        
        return GIDSignIn.sharedInstance.handle(url)
    }
 //      var handled: Bool
 //
 //      handled = GIDSignIn.sharedInstance.handle(url)
 //      if handled {
 //          return true
 //      }
 //      // Handle other custom URL types.
 //
 //      // If not handled by this app, return false.
 //      return false
        
 //      guard let clientID = FirebaseApp.app()?.options.clientID else { return }
 //
 //      // Create Google Sign In configuration object.
 //      let config = GIDConfiguration(clientID: clientID)
 //      GIDSignIn.sharedInstance.configuration = config
 //
 //      // Start the sign in flow!
 //      GIDSignIn.sharedInstance.signIn(withPresenting: HomeViewController()) { [unowned self] result, error in
 //          guard error == nil else {
 //              // ...
 //          }
 //
 //          guard let user = result?.user,
 //                let idToken = user.idToken?.tokenString
 //          else {
 //              // ...
 //          }
 //
 //          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
 //                                                         accessToken: user.accessToken.tokenString)
 //
 //          // ...
 //      }
 //  }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    
        
      //  guard let authentication = user.authentication else {
      //      return
      //  }
      //  let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
    }
}

