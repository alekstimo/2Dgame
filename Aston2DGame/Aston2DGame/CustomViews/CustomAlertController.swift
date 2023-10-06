//
//  CustomAlertController.swift
//  Aston2DGame
//
//  Created by Александра Тимонова on 21.09.2023.
//

import Foundation
import UIKit

protocol  CustomAlertViewDelegate {
    func restartButtonTouched()
    func backToMenuButtonTouched()
}
class CustomAlertView: UIView {
    
    private var titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Game over!"
        label.font = UIFont(name: Fonts.fontName, size: 25)
        label.textColor =  Colors.yellowColor
        return label
    }()
     var backToMenuButton: UIButton = {
       let button = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Colors.darkVioletColor,
            .font: UIFont(name: Fonts.fontName, size: Fonts.fontSize20) ?? .systemFont(ofSize: Fonts.fontSize25)
        ]
        let attributedTitle = NSAttributedString(string: "Back to menu", attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
     var restartButton: UIButton = {
       let button = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Colors.lightPinkColor,
            .font: UIFont(name: Fonts.fontName, size: Fonts.fontSize20) ?? .systemFont(ofSize: Fonts.fontSize25)
        ]
        let attributedTitle = NSAttributedString(string: "Restart", attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    private var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "menuBackgroungImage")
        view.alpha = 0.8
        return view
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.addSubview(backgroundImage)
        self.addSubview(restartButton)
        self.addSubview(backToMenuButton)
        self.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        restartButton.translatesAutoresizingMaskIntoConstraints = false
        backToMenuButton.translatesAutoresizingMaskIntoConstraints = false
        
        //Background
        NSLayoutConstraint.activate([
            backgroundImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            backgroundImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            backgroundImage.widthAnchor.constraint(equalTo: self.widthAnchor),
            backgroundImage.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: .offset100)
        ])
        NSLayoutConstraint.activate([
            restartButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            restartButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .offset24),
            restartButton.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.8),
            restartButton.heightAnchor.constraint(equalTo: restartButton.widthAnchor,multiplier: 0.3)
        ])
        NSLayoutConstraint.activate([
            backToMenuButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            backToMenuButton.topAnchor.constraint(equalTo: restartButton.bottomAnchor, constant: .offset24),
            backToMenuButton.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.8),
            backToMenuButton.heightAnchor.constraint(equalTo: backToMenuButton.widthAnchor,multiplier: 0.3)
        ])
        
        
        }
    
   
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
}



class CustomAlertController: UIViewController {
    
    
    private var customView: CustomAlertView!
    var delegate: CustomAlertViewDelegate?
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        customView = CustomAlertView(frame: CGRect(x: Int(self.view.frame.midX - 150), y: Int(self.view.frame.midY - 200), width: 300, height: 400))
        self.view.addSubview(customView)
        customView.backToMenuButton.addTarget(self, action: #selector(backToMenuButtonTouched), for: .touchUpInside)
        customView.restartButton.addTarget(self, action: #selector(restartButtonTouched), for: .touchUpInside)
    }
    @objc private func backToMenuButtonTouched(sender: UIButton){
        delegate?.backToMenuButtonTouched()
    }
    @objc private func restartButtonTouched(sender: UIButton){
        delegate?.restartButtonTouched()
    }
}

