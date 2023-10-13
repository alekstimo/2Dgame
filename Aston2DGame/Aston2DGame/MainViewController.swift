//
//  MainViewController.swift
//  Aston2DGame
//
//  Created by Александра Тимонова on 19.09.2023.
//

import UIKit

//MARK: - Constants
private extension String {
    static let startButtonTitle = "START"
    static let optionsButtonTitle = "OPTIONS"
    static let ratingButtonTitle = "RATING"
    static let nameBackgroungImageView = "menuBackgroungImage"
    static let gameName = "Fly?Crash"
}
private extension CGFloat {
    static let widthMultiplierForMenuBackground = 0.7
    static let heightMultiplierForMenuBackground = 1.5
    static let widthMultiplierForButton = 0.7
    static let heightMultiplierForButton = 0.5
}

class MainViewController: UIViewController  {
   


    //MARK: - IBOutlets
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = .gameName
        label.font = UIFont(name: Fonts.fontName, size: Fonts.fontSize35)
        label.textColor = Colors.yellowColor
        

        return label
    }()
    
    private var startButton: UIButton = {
        let button = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor:  Colors.yellowColor,
            .font: UIFont(name: Fonts.fontName, size: Fonts.fontSize25) ?? .systemFont(ofSize: Fonts.fontSize25)
        ]
        let attributedTitle = NSAttributedString(string: .startButtonTitle, attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    private var optionsButton: UIButton = {
        let button = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor:  Colors.yellowColor,
            .font: UIFont(name: Fonts.fontName, size: Fonts.fontSize25) ?? .systemFont(ofSize: Fonts.fontSize25)
        ]
        let attributedTitle = NSAttributedString(string: .optionsButtonTitle, attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    private var ratingButton: UIButton = {
        let button = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor:  Colors.yellowColor,
            .font: UIFont(name: Fonts.fontName, size: Fonts.fontSize25) ?? .systemFont(ofSize: Fonts.fontSize25)
        ]
        let attributedTitle = NSAttributedString(string: .ratingButtonTitle, attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    private var menuBackgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: .nameBackgroungImageView)
        return view
    }()
    
    //MARK: - Life cycles funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  Colors.darkVioletColor
        addSubviews()
        setUpUI()
        
    }
    
    
    //MARK: - Flow funcs
    private func addSubviews() {
        view.addSubview(menuBackgroundImageView)
        view.addSubview(titleLabel)
        view.addSubview(startButton)
        view.addSubview(optionsButton)
        view.addSubview(ratingButton)
        
        
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        optionsButton.addTarget(self, action: #selector(optionsButtonPressed), for: .touchUpInside)
        ratingButton.addTarget(self, action: #selector(ratingButtonPressed), for: .touchUpInside)
        
    }
    private func setUpUI(){
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        menuBackgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        optionsButton.translatesAutoresizingMaskIntoConstraints = false
        ratingButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        //Title
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: menuBackgroundImageView.topAnchor, constant: -.offset24)

        ])
        
        //Background
        NSLayoutConstraint.activate([
            menuBackgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            menuBackgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            menuBackgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:  .widthMultiplierForMenuBackground),
            menuBackgroundImageView.heightAnchor.constraint(equalTo: menuBackgroundImageView.widthAnchor, multiplier: .heightMultiplierForMenuBackground)
        ])
        
        //Options
        NSLayoutConstraint.activate([
            optionsButton.centerXAnchor.constraint(equalTo: menuBackgroundImageView.centerXAnchor),
            optionsButton.centerYAnchor.constraint(equalTo: menuBackgroundImageView.centerYAnchor),
            optionsButton.widthAnchor.constraint(equalTo: menuBackgroundImageView.widthAnchor,multiplier: .widthMultiplierForButton ),
            optionsButton.heightAnchor.constraint(equalTo: startButton.widthAnchor, multiplier: .heightMultiplierForButton)
        ])
        
        //Start
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: menuBackgroundImageView.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: optionsButton.topAnchor, constant: -.offset24),
            startButton.widthAnchor.constraint(equalTo: menuBackgroundImageView.widthAnchor,multiplier: .widthMultiplierForButton ),
            startButton.heightAnchor.constraint(equalTo: startButton.widthAnchor, multiplier: .heightMultiplierForButton)
        ])
        //Options
        NSLayoutConstraint.activate([
            optionsButton.centerXAnchor.constraint(equalTo: menuBackgroundImageView.centerXAnchor),
            optionsButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: .offset24),
            optionsButton.widthAnchor.constraint(equalTo: menuBackgroundImageView.widthAnchor,multiplier: .widthMultiplierForButton ),
            optionsButton.heightAnchor.constraint(equalTo: startButton.widthAnchor, multiplier: .heightMultiplierForButton)
        ])
        //Rating
        NSLayoutConstraint.activate([
            ratingButton.centerXAnchor.constraint(equalTo: menuBackgroundImageView.centerXAnchor),
            ratingButton.topAnchor.constraint(equalTo: optionsButton.bottomAnchor, constant: .offset24),
            ratingButton.widthAnchor.constraint(equalTo: menuBackgroundImageView.widthAnchor,multiplier: .widthMultiplierForButton ),
            ratingButton.heightAnchor.constraint(equalTo: startButton.widthAnchor, multiplier: .heightMultiplierForButton)
        ])
    }
    @objc func startButtonPressed(sender: UIButton) {
        
        let vc = GameViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func optionsButtonPressed(sender: UIButton) {
       
        let vc = OptionsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func ratingButtonPressed(sender: UIButton) {
        
        let vc = RatingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}
