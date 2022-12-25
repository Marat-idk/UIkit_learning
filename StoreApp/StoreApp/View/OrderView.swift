//
//  OrderView.swift
//  StoreApp
//
//  Created by Marat on 25.12.2022.
//

import UIKit

class OrderView: UIView {
    
    // костыль, нужный для нормальной общей тени
    private let view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private var product: Product
    
    private lazy var productImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        if let img = product.images.first {
            imgView.image = img
        }
        imgView.contentMode = .scaleAspectFit
        
        return imgView
    }()
    
    private let orderNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Ваш заказ отправлен."
        lbl.textColor = .black
        lbl.font = .boldSystemFont(ofSize: 17)
        lbl.textAlignment = .left
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    private let qualityLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "1 товар, доставка завтра"
        lbl.textColor = .gray
        lbl.font = .systemFont(ofSize: 17)
        lbl.textAlignment = .left
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    private let arrowImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(systemName: "chevron.right")
        imgView.tintColor = .gray
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let progressView: UIProgressView = {
        let prv = UIProgressView()
        prv.translatesAutoresizingMaskIntoConstraints = false
        prv.progressTintColor = .systemGreen
        prv.trackTintColor = UIColor(red: 243 / 255, green: 243 / 255, blue: 247 / 255, alpha: 1.0)
        prv.progress = 0.5
        prv.layer.cornerRadius = 5
        prv.layer.masksToBounds = true
        return prv
    }()
    
    private let inProcessLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Обрабатывается"
        lbl.textColor = .black
        lbl.font = .boldSystemFont(ofSize: 13)
        lbl.textAlignment = .left
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        return lbl
    }()
    
    private let sentLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Отправлено"
        lbl.textColor = .black
        lbl.font = .boldSystemFont(ofSize: 13)
        lbl.textAlignment = .center
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5

        return lbl
    }()

    private let deliveredLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Доставлено"
        lbl.textColor = .lightGray
        lbl.font = .boldSystemFont(ofSize: 13)
        lbl.textAlignment = .right
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        return lbl
    }()
    
    init(product: Product) {
        self.product = product
        super.init(frame: .zero)
        
        addSubviews(view, productImageView, orderNameLabel,
                    qualityLabel, arrowImageView, separatorView,
                    progressView, inProcessLabel, sentLabel, deliveredLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupConstraints()
        
        layer.cornerRadius = 15
        view.layer.cornerRadius = 15
        
        // тень для вью
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    private func setupConstraints() {
        // кривой способ, чтобы потом сделать тень у вью
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        // productImageView constraints
        productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        productImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        productImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        productImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        // orderNameLabel constraints
        orderNameLabel.topAnchor.constraint(equalTo: productImageView.topAnchor).isActive = true
        orderNameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10).isActive = true
        orderNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        
        // qualityLabel constraints
        qualityLabel.topAnchor.constraint(equalTo: orderNameLabel.bottomAnchor, constant: 10).isActive = true
        qualityLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10).isActive = true
        
        // arrowImageView constraints
        arrowImageView.centerYAnchor.constraint(equalTo: qualityLabel.centerYAnchor).isActive = true
        arrowImageView.leadingAnchor.constraint(equalTo: qualityLabel.trailingAnchor, constant: 5).isActive = true
        arrowImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        arrowImageView.widthAnchor.constraint(equalToConstant: 23).isActive = true
        arrowImageView.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        // separatorView constraints
        separatorView.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 15).isActive = true
        separatorView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        // progressView constraints
        progressView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 20).isActive = true
        progressView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        progressView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        progressView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        // inProcessLabel constraints
        inProcessLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 10).isActive = true
        inProcessLabel.leadingAnchor.constraint(equalTo: progressView.leadingAnchor).isActive = true
        inProcessLabel.trailingAnchor.constraint(equalTo: sentLabel.leadingAnchor, constant: -5).isActive = true
        
        // sentLabel constraints
        sentLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 10).isActive = true
        sentLabel.centerXAnchor.constraint(equalTo: progressView.centerXAnchor).isActive = true

        // deliveredLabel constraints
        deliveredLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 10).isActive = true
        deliveredLabel.leadingAnchor.constraint(equalTo: sentLabel.trailingAnchor, constant: 5).isActive = true
        deliveredLabel.trailingAnchor.constraint(equalTo: progressView.trailingAnchor).isActive = true
    }
    
}
