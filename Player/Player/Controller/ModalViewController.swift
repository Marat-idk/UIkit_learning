//
//  ModalViewController.swift
//  Player
//
//  Created by Maxim Raskevich on 25.09.2022.
//

import UIKit
import AVFoundation

class ModalViewController: UIViewController {
    // картинка альбома
    let albumImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    var audioName: String!
    var pathToAudio: String?
    var player: AVAudioPlayer?
    
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
        thumb.backgroundColor = UIColor(red: 201 / 255, green: 243 / 255, blue: 220 / 255, alpha: 1)
        let radius = 20
        thumb.frame = CGRect(x: 0, y: radius / 2, width: radius, height: radius)
        thumb.layer.cornerRadius = CGFloat(radius / 2)
        let renderer = UIGraphicsImageRenderer(bounds: thumb.bounds)
        slider.setThumbImage(renderer.image { rendererContext in
            thumb.layer.render(in: rendererContext.cgContext)
        }, for: .normal)
        return slider
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = audioName
        let atributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor:UIColor.gray]
        navigationController?.navigationBar.titleTextAttributes = atributes

        view.addSubview(albumImage)
        view.addSubview(audioArtistLabel)
        view.addSubview(audioNameLabel)
        view.addSubview(durationSlider)
        setupNavigationController()
        setupAlbumImage()
        let namesOfArtistAndName = audioName.components(separatedBy: "-").map { $0.trimmingCharacters(in: .whitespaces) }
        setupAudioLabel(labelView: audioArtistLabel, equalTo: albumImage, namesOfArtistAndName[0])
        setupAudioLabel(labelView: audioNameLabel, equalTo: audioArtistLabel, namesOfArtistAndName[1])
        setupDurationSlider()

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
        albumImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85).isActive = true
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
        durationSlider.topAnchor.constraint(equalTo: audioNameLabel.bottomAnchor, constant: 60).isActive = true
        durationSlider.leadingAnchor.constraint(equalTo: albumImage.leadingAnchor).isActive = true
        durationSlider.trailingAnchor.constraint(equalTo: albumImage.trailingAnchor).isActive = true
        durationSlider.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
