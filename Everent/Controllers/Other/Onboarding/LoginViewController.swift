//
//  LoginViewController.swift
//  Everent
//
//  Created by Tomas D. De Andrade Gomes on 2/6/24.
//

import UIKit
import SafariServices
import FirebaseAuth
import FirebaseCore
import GoogleSignInSwift
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit

class LoginViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let usernameEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username or Email..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius  = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password"
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius  = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms of Service", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("New User? Create an Account", for: .normal)
        
        return button
    }()
    
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        let backgroundImageView = UIImageView(image: UIImage(named: "Gradient"))
        header.addSubview(backgroundImageView)
        return header
    }()
    
    private let facebookLoginButton: FBLoginButton = {
        let button = FBLoginButton()
        button.permissions = ["public_profile", "email"]
        return button
    }()
    
    private let googleLogInButton: GIDSignInButton = {
        let button = GIDSignInButton()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(self,
                              action: #selector(didTapLoginButton),
                              for: .touchUpInside)
        googleLogInButton.addTarget(self,
                              action: #selector(didTapGoogleLoginButton),
                              for: .touchUpInside)
        createAccountButton.addTarget(self,
                              action: #selector(didTapCreateAccountButton),
                              for: .touchUpInside)
        
        termsButton.addTarget(self,
                              action: #selector(didTapTermsButton),
                              for: .touchUpInside)
        
        privacyButton.addTarget(self,
                              action: #selector(didTapPrivacyButton),
                              for: .touchUpInside)
        usernameEmailField.delegate = self
        passwordField.delegate = self
        facebookLoginButton.delegate = self
        //GIDSignIn.sharedInstance.uiDelegate = self
        addSubviews()
        view.backgroundColor = .systemBackground
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        //Assign Frames
        
        headerView.frame = CGRect(
            x: 0,
            y: 0.0,
            width: view.width,
            height: view.height/3.0
        )
        
        usernameEmailField.frame = CGRect(
            x: 25,
            y: headerView.bottom + 20,
            width: view.width-50,
            height: 52.0
        )
        
        passwordField.frame = CGRect(
            x: 25,
            y: usernameEmailField.bottom + 10,
            width: view.width-50,
            height: 52.0
        )
        
        loginButton.frame = CGRect(
            x: 25,
            y: passwordField.bottom + 10,
            width: view.width-50,
            height: 52.0
        )
        
        facebookLoginButton.frame = CGRect(
            x: 25,
            y: loginButton.bottom + 10,
            width: view.width-50,
            height: 52.0
        )
        
        googleLogInButton.frame = CGRect(
            x: 25,
            y: facebookLoginButton.bottom + 10,
            width: view.width-50,
            height: 52.0
        )
        
        createAccountButton.frame = CGRect(
            x: 25,
            y: googleLogInButton.bottom + 10,
            width: view.width-50,
            height: 52.0
        )
        
        termsButton.frame = CGRect(
            x: 10,
            y: view.height-view.safeAreaInsets.bottom-100,
            width: view.width-20,
            height: 50
        )
        
        privacyButton.frame = CGRect(
            x: 10,
            y: view.height-view.safeAreaInsets.bottom-50,
            width: view.width-20,
            height: 50
        )
       
        configureHeaderView()
    }
    
    private func configureHeaderView() {
        guard headerView.subviews.count == 1 else {
            return
        }
        
        guard let backgroundView = headerView.subviews.first else {
            return
        }
        
        backgroundView.frame = headerView.bounds
        
        //Add Logo
        let imageView = UIImageView(image: UIImage(named: "Text"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.width/4.0,
                                 y: view.safeAreaInsets.top,
                                 width: headerView.width/2.0,
                                 height: headerView.height - view.safeAreaInsets.top)
    }
    
    private func addSubviews() {
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(headerView)
        view.addSubview(createAccountButton)
        view.addSubview(facebookLoginButton)
        view.addSubview(googleLogInButton)
    }
    
    @objc private func didTapLoginButton() {
        passwordField.resignFirstResponder()
        usernameEmailField.resignFirstResponder()
        
        guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        
        //Login functionality
        
        var username: String?
        var email: String?
        
        if usernameEmail.contains("@"), usernameEmail.contains(".") {
            //email
            email = usernameEmail
        } else {
            //username
            username = usernameEmail
        }
        
        AuthManager.shared.loginUser(username: username, email: email, password: password) { success in
            DispatchQueue.main.async {
                if success {
                    //User Logs In
                    self.dismiss(animated: true, completion: nil)
                }else {
                    //Error Occurred
                    let alert = UIAlertController(title: "Log in Error",
                                                  message: "We were unable to log you in",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss",
                                                  style: .cancel,
                                                  handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    @objc private func didTapTermsButton() {
        guard let url = URL(string: "https://help.instagram.com/581066165581870/?helpref=uf_share") else {
            return
        }
        let vc = SFSafariViewController(url:url)
        present(vc, animated: true)
    }
    
    @objc private func didTapPrivacyButton() {
        guard let url = URL(string: "https://privacycenter.instagram.com/policy") else {
            return
        }
        let vc = SFSafariViewController(url:url)
        present(vc, animated: true)
    }
    
    @objc private func didTapCreateAccountButton() {
        let vc = RegistrationViewController()
        vc.title = "Create Accout"
        vc.modalPresentationStyle = .fullScreen
        present(UINavigationController(rootViewController: vc), animated:  true)
    }
    
// MARK: Google Login ------------------------------------------------------------------------------------------------------
    
    @objc func didTapGoogleLoginButton(_ loginButton: GIDSignInButton, didCompleteWith result: GIDSignInResult?, error: Error?) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else {
                print("Sign-In error: \(error!)")
                return
            }
            
            guard let signInResult = signInResult else {
                return
            }
            
            self.dismiss(animated: true) {
                // Present your main app content here
                // For example, present a new view controller
                let mainViewController = HomeViewController()
                self.present(mainViewController, animated: true)
            }
            
            let user = signInResult.user
            let emailAddress = user.profile?.email
            let fullName = user.profile?.name
            let givenName = user.profile?.givenName
            let familyName = user.profile?.familyName
            let profilePicUrl = user.profile?.imageURL(withDimension: 320)
            
            signInResult.user.refreshTokensIfNeeded { user, error in
                guard error == nil else {
                    return
                }
                guard let user = user else {
                    return
                }}
                let idToken = user.idToken

            print("Did sign in with Google: \(user)")
  
            DatabaseManager.shared.userExists(with: emailAddress!, completion: { exists in
                if !exists {
                    let everentUser = EverentAppUser(firstName: givenName!,
                                                     lastName: familyName!,
                                                     emailAddress: emailAddress!)
         
                    DatabaseManager.shared.insertUser(with: everentUser, completion: { success in
                        if success {
                            
                            guard let profilePicUrlString = profilePicUrl?.absoluteString,
                                  let url = URL(string: profilePicUrlString) else {
                                return
                            }
         
                            print("Downloading data from a facebook image")
         
                            URLSession.shared.dataTask(with: url, completionHandler: { data, _, _ in
                                guard let data = data else {
                                    print("Failed to get data from facebook")
                                    return
                                }
         
                                print("got data from FB, uploading...")
         
                                //Upload image
                                let fileName = everentUser.profilePictureFileName
                                StorageManager.shared.uploadProfilePicture(with: data, fileName: fileName) { result in
                                    switch result {
                                    case .success(let downloadUrl):
                                        UserDefaults.standard.set(downloadUrl, forKey: "profile_picture_url")
                                        print(downloadUrl)
                                    case .failure(let error):
                                        print("Storage manager error: \(error)")
                                    }
                                }
                            }).resume()
                        }
                    })
                }
            })
            
            AuthManager.shared.googleSignIn(with: idToken!.tokenString) { [weak self] success, error in
                DispatchQueue.main.async {
                    if success {
                        //User Logs In
                        self?.dismiss(animated: true, completion: nil)
                    }else {
                        //Error Occurred
                        let alert = UIAlertController(title: "Log in Error",
                                                      message: "We were unable to log you in",
                                                      preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Dismiss",
                                                      style: .cancel,
                                                      handler: nil))
                        self?.present(alert, animated: true)
                    }
                }
            }
        }
    }
}

// MARK: Facebook Login -----------------------------------------------------------------------------------------------------

extension LoginViewController: LoginButtonDelegate {

    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        guard let token = result?.token?.tokenString else {
            print("User failed to log in with Facebook")
            return
        }
        
        let facebookRequest = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                         parameters: ["fields": "email, first_name, last_name, picture.type(large)"],
                                                         tokenString: token,
                                                         version: nil,
                                                         httpMethod: .get)
        
        facebookRequest.start(completionHandler: { _, result, error in
            guard let result = result as? [String: Any],
                  error == nil else {
                print("Failed to make facebook graph request")
                return
            }
            
            print("this: \(result)")
            
            guard let firstName = result["first_name"] as? String,
                  let lastName = result["last_name"] as? String,
                  let email = result["email"] as? String,
                  let picture = result["picture"] as? [String: Any],
                  let data = picture["data"] as? [String: Any],
                  let pictureUrl = data["url"] as? String else {
                print("Failed to get email and name fom fb result")
                return
            }
            
            UserDefaults.standard.set(email, forKey: "email")
            UserDefaults.standard.set("\(firstName) \(lastName)", forKey: "name")
            
            DatabaseManager.shared.userExists(with: email, completion: { exists in
                if !exists {
                    let everentUser = EverentAppUser(firstName: firstName,
                                                  lastName: lastName,
                                                  emailAddress: email)
                    
                    DatabaseManager.shared.insertUser(with: everentUser, completion: { success in
                        if success {
                            
                            guard let url = URL(string: pictureUrl) else {
                                return
                            }
                            
                            print("Downloading data from a facebook image")
                            
                            URLSession.shared.dataTask(with: url, completionHandler: { data, _, _ in
                                guard let data = data else {
                                    print("Failed to get data from facebook")
                                    return
                                }
                                
                                print("got data from FB, uploading...")
                                
                                //Upload image
                                let fileName = everentUser.profilePictureFileName
                                StorageManager.shared.uploadProfilePicture(with: data, fileName: fileName, completion: { result in
                                    switch result {
                                    case .success(let downloadUrl):
                                        UserDefaults.standard.set(downloadUrl, forKey: "profile_picture_url")
                                        print(downloadUrl)
                                    case .failure(let error):
                                        print("Storage manager error: \(error)")
                                    }
                                })
                            }).resume()
                        }
                    })
                }
            })
            
            AuthManager.shared.signIn(with: token) { [weak self] success, error in
                DispatchQueue.main.async {
                    if success {
                        //User Logs In
                        self?.dismiss(animated: true, completion: nil)
                    }else {
                        //Error Occurred
                        let alert = UIAlertController(title: "Log in Error",
                                                      message: "We were unable to log you in",
                                                      preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Dismiss",
                                                      style: .cancel,
                                                      handler: nil))
                        self?.present(alert, animated: true)
                    }
                }
            }
        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        //No Operation
    }
}


extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            didTapLoginButton()
        }
        return true
    }
    
}
