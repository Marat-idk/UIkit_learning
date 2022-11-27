//
//  SettingsViewController.swift
//  Book
//
//  Created by Marat on 26.11.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private var fontSize: CGFloat
    private let fontWeights = [UIFont.Weight.regular, UIFont.Weight.bold]
    // текущая ширина шрифта
    private var fontWeight: UIFont.Weight
    private lazy var font: UIFont = .systemFont(ofSize: fontSize)
    
    var delegate: MainViewControllerDelegate?
    
    lazy var fontSizeSlider: UISlider = {
        let sr = UISlider()
        sr.translatesAutoresizingMaskIntoConstraints = false
        sr.minimumValue = 0.0
        sr.maximumValue = 100.0
        sr.value = Float(fontSize)
        sr.addTarget(self, action: #selector(updateFontSize(_:)), for: .valueChanged)
        return sr
    }()
    
    let plusImageView: UIImageView = {
        let img = UIImage(systemName: "plus")
        let imgv = UIImageView(image: img)
        imgv.translatesAutoresizingMaskIntoConstraints = false
        return imgv
    }()
    
    let minusImageView: UIImageView = {
        let img = UIImage(systemName: "minus")
        let imgv = UIImageView(image: img)
        imgv.translatesAutoresizingMaskIntoConstraints = false
        imgv.contentMode = .scaleAspectFit
        return imgv
    }()
    
    // возможно лучше все это генерировать в отдельном методе
    lazy var weightSegmentedController: UISegmentedControl = {
        let sc = UISegmentedControl(items: fontWeights.map({ $0.description }))
        sc.translatesAutoresizingMaskIntoConstraints = false
        // дефолтное значение сегментеда котроллера будет равно текущей ширине шрифта
        sc.selectedSegmentIndex = fontWeights.firstIndex(of: fontWeight) ?? 0
        
        sc.setTitleTextAttributes(
            [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                NSAttributedString.Key.foregroundColor: UIColor.label
            ],
            for: .normal)
        
        sc.setTitleTextAttributes(
            [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                NSAttributedString.Key.foregroundColor: UIColor.label
            ],
            for: .selected)
        
        sc.addTarget(self, action: #selector(updateFontWeight(_:)), for: .valueChanged)
        return sc
    }()
    
    let whiteModeButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tag = 0
        btn.backgroundColor = .white
        btn.layer.borderWidth = 1.0
        btn.layer.borderColor = UIColor.black.cgColor
        btn.addTarget(self, action: #selector(updateBackgroundColor(_:)), for: .touchUpInside)
        return btn
    }()
    
    let brownModeButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tag = 1
        btn.backgroundColor = .systemBrown
        btn.layer.borderWidth = 1.0
        btn.layer.borderColor = UIColor.brown.cgColor
        btn.addTarget(self, action: #selector(updateBackgroundColor(_:)), for: .touchUpInside)
        return btn
    }()
    
    let grayModeButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tag = 2
        btn.backgroundColor = .darkGray
        btn.layer.borderWidth = 1.0
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.addTarget(self, action: #selector(updateBackgroundColor(_:)), for: .touchUpInside)
        return btn
    }()
    
    let blackModeButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tag = 3
        btn.backgroundColor = .black
        btn.layer.borderWidth = 1.0
        btn.layer.borderColor = UIColor.white.cgColor
        btn.addTarget(self, action: #selector(updateBackgroundColor(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 15
        sv.addArrangedSubviews(
            whiteModeButton,
            brownModeButton,
            grayModeButton,
            blackModeButton
        )
        
        return sv
    }()
    
    init(fontSize: CGFloat, fontWeight: UIFont.Weight) {
        self.fontSize = fontSize
        self.fontWeight = fontWeight
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubviews(fontSizeSlider, minusImageView, plusImageView,
                         weightSegmentedController, stackView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        setupSliderConstraint()
        setupSegmentedControllerConstraint()
        setupStackViewConstraints()
    }
    
    func setupSliderConstraint() {
        minusImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        minusImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        minusImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        minusImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        plusImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        plusImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        plusImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        plusImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        fontSizeSlider.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        fontSizeSlider.leadingAnchor.constraint(equalTo: minusImageView.trailingAnchor, constant: 10).isActive = true
        fontSizeSlider.trailingAnchor.constraint(equalTo: plusImageView.leadingAnchor, constant: -10).isActive = true
    }
    
    func setupSegmentedControllerConstraint() {
        weightSegmentedController.topAnchor.constraint(equalTo: fontSizeSlider.bottomAnchor, constant: 10).isActive = true
        weightSegmentedController.leadingAnchor.constraint(equalTo: minusImageView.leadingAnchor).isActive = true
        weightSegmentedController.trailingAnchor.constraint(equalTo: plusImageView.trailingAnchor).isActive = true
    }
    
    func setupStackViewConstraints() {
        stackView.topAnchor.constraint(equalTo: weightSegmentedController.bottomAnchor, constant: 10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: weightSegmentedController.leadingAnchor, constant: 25).isActive = true
        stackView.trailingAnchor.constraint(equalTo: weightSegmentedController.trailingAnchor, constant: -25).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    @objc func updateFontSize(_ slider: UISlider) {
        delegate?.updateFontSize(fontSize: CGFloat(slider.value))
    }
    
    // weight доступно только для .systemFont
    @objc func updateFontWeight(_ segmentedController: UISegmentedControl) {
        let weight = fontWeights[segmentedController.selectedSegmentIndex]
        delegate?.updateFontWeight(fontWeight: weight)
    }
    
    @objc func updateBackgroundColor(_ button: UIButton) {
        guard let backgroundColor = button.backgroundColor else { return }
        let textColor = getTextColor(backgroundColor)
        delegate?.updateBackgroundColor(background: backgroundColor, textColor: textColor)
    }
    
    func getTextColor(_ background: UIColor) -> UIColor {
        switch background {
        case .white, .brown:
            return .black
        case .darkGray:
            return .lightGray
        case .black:
            return .white
        default:
            return .label
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        whiteModeButton.layer.cornerRadius = whiteModeButton.frame.width / 2
        brownModeButton.layer.cornerRadius = whiteModeButton.frame.width / 2
        grayModeButton.layer.cornerRadius = whiteModeButton.frame.width / 2
        blackModeButton.layer.cornerRadius = whiteModeButton.frame.width / 2
    }
}
