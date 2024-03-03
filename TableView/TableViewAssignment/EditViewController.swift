//
//  EditViewController.swift
//  TableViewAssignment
//
//  Created by Xinran Yu on 2/29/24.
//
import UIKit
class EditViewController: UIViewController {
    var catImage: UIImage?
    var catName: String?
    
    private let imageView = UIImageView()
    private let nameTextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        imageView.image = catImage
        nameTextField.text = catName
        
        setupViews()
    }
    
    private func setupViews() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        view.addSubview(nameTextField)
        
        // Layout constraints
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            
            nameTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.widthAnchor.constraint(equalToConstant: 250),
            nameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Additional setup for nameTextField
        nameTextField.borderStyle = .roundedRect
    }
}

