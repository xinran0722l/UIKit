//
//  ViewController.swift
//  CoreDataAssignment
//
//  Created by Xinran Yu on 2/29/24.
//

import UIKit

class LoginViewController: UIViewController {
    let loginButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        setupLoginButton()
    }
    
    private func setupLoginButton() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loginButton.setTitle("LOGIN", for: .normal)
        loginButton.backgroundColor = .blue
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    }

    @objc func handleLogin() {
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        DispatchQueue.main.async { // main thread
            let mainViewController = MainViewController()
            mainViewController.container = AppDelegate.sharedAppDelegate.coreDataStack
            mainViewController.modalPresentationStyle = .fullScreen
            self.present(mainViewController, animated: true, completion: nil)
        }
    }
    
}
