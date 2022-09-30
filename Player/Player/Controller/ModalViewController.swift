//
//  ModalViewController.swift
//  Player
//
//  Created by Maxim Raskevich on 25.09.2022.
//

import UIKit
import AVFoundation

class AudioViewController: UIViewController {
    
    weak var delegate: PlaylistViewController?
    
    // картинка альбома
    var albumImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    var audioName: String!
    var pathToAudio: String?
    var player: AVAudioPlayer?
    var timer = Timer()
    
    let audioArtistLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.font = .boldSystemFont(ofSize: 20)
        return lbl
    }()
    
    let audioNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.textColor = .lightGray
        lbl.font = .systemFont(ofSize: 18)
        return lbl
    }()
        
    let durationSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = UIColor(red: 113 / 255, green: 222 / 255, blue: 121 / 255, alpha: 1)
        slider.maximumTrackTintColor = UIColor(red: 201 / 255, green: 243 / 255, blue: 220 / 255, alpha: 1)
        
        // кастомный thumb
        let thumb = UIView()
        thumb.backgroundColor = UIColor(red: 113 / 255, green: 222 / 255, blue: 121 / 255, alpha: 1)
        let radius = 20
        thumb.frame = CGRect(x: 0, y: radius / 2, width: radius, height: radius)
        thumb.layer.cornerRadius = CGFloat(radius / 2)
        let renderer = UIGraphicsImageRenderer(bounds: thumb.bounds)
        slider.setThumbImage(renderer.image { rendererContext in
            thumb.layer.render(in: rendererContext.cgContext)
        }, for: .normal)
        // таргет
        slider.addTarget(self, action: #selector(changeCurrentTime(_:)), for: .valueChanged)
        return slider
    }()
    
    let audioCurrentLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "00:00"
        lbl.textAlignment = .left
        lbl.font = .systemFont(ofSize: 14)
        lbl.textColor = .lightGray
        return lbl
    }()
    
    let audioToEndLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "00:00"
        lbl.textAlignment = .right
        lbl.font = .systemFont(ofSize: 14)
        lbl.textColor = .lightGray
        return lbl
    }()
    
    let playPauseButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "pause_button")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = UIColor(red: 30 / 255, green: 30 / 255, blue: 30 / 255, alpha: 1)
        btn.addTarget(self, action: #selector(playPauseAudio(_:)), for: .touchUpInside)
        return btn
    }()
    
    let prevButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "prev_button")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = UIColor(red: 30 / 255, green: 30 / 255, blue: 30 / 255, alpha: 1)
        btn.addTarget(self, action: #selector(changeAudio), for: .touchUpInside)
        return btn
    }()
    
    let nextButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "next_button")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = UIColor(red: 30 / 255, green: 30 / 255, blue: 30 / 255, alpha: 1)
        btn.addTarget(self, action: #selector(changeAudio), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = audioName
        let atributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor:UIColor.gray]
        navigationController?.navigationBar.titleTextAttributes = atributes
        
        loadAudio()
        setupSubViews()
        setupNavigationController()
        startPlaying()
    }
    
    func loadAudio() {
        if let path = pathToAudio {
            player = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
        }
    }
    
    // добавляем элементы вью и настраиваем их с помощью ограничений и тд
    func setupSubViews() {
        view.addSubview(albumImage)
        view.addSubview(audioArtistLabel)
        view.addSubview(audioNameLabel)
        view.addSubview(durationSlider)
        view.addSubview(audioCurrentLabel)
        view.addSubview(audioToEndLabel)
        view.addSubview(playPauseButton)
        view.addSubview(prevButton)
        view.addSubview(nextButton)
        setupAlbumImage()
        let namesOfArtistAndName = audioName.components(separatedBy: "-").map { $0.trimmingCharacters(in: .whitespaces) }
        setupAudioLabel(labelView: audioArtistLabel, equalTo: albumImage, namesOfArtistAndName[0])
        setupAudioLabel(labelView: audioNameLabel, equalTo: audioArtistLabel, namesOfArtistAndName[1])
        setupDurationSlider()
        
        setupAudioLengthLabel(label: audioCurrentLabel)
        setupAudioLengthLabel(label: audioToEndLabel)
        setupManagePlayrButton(button: playPauseButton)
        setupManagePlayrButton(button: prevButton)
        setupManagePlayrButton(button: nextButton)
    }
    
    func startPlaying() {
        player?.play()
        timer = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(updateCurrentTime), userInfo: nil, repeats: true)
    }
    
    @objc func playPauseAudio(_ sender: UIButton) {
        if let player = player {
            if player.isPlaying {
                player.pause()
                sender.setImage(UIImage(named: "play_button")?.withRenderingMode(.alwaysTemplate), for: .normal)
            } else {
                player.play()
                sender.setImage(UIImage(named: "pause_button")?.withRenderingMode(.alwaysTemplate), for: .normal)
            }
        }
    }
    
    @objc func changeAudio() {
        if let (name, img, path) = delegate?.update(audioName: audioName) {
            audioName = name
            let namesOfArtistAndName = audioName.components(separatedBy: "-").map { $0.trimmingCharacters(in: .whitespaces) }
            audioArtistLabel.text = namesOfArtistAndName[0]
            audioNameLabel.text = namesOfArtistAndName[1]
            albumImage.image = img
            pathToAudio = path
            loadAudio()
            player?.play()
        }
    }
    
    @objc func updateCurrentTime() {
        if let player = player {
            durationSlider.value = Float(player.currentTime)
            
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.minute, .second]
            formatter.zeroFormattingBehavior = .pad
            audioCurrentLabel.text = formatter.string(from: TimeInterval(player.currentTime))
            audioToEndLabel.text = formatter.string(from: TimeInterval(player.duration - player.currentTime))!
        }
    }
    
    @objc func changeCurrentTime(_ sender: UISlider) {
        if let player = player {
            player.currentTime = TimeInterval(durationSlider.value)
        }
    }
    
    // установка нав баров
    func setupNavigationController() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "down_arrow"), style: .plain, target: self, action: #selector(cancel(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share(_:)))
    }
    
    @objc func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        player?.stop()
    }
    
    @objc func share(_ sender: UIBarButtonItem) {
        let item = URL(fileURLWithPath: pathToAudio!)
        let shareActivity = UIActivityViewController(activityItems: [item], applicationActivities: nil)
        
        shareActivity.completionWithItemsHandler = {_, flag, _, _ in
            if flag {
                print("Shared!")
            }
        }
        
        present(shareActivity, animated: true, completion: nil)
    }
    
    // округление изображения
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        albumImage.layer.cornerRadius = 15.0
        albumImage.clipsToBounds = true
    }
    
    func setupAlbumImage() {
        albumImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        albumImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        albumImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        albumImage.heightAnchor.constraint(equalTo: albumImage.widthAnchor).isActive = true
    }

    func setupAudioLabel(labelView lbl: UILabel, equalTo: UIView, _ str: String) {
        lbl.text = str
        if lbl == audioArtistLabel {
            lbl.topAnchor.constraint(equalTo: equalTo.bottomAnchor, constant: 20).isActive = true
        } else {
            lbl.topAnchor.constraint(equalTo: equalTo.bottomAnchor).isActive = true
        }
        lbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lbl.widthAnchor.constraint(equalToConstant: 150).isActive = true
        lbl.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    func setupDurationSlider() {
        if let duration = player?.duration {
            durationSlider.maximumValue = Float(duration)
        }
        durationSlider.topAnchor.constraint(equalTo: audioNameLabel.bottomAnchor, constant: 60).isActive = true
        durationSlider.leadingAnchor.constraint(equalTo: albumImage.leadingAnchor).isActive = true
        durationSlider.trailingAnchor.constraint(equalTo: albumImage.trailingAnchor).isActive = true
        durationSlider.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func setupAudioLengthLabel(label: UILabel) {
        if label == audioCurrentLabel {
            label.leadingAnchor.constraint(equalTo: durationSlider.leadingAnchor).isActive = true
        } else {
            label.trailingAnchor.constraint(equalTo: durationSlider.trailingAnchor).isActive = true
        }
        label.bottomAnchor.constraint(equalTo: durationSlider.topAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: 60).isActive = true
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func setupManagePlayrButton(button: UIButton) {
        button.topAnchor.constraint(equalTo: durationSlider.bottomAnchor, constant: 40).isActive = true
        switch button {
        case playPauseButton:
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        case prevButton:
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100).isActive = true
        case nextButton:
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100).isActive = true
        default:
            return
        }
        
    }
}
