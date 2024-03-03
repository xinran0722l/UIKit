//
//  MainViewController.swift
//  CoreDataAssignment
//
//  Created by Xinran Yu on 2/29/24.
//

import UIKit
import CoreData

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    let demo = CoreDataDemo()
    var container: CoreDataStack!{
        didSet{
            demo.container = container
            print("Container has been set in MainViewController")
        }
    }
    var landlords: [Landlord] = []
    private let welcomeLabel = UILabel()
    private let logoutButton = UIButton()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if container == nil {
            self.container = AppDelegate.sharedAppDelegate.coreDataStack
        }
        
        //print("MainViewController loaded")
        //view.backgroundColor = .white
        setupLogout()
        setupTableView()
        demo.getData { [weak self] fetchedLandlords in
            //print("getData closure called with \(fetchedLandlords.count) landlords")
            DispatchQueue.main.async {
                self?.landlords = fetchedLandlords
                self?.tableView.reloadData()
            }
        }
    }
    
    private func setupLogout() {
        // Welcome Label
        welcomeLabel.text = "Welcome, Bob!"
        welcomeLabel.textAlignment = .center
        view.addSubview(welcomeLabel)
        
        // Logout Button
        logoutButton.setTitle("LOGOUT", for: .normal)
        logoutButton.backgroundColor = .blue
        logoutButton.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        view.addSubview(logoutButton)
        
        // Auto Layout constraints
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Align the welcomeLabel to the top with some padding
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(equalTo: logoutButton.leadingAnchor, constant: -10), // Space between label and button
            
            // Align the logoutButton to the top right
            logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            logoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
        ])
    }

    @objc func handleLogout() {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return
        }
        let loginVC = LoginViewController()
        sceneDelegate.window?.rootViewController = loginVC
        sceneDelegate.window?.makeKeyAndVisible()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .systemPurple
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // Adjust top constraint
            tableView.topAnchor.constraint(equalTo: logoutButton.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    

    // MARK: - TableView DataSource & Delegate

    func numberOfSections(in tableView: UITableView) -> Int {
        return landlords.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let apartments = landlords[section].owns?.allObjects as? [Apartment] else { return 0 }
        return apartments.count
    }

//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let landlord = landlords[section]
//        return "Landlord: \(landlord.firstName ?? "") \(landlord.lastName ?? "")"
//    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.systemPurple

        let headerLabel = UILabel(frame: CGRect(x: 16, y: 0, width: tableView.bounds.size.width, height: 30))
        headerLabel.text = "Landlord: \(landlords[section].firstName ?? "") \(landlords[section].lastName ?? "")"
        headerLabel.textColor = UIColor.white
        headerLabel.backgroundColor = UIColor.clear

        headerView.addSubview(headerLabel)

        return headerView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let apartments = landlords[indexPath.section].owns?.allObjects as? [Apartment] {
            let apartment = apartments[indexPath.row]
            var content = cell.defaultContentConfiguration()
            content.text = "Unit \(apartment.unitNumber): \(apartment.numRooms) room(s), $\(apartment.monthlyRent ?? 0)/month"
            cell.contentConfiguration = content
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0 // Adjust as needed to create space between sections
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Optionally, handle cell selection if needed
    }
}
