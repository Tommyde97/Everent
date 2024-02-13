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
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
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
        
        if let token = AccessToken.current, !token.isExpired {
            let token = token.tokenString
            
            let facebookRequest = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                             parameters: ["fields": "email, name"],
                                                             tokenString: token,
                                                             version: nil,
                                                             httpMethod: .get)
            
            facebookRequest.start(completionHandler: { connection, result, error in
                if let error = error {
                    print("Error fetching user data: \(error.localizedDescription)")
                    return
                }
                
                guard let result = result as? [String: Any] else {
                    print("Error parsing result")
                    return
                }
                
                // Handle the result data
                print("User data: \(result)")
            })
            
        } else {
            
            facebookLoginButton.permissions = ["public_profile", "email"]
            facebookLoginButton.center = view.center
            view.addSubview(facebookLoginButton)
            
           
        }
        
        loginButton.addTarget(self,
                              action: #selector(didTapLoginButton),
                              for: .touchUpInside)
        googleLogInButton.addTarget(self,
                              action: #selector(didTapGoogleLoginButton),
                              for: .touchUpInside)
        //facebookLoginButton.addTarget(self,
        //                        action: #selector(didTapGoogleLoginButton),
        //                        for: .touchUpInside)
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
    
    @objc private func didTapGoogleLoginButton() {
        let vc = HomeViewController()
        present(vc, animated: true, completion: nil)
        
        GIDSignIn.sharedInstance.signIn(withPresenting: vc) { signInResult, error in
            guard signInResult != nil else {
                //Inspect Error
                print("Log In Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            //If sign in succeeded, display the app's main content View.
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

extension LoginViewController: LoginButtonDelegate {
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        guard let token = result?.token?.tokenString else {
            print("User failed to log in with Facebook")
            return
        }
        
        let facebookRequest = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                         parameters: ["fields": "email, name"],
                                                         tokenString: token,
                                                         version: nil,
                                                         httpMethod: .get)
        
        facebookRequest.start(completionHandler: { _, result, error in
            guard let result = result as? [String: Any],
                  error == nil else {
                print("Error fetching user data: \(String(describing: error?.localizedDescription))")
                return
            }
            
            // Handle the result data
            print("User data: \(result)")
            guard let userName = result["name"] as? String,
                  let email = result["email"] as? String else {
                print("Failed to get email from FBn result")
                return
            }
            let nameComponets = userName.components(separatedBy: " ")
            guard nameComponets.count == 2 else {
                return
            }
            let firstName = nameComponets[0]
            let lastName = nameComponets[1]
            
            DatabaseManager.shared.userExists(with: email, completion: { exists in
                if !exists {
                    DatabaseManager.shared.insertUser(with: EverentAppUser(firstName: firstName,
                                                                           lastName: lastName,
                                                                           emailAddress: email), completion: <#(Bool) -> Void#>)
                }
            })
            
            let credential = FacebookAuthProvider.credential(withAccessToken: token)
            
            Auth.auth().signIn(with: credential, completion: { [weak self] authResult, error in
                guard let strongSelf = self else {
                    return
                }
                guard authResult != nil, error == nil else {
                    if let error = error {
                        print("Facebook credential Login Failed, MFA may be needed - \(error)")
                    }
                    return
                }
                
                print("Succesfully Logged user in")
                strongSelf.navigationController?.present(HomeViewController(), animated: true, completion: nil)
            })
        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginKit.FBLoginButton) {
        //No Operation
    }
    
}
