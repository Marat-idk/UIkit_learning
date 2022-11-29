//
//  SettingsViewController.swift
//  Book
//
//  Created by Marat on 26.11.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // текущий размер шрифта
    private var fontSize: CGFloat
    private let fontWeights = [UIFont.Weight.regular, UIFont.Weight.bold]
    // текущая ширина шрифта
    private var fontWeight: UIFont.Weight
    
    private lazy var fonts: [UIFont?] = [
        .systemFont(ofSize: fontSize),
        .italicSystemFont(ofSize: fontSize),
        UIFont(name: "SnellRoundhand", size: fontSize)]
    // текущий шрифт
    private var font: UIFont
    private var isDarkMode: Bool
    
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
        btn.backgroundColor = .white
        btn.layer.borderWidth = 1.0
        btn.layer.borderColor = UIColor.black.cgColor
        btn.addTarget(self, action: #selector(updateBackgroundColor(_:)), for: .touchUpInside)
        return btn
    }()
    
    let brownModeButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .systemBrown
        btn.layer.borderWidth = 1.0
        btn.layer.borderColor = UIColor.brown.cgColor
        btn.addTarget(self, action: #selector(updateBackgroundColor(_:)), for: .touchUpInside)
        return btn
    }()
    
    let grayModeButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .darkGray
        btn.layer.borderWidth = 1.0
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.addTarget(self, action: #selector(updateBackgroundColor(_:)), for: .touchUpInside)
        return btn
    }()
    
    let blackModeButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
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
        sv.alignment = .fill
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
    
    lazy var fontPickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()
    
    let darkModeLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Dark mode"
        lbl.font = .systemFont(ofSize: 20)
        lbl.textColor = .label
        lbl.textAlignment = .left
        return lbl
    }()
    
    lazy var darkModeSwitch: UISwitch = {
        let sw = UISwitch()
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.isOn = isDarkMode
        sw.addTarget(self, action: #selector(updateDarkMode(_:)), for: .valueChanged)
        return sw
    }()
    
    init(font: UIFont, withSize size: CGFloat, andWeight weight: UIFont.Weight, isDarkMode: Bool) {
        self.font = font
        self.fontSize = size
        self.fontWeight = weight
        self.isDarkMode = isDarkMode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        fontPickerView.dataSource = self
        fontPickerView.delegate = self
        
        view.addSubviews(fontSizeSlider, minusImageView, plusImageView,
                         weightSegmentedController, stackView, fontPickerView,
                         darkModeLabel, darkModeSwitch)
        setupConstraints()
        
        // устанавливаем значение по умолчанию для пикера
        fontPickerView.selectRow(fonts.firstIndex(of: font) ?? 0, inComponent: 0, animated: true)
    }
    
    func setupConstraints() {
        setupSliderConstraint()
        setupSegmentedControllerConstraint()
        setupStackViewConstraints()
        setupFontPickerViewConstraints()
        setupDarkModeLabelConstraints()
        setupDarkModeSwitchConstraints()
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
    
    func setupFontPickerViewConstraints() {
        fontPickerView.topAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        fontPickerView.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    func setupDarkModeLabelConstraints() {
        darkModeLabel.topAnchor.constraint(equalTo: fontPickerView.bottomAnchor).isActive = true
        darkModeLabel.leadingAnchor.constraint(equalTo: weightSegmentedController.leadingAnchor).isActive = true
    }
    
    func setupDarkModeSwitchConstraints() {
        darkModeSwitch.topAnchor.constraint(equalTo: fontPickerView.bottomAnchor).isActive = true
        darkModeSwitch.trailingAnchor.constraint(equalTo: weightSegmentedController.trailingAnchor).isActive = true
    }
    
    @objc func updateFontSize(_ slider: UISlider) {
        fontSize = CGFloat(slider.value)
        delegate?.updateFontSize(fontSize: fontSize)
    }
    
    // weight доступно только для .systemFont
    @objc func updateFontWeight(_ segmentedController: UISegmentedControl) {
        if font != .systemFont(ofSize: fontSize) {
            segmentedController.reset()
            return
        }
        let weight = fontWeights[segmentedController.selectedSegmentIndex]
        delegate?.updateFontWeight(fontWeight: weight)
    }
    
    @objc func updateBackgroundColor(_ button: UIButton) {
        guard let color = button.backgroundColor else { return }
        let textColor = getTextColor(color.resolvedColor(with: view.traitCollection), traits: view.traitCollection)
        delegate?.updateBackgroundColor(background: color, textColor: textColor)
    }
    
    @objc func updateDarkMode(_ sw: UISwitch) {
        isDarkMode = sw.isOn
        let mode: UIUserInterfaceStyle = isDarkMode ? .dark : .light
        self.overrideUserInterfaceStyle = mode
        delegate?.updateDarkMode(mode: mode)
//        delegate?.updateBackgroundColor(background: isDarkMode ? .black : .white, textColor: isDarkMode ? .white : .black)
    }
    
    func getTextColor(_ background: UIColor, traits: UITraitCollection) -> UIColor {
        switch background {
        case .white, .systemBrown.resolvedColor(with: traits):
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

extension SettingsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fonts.count
    }
}

extension SettingsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fonts[row]?.fontName ?? "unknown"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let tempFont = fonts[row] else { return }
        font = tempFont.withSize(fontSize)
        weightSegmentedController.reset()
        delegate?.updateFont(font: font)
    }
}
