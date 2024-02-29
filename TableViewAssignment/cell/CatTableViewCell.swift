//
//  CatTableViewCell.swift
//  TableViewAssignment
//
//  Created by Xinran Yu on 2/29/24.
//

import UIKit

class CatTableViewCell: UITableViewCell {
    let catImageView = UIImageView()
    let nameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .white
        self.selectionStyle = .none
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        catImageView.contentMode = .scaleAspectFill
        catImageView.clipsToBounds = true
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        catImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(catImageView)
        addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            catImageView.heightAnchor.constraint(equalToConstant: 80),
            catImageView.widthAnchor.constraint(equalToConstant: 80),
            catImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            catImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: catImageView.trailingAnchor, constant: 10),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
        
        nameLabel.font = UIFont.systemFont(ofSize: 16)
    }
    override func layoutSubviews() {
            super.layoutSubviews()
            
            // Adjust contentView's frame or layoutMargins to create spacing effect
            // Adjust the spacing as needed
            let spacing: CGFloat = 10.0 
            contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing))
            
            // Optionally, round the corners of the contentView
            contentView.layer.cornerRadius = 10.0
    }
    
    func configure(with cat: Cat) {
        nameLabel.text = cat.name
        catImageView.image = UIImage(named: cat.imageName)
    }
}














