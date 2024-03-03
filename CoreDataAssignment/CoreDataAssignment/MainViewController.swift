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
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if container == nil {
            self.container = AppDelegate.sharedAppDelegate.coreDataStack
        }
        
        print("MainViewController loaded")
        //view.backgroundColor = .white
        setupTableView()
        print("loaded")
        demo.getData { [weak self] fetchedLandlords in
            print("getData closure called with \(fetchedLandlords.count) landlords")
            DispatchQueue.main.async {
                self?.landlords = fetchedLandlords
                // print("Loaded landlords: \(fetchedLandlords.count)")
                self?.tableView.reloadData()
            }
        }
    }
        

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .systemPurple
        tableView.frame = view.bounds
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

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let landlord = landlords[section]
        return "Landlord: \(landlord.firstName ?? "") \(landlord.lastName ?? "")"
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Optionally, handle cell selection if needed
    }
}
