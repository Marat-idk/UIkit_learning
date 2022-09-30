//
//  ViewController.swift
//  Player
//
//  Created by Marat on 20.09.2022.
//

import UIKit
import AVFoundation

protocol PlaylistViewControllerProtocol {
    func update(audioName: String) -> (String, UIImage, String)?
}

class PlaylistViewController: UIViewController {
    
    var firstAudioBtn: CustomUIButton!
    var secondAudioBtn: CustomUIButton!
    
    var firstAudioLbl: UILabel!
    var secondAudioLbl: UILabel!
    
    var playlist = ["Дурной Вкус - Навсегда", "Дурной Вкус - Пластинки"]
    
    //var player = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Plist"
        // изменение шрифта и цвета заголовка
        let atributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24), NSAttributedString.Key.foregroundColor:UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = atributes
        
        
        setupSubViews()
    }
    
    func setupSubViews() {
        firstAudioBtn = setupAudioCustomButton(title: playlist[0])
        secondAudioBtn = setupAudioCustomButton(title: playlist[1])
        do {
            try firstAudioLbl = setupAudioLabel(audioName: firstAudioBtn.titleLabel!.text!)
            try secondAudioLbl = setupAudioLabel(audioName: secondAudioBtn.titleLabel!.text!)
            
            view.addSubview(firstAudioBtn)
            view.addSubview(secondAudioBtn)
            view.addSubview(firstAudioLbl)
            view.addSubview(secondAudioLbl)
            setupAudioButtonPosition(button: firstAudioBtn, equalTo: view)
            setupAudioButtonPosition(button: secondAudioBtn, equalTo: firstAudioBtn)
            setupAudioLabelPosition(label: firstAudioLbl, button: firstAudioBtn)
            setupAudioLabelPosition(label: secondAudioLbl, button: secondAudioBtn)
        } catch {
            print("Error")
        }
    }
    
    // настройка батн для аудио
    func setupAudioCustomButton(title: String) -> CustomUIButton {
        var filled = UIButton.Configuration.filled()
        filled.baseBackgroundColor = .white
        // установка шрифта и цвета заголовка
        filled.attributedTitle = AttributedString(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedString.Key.foregroundColor:UIColor.black]))
        // установка картинки для батн
        if let image = try? getAlbumImage(name: title) {
            filled.image = image
        }
        let btn = CustomUIButton(configuration: filled, primaryAction: nil)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.imageView?.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        btn.underlined(color: .lightGray)
        btn.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        return btn
    }
    
    @objc func buttonTapped(_ sender: UIButton) throws {
        performSegue(withIdentifier: "toModal", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toModal" {
            if let destVC = segue.destination as? UINavigationController,
                let dvc = destVC.topViewController as? AudioViewController,
                let sender = sender as? UIButton{
                dvc.delegate = self
                dvc.audioName = sender.titleLabel!.text!
                dvc.albumImage.image = try? getAlbumImage(name: dvc.audioName)
                dvc.pathToAudio = try? getPathToFile(name: sender.titleLabel!.text!)
            }
        }
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
        let path  = try getPathToFile(name: audioName)
        let audio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
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
    
    func getAlbumImage(name: String) throws -> UIImage {
        var image: UIImage!
        switch name {
        case "Дурной Вкус - Навсегда":
            image = UIImage(named: "durnoy_vkus")
        case "Дурной Вкус - Пластинки":
            image = UIImage(named: "plastinki")
        default:
            throw ErrorLoadMusic.invalidFile("No such image")
        }
        return image
    }
    
    // получаем путь к файл
    func getPathToFile(name: String) throws -> String {
        var path: String?
        switch name {
        case "Дурной Вкус - Навсегда":
            path = Bundle.main.path(forResource: "Durnojj_Vkus_Navsegda", ofType: "mp3")
        case "Дурной Вкус - Пластинки":
            path = Bundle.main.path(forResource: "Plastinki", ofType: "mp3")
        default:
            throw ErrorLoadMusic.invalidFile("No such file")
            
        }
        return path!
    }
}

extension PlaylistViewController: PlaylistViewControllerProtocol {
    func update(audioName: String) -> (String, UIImage, String)? {
        var audio: String
        switch audioName {
        case playlist[0]:
            audio = playlist[1]
            return (audio, try! getAlbumImage(name: audio), try! getPathToFile(name: audio))
        case playlist[1]:
            audio = playlist[0]
            return (audio, try! getAlbumImage(name: audio), try! getPathToFile(name: audio))
        default:
            return nil
        }
        
    }
}

enum ErrorLoadMusic: Error {
    case invalidFile(String)
}
    
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
