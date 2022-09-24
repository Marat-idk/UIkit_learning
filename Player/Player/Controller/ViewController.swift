//
//  ViewController.swift
//  Player
//
//  Created by Marat on 20.09.2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var firstAudioBtn: CustomUIButton!
    var secondAudioBtn: CustomUIButton!
    
    var firstAudioLbl: UILabel!
    var secondAudioLbl: UILabel!
    
//    var player = AVAudioPlayer()
//    var timer: Timer?
//
//    lazy var thumbView: UIView = {
//        let thumb = UIView()
//        thumb.backgroundColor = UIColor(red: 112 / 255, green: 216 / 255, blue: 94 / 255, alpha: 1)
//        return thumb
//    }()
//
//    let sliderDuration: UISlider = {
//        let slider = UISlider()
//        slider.frame = CGRect(x: 0, y: 50, width: 350, height: 40)
//        //slider.center.x = view.center.x
//        slider.addTarget(self, action: #selector(changeCurrentTime(_:)), for: .valueChanged)
//        return slider
//    }()
//
//    let sliderValue: UISlider = {
//        let slider = UISlider(frame: .init(x: 0, y: 100, width: 350, height: 40))
//        slider.addTarget(self, action: #selector(changeValue(_:)), for: .valueChanged)
//        slider.value = AVAudioSession.sharedInstance().outputVolume
//        slider.maximumValue = 1.0
//        return slider
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Plist"
        // изменение шрифта и цвета заголовка
        let atributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24), NSAttributedString.Key.foregroundColor:UIColor.systemBlue]
        navigationController?.navigationBar.titleTextAttributes = atributes
        
        
        firstAudioBtn = setupAudioCustomButton(title: "Дурной Вкус - Навсегда", imgNamed: "durnoy_vkus")
        secondAudioBtn = setupAudioCustomButton(title: "Дурной Вкус - Пластинки", imgNamed: "plastinki")
        do {
            try firstAudioLbl = setupAudioLabel(audioName: firstAudioBtn.titleLabel!.text!)
        } catch {
            print("Error")
        }
        
        
        
        view.addSubview(firstAudioBtn)
        view.addSubview(secondAudioBtn)
        view.addSubview(firstAudioLbl)
        setupAudioButtonPosition(button: firstAudioBtn, equalTo: view)
        setupAudioButtonPosition(button: secondAudioBtn, equalTo: firstAudioBtn)
        setupAudioLabelPosition(label: firstAudioLbl, button: firstAudioBtn)
//        view.backgroundColor = .white
//        // Do any additional setup after loading the view.
//        
//        sliderDuration.center.x = view.center.x
//        sliderDuration.setThumbImage(thumbImage(radius: 15), for: .normal)
//        sliderDuration.minimumTrackTintColor = UIColor(red: 112 / 255, green: 216 / 255, blue: 94 / 255, alpha: 1)
//        sliderDuration.maximumTrackTintColor = UIColor(red: 201 / 255, green: 243 / 255, blue: 220 / 255, alpha: 1)
//        self.view.addSubview(sliderDuration)
//        
//        sliderValue.center.x = view.center.x
//        self.view.addSubview(sliderValue)
        
        
//        do {
//            if let path = Bundle.main.path(forResource: "Durnojj_Vkus_Navsegda", ofType: "mp3") {
//                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
//                sliderDuration.maximumValue = Float(player.duration)
//                //sliderValue.maximumValue = player.volume
//            }
//        } catch {
//            print("Error")
//        }
    }
    
    // настройка батн для аудио
    func setupAudioCustomButton(title: String, imgNamed: String) -> CustomUIButton {
        var filled = UIButton.Configuration.filled()
        filled.baseBackgroundColor = .white
        // установка шрифта и цвета заголовка
        filled.attributedTitle = AttributedString(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedString.Key.foregroundColor:UIColor.black]))
        // установка картинки для батн
        if let image = UIImage(named: imgNamed) {
            filled.image = image
        }
        let btn = CustomUIButton(configuration: filled, primaryAction: nil)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.imageView?.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        btn.underlined(color: .lightGray)

        return btn
    }
    // верстка батн
    func setupAudioButtonPosition(button btn: UIButton, equalTo anotherView: UIView) {
        if anotherView is UIButton {
            btn.topAnchor.constraint(equalTo: anotherView.bottomAnchor, constant: 10).isActive = true
        } else {
            btn.topAnchor.constraint(equalTo: anotherView.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        }
        btn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        btn.imageView?.leadingAnchor.constraint(equalTo: btn.leadingAnchor).isActive = true
        btn.imageView?.widthAnchor.constraint(equalTo: btn.heightAnchor, multiplier: 0.85).isActive = true
        btn.imageView?.heightAnchor.constraint(equalTo: btn.heightAnchor, multiplier: 0.85).isActive = true
        
        btn.titleLabel?.leadingAnchor.constraint(equalTo: btn.imageView!.trailingAnchor, constant: 10).isActive = true
        btn.titleLabel?.centerYAnchor.constraint(equalTo: btn.centerYAnchor).isActive = true
    }
    
    func setupAudioLabel(audioName: String) throws -> UILabel {
        // получаем файл
        let path = Bundle.main.path(forResource: "Durnojj_Vkus_Navsegda", ofType: "mp3")
        let audio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path!))
        // получаем длительность аудио в секундах и преобразуем в m:s
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]

        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = formatter.string(from: TimeInterval(audio.duration))!
        return lbl
    }
    
    func setupAudioLabelPosition(label lbl: UILabel, button btn: UIButton) {
        lbl.centerYAnchor.constraint(equalTo: btn.centerYAnchor).isActive = true
        lbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        lbl.widthAnchor.constraint(equalToConstant: 100).isActive = true
        lbl.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
//
//    @IBAction func startButton(_ sender: Any) {
//        player.play()
//        timer = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(updateSliderCurrentTime), userInfo: nil, repeats: true)
//    }
//
//
//    @IBAction func stopButton(_ sender: Any) {
//        player.pause()
//    }
//
//    func thumbImage(radius: CGFloat) -> UIImage {
//        thumbView.frame = CGRect(x: 0, y: radius / 2, width: radius, height: radius)
//        thumbView.layer.cornerRadius = radius / 2
//        let renderer = UIGraphicsImageRenderer(bounds: thumbView.bounds)
//        return renderer.image { rendererContext in
//            thumbView.layer.render(in: rendererContext.cgContext)
//        }
//    }
//
//    @objc func changeCurrentTime(_ sender: UISlider) {
//        player.currentTime = TimeInterval(sliderDuration.value)
//        //if !player.isPlaying { player.play(); print("now is playing") }
//    }
//
//    @objc func updateSliderCurrentTime() {
//        sliderDuration.value = Float(player.currentTime)
//    }
//
//    @objc func changeValue(_ sender: UISlider) {
//        MPVolumeView.setVolume(sliderValue.value)
//    }
    
}

//extension MPVolumeView {
//  static func setVolume(_ volume: Float) {
//    let volumeView = MPVolumeView()
//    let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider
//
//    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
//      slider?.value = volume
//    }
//  }
//}

// смена цвета заднего фона при нажатии
class CustomUIButton: UIButton {
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .systemGray4 : .white
        }
    }
}

extension UIButton {
    // UIButton с нижним подчеркиванием
    func underlined(color: UIColor) {
        let borderView = UIView()
        borderView.backgroundColor = color
        borderView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(borderView)
        NSLayoutConstraint.activate(
            [
                borderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                borderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                borderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                borderView.heightAnchor.constraint(equalToConstant: 1.0)
            ]
        )
    }
}
