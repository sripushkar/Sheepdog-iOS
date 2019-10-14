//
//  SignUpController.swift
//  Sheepdog-iOS
//
//  Created by Sri Julapally on 10/12/19.
//  Copyright © 2019 Sri Julapally. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SignUpController: UIViewController{

    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = UIImage(named: "SheepdogLogo")
        return iv
    }()
    
    lazy var emailContainerView: UIView = {
        let view = UIView()
        return view.textContainerView(view: view, #imageLiteral(resourceName: "lock"), emailTextField)
    }()
    
    lazy var usernameContainerView: UIView = {
        let view = UIView()
        return view.textContainerView(view: view, #imageLiteral(resourceName: "person"), usernameTextField)
    }()
    
    lazy var passwordContainerView: UIView = {
        let view = UIView()
        return view.textContainerView(view: view, #imageLiteral(resourceName: "lock"), passwordTextField)
    }()
    
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceolder: "Email", isSecureTextEntry: false)
    }()
    
    lazy var usernameTextField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceolder: "Username", isSecureTextEntry: false)
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceolder: "Password", isSecureTextEntry: true)
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("SIGN UP", for: .normal)
        button.backgroundColor = UIColor.blue
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()
    /*
    lazy var dividerView: UIView = {
        let dividerView = UIView()
        
         let label = UILabel()
         label.text = "OR"
         label.textColor = UIColor(white: 1, alpha: 0.88)
         label.font = UIFont.systemFont(ofSize: 14)
         dividerView.addSubview(label)
         label.translatesAutoresizingMaskIntoConstraints = false
         label.centerYAnchor.constraint(equalTo: dividerView.centerYAnchor).isActive = true
         label.centerXAnchor.constraint(equalTo: dividerView.centerXAnchor).isActive = true
         
         let separator1 = UIView()
         separator1.backgroundColor = UIColor(white: 1, alpha: 0.88)
         dividerView.addSubview(separator1)
         separator1.anchor(top: nil, left: dividerView.leftAnchor, bottom: nil, right: label.leftAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 1.0)
         separator1.centerYAnchor.constraint(equalTo: dividerView.centerYAnchor).isActive = true
         
         let separator2 = UIView()
         separator2.backgroundColor = UIColor(white: 1, alpha: 0.88)
         dividerView.addSubview(separator2)
         separator2.anchor(top: nil, left: label.rightAnchor, bottom: nil, right: dividerView.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 1.0)
         separator2.centerYAnchor.constraint(equalTo: dividerView.centerYAnchor).isActive = true
 
        return dividerView
    }()
    */
    
    let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account?  ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        attributedTitle.append(NSAttributedString(string: "Sign In", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
        self.hideKeyboardWhenTappedAround()
    }
    
    // MARK: - Selectors
    
    @objc func handleSignUp() {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let username = usernameTextField.text else {return}
        
        createUser(withEmail: email, password: password, username: username)
    }

    
    // MARK: - API
    
    func createUser(withEmail email: String, password: String, username: String){
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            if let error = error{
                print("Failed to sign user up with error: ", error.localizedDescription)
                //ERROR POPUP HERE
                let alert = UIAlertController(title: "Error", message: "Please enter valid account information", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            guard let uid = result?.user.uid else{ return }
            let hours = 0
            let usershowup = false
            let values = ["email": email, "username": username, "hours": hours, "user showed up?": usershowup] as [String : Any]
            
            Database.database().reference().child("users").child(uid).updateChildValues(values, withCompletionBlock: { (error, ref) in
                if let error = error{
                    print("Failed to update database values with error: : ", error.localizedDescription)
                    return
                }
                let loginController = UINavigationController(rootViewController: HomeController())
                self.present(loginController, animated: true, completion: nil)
                print("Successfully signed user up.")
            })
            
            
        }
        
    }
    
    // MARK: - Helper Functions
    
    func configureViewComponents() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "065 Burning Spring.png")!)
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(logoImageView)
        logoImageView.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 60, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 150)
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(emailContainerView)
        emailContainerView.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
        view.addSubview(usernameContainerView)
        usernameContainerView.anchor(top: emailContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
        view.addSubview(passwordContainerView)
        passwordContainerView.anchor(top: usernameContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
        view.addSubview(loginButton)
        loginButton.anchor(top: passwordContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        /*
        view.addSubview(dividerView)
        dividerView.anchor(top: loginButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        */
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 32, paddingBottom: 12, paddingRight: 32, width: 0, height: 50)
        
    }
    
}
