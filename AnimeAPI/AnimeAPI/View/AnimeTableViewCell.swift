//
//  AnimeTableViewCell.swift
//  AnimeAPI
//
//  Created by Marat on 05.01.2023.
//

import UIKit

class AnimeTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: AnimeTableViewCell.self)
    
    var anime: Anime? {
        didSet {
            self.set(anime)
        }
    }
    
    let animePosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let animeTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Untitled"
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.font = .systemFont(ofSize: 20)
        lbl.numberOfLines = 3
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        contentView.addSubviews(animePosterImageView, animeTitleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.animePosterImageView.image = nil
    }
    
    private func setupConstraints() {
        setupanimePosterImageViewConstraints()
        setupAnimeTitleLabelConstraints()
    }
    
    private func setupanimePosterImageViewConstraints() {
        animePosterImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        animePosterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        animePosterImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9).isActive = true
        animePosterImageView.widthAnchor.constraint(equalTo: animePosterImageView.heightAnchor, multiplier: 0.8).isActive = true
    }
    
    private func setupAnimeTitleLabelConstraints() {
        animeTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        animeTitleLabel.leadingAnchor.constraint(equalTo: animePosterImageView.trailingAnchor, constant: 10).isActive = true
        animeTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }
    
    private func set(_ anime: Anime?) {
        if let url = URL(string: anime!.images!.jpg!.largeImageURL!) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.animePosterImageView.image = image
                        }
                    }
                }
            }
        }
        animeTitleLabel.text = anime!.title
    }
}
