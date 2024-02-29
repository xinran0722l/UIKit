//
//  ViewController.swift
//  TableViewAssignment
//
//  Created by Xinran Yu on 2/28/24.
//

import UIKit

class MainViewController: UIViewController {
    var tableView: UITableView!
    var collectionView: UICollectionView!
    var specializedCatsTitleLabel: UILabel!
    var catsGallery: [Cat] = [
            Cat(name: "luna", imageName: "luna"),
            Cat(name: "ginger", imageName: "ginger"),
            Cat(name: "lion", imageName: "lion"),
            Cat(name: "apple", imageName: "apple"),
            Cat(name: "tim", imageName: "tim"),
    ]
    
    var specializedCats: [Cat] = [
            Cat(name: "robert", imageName: "robert"),
            Cat(name: "oreo", imageName: "oreo"),
            Cat(name: "candy", imageName: "candy"),
            Cat(name: "alex", imageName: "alex"),
            Cat(name: "nose", imageName: "nose"),
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSpecializedCatsTitleLabel()
        setupCollectionView()
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        print("Specialized Cats Title Label Frame: \(specializedCatsTitleLabel.frame)")
//    }
    
    func setupTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(white:0.9, alpha: 1.0)
        tableView.register(CatTableViewCell.self, forCellReuseIdentifier: "CatTableViewCell")
        view.addSubview(tableView)

        // Layout tableView here, assuming full width and half the screen height
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
    }
    func setupSpecializedCatsTitleLabel() {
        specializedCatsTitleLabel = UILabel()
        specializedCatsTitleLabel.text = "Specialized Cats"
        specializedCatsTitleLabel.backgroundColor = .clear
        specializedCatsTitleLabel.backgroundColor = UIColor(white:0.9, alpha: 1.0)
        specializedCatsTitleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        view.addSubview(specializedCatsTitleLabel)

        specializedCatsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            specializedCatsTitleLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
            specializedCatsTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            specializedCatsTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            specializedCatsTitleLabel.heightAnchor.constraint(equalToConstant: 30) // Explicit height
        ])
    }
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 200)
        // Space between items in the same row
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(white:0.9, alpha: 1.0)
        collectionView.register(SpecializedCatCell.self, forCellWithReuseIdentifier: "SpecializedCatCell")
        view.addSubview(collectionView)

        // Layout collectionView here, assuming full width and half the screen height minus tableView
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: specializedCatsTitleLabel.bottomAnchor, constant: 10), // Adjusted to be below the label
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows for cats
        return catsGallery.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120 // Or any other fixed height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        headerLabel.text = "Cats Gallery"
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont.boldSystemFont(ofSize: 22)
        return headerLabel
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40 // Adjust the height as needed
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue and configure CatTableViewCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CatTableViewCell", for: indexPath) as? CatTableViewCell else {
                fatalError("Unable to dequeue CatTableViewCell")
            }
        let cat = catsGallery[indexPath.row]
        cell.configure(with: cat)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle selection for editing
        let cat = catsGallery[indexPath.row]
        let editVC = EditViewController()
        editVC.catImage = UIImage(named: cat.imageName)
        editVC.catName = cat.name
        navigationController?.pushViewController(editVC, animated: true)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return the number of items for specialized cats
        return specializedCats.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Dequeue and configure SpecializedCatCell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpecializedCatCell", for: indexPath) as? SpecializedCatCell else {
                fatalError("Unable to dequeue SpecializedCatCell")
        }
        let cat = specializedCats[indexPath.row]
        cell.configure(with: cat)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Handle selection for editing
        let cat = specializedCats[indexPath.row]
        let editVC = EditViewController()
        editVC.catImage = UIImage(named: cat.imageName)
        editVC.catName = cat.name
        navigationController?.pushViewController(editVC, animated: true)
    }
}





