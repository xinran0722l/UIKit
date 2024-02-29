//
//  SpecializedCatCell.swift
//  TableViewAssignment
//
//  Created by Xinran Yu on 2/29/24.
//

import UIKit

class SpecializedCatCell: UICollectionViewCell {
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let labelBackgroundView = UIView()
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        labelBackgroundView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        labelBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        addSubview(labelBackgroundView)
        addSubview(nameLabel)
        
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),
            
            labelBackgroundView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            labelBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            labelBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            labelBackgroundView.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
        ])
        
        
        nameLabel.font = UIFont.systemFont(ofSize: 18)
        nameLabel.textAlignment = .center
        
    }
    
    func configure(with cat: Cat) {
        nameLabel.text = cat.name
        imageView.image = UIImage(named: cat.imageName)
    }
}

