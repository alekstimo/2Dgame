//
//  CustomNavigationBar.swift
//  Aston2DGame
//
//  Created by Александра Тимонова on 22.09.2023.
//

import UIKit


protocol CustomNavigationBarDelegate {
    func leftBarButtonTouched()
}
class CustomNavigationBar: UIView {

    private var titleLabel: UILabel = {
        let label = UILabel(text: " ", font: UIFont(name: Fonts.fontName, size: Fonts.fontSize25) ?? .systemFont(ofSize: Fonts.fontSize25), color:  Colors.lightPinkColor)
        return label
    }()
    private var leftBarButton: UIButton = {
        let button = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor:  Colors.darkVioletColor,
            .font: UIFont(name: Fonts.fontName, size: Fonts.fontSize15) ?? .systemFont(ofSize: Fonts.fontSize15)
        ]
        let attributedTitle = NSAttributedString(string: "Back", attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    var delegate: CustomNavigationBarDelegate?
    required init(frame: CGRect, title: String = " ") {
        super.init(frame: frame)
        self.backgroundColor = Colors.darkVioletColor.withAlphaComponent(0.2)
        titleLabel.text = title
        leftBarButton.addTarget(self, action: #selector(leftBarButtonTouched), for: .touchUpInside)
        self.addSubview(titleLabel)
        self.addSubview(leftBarButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        leftBarButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -.offset10)
        ])
        
        NSLayoutConstraint.activate([
            leftBarButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -.offset10),
            leftBarButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: .offset24),
            leftBarButton.rightAnchor.constraint(lessThanOrEqualTo: titleLabel.leftAnchor, constant: -.offset10 )
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func leftBarButtonTouched(sender: UIButton) {
        delegate?.leftBarButtonTouched()
    }

}
