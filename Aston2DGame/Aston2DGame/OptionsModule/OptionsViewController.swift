//
//  OptionsViewController.swift
//  Aston2DGame
//
//  Created by Александра Тимонова on 21.09.2023.
//

//MARK: - Imports
import UIKit

//MARK: - Constants
private struct PlaneNamesStruct {
    static let firstPlane = "firstPlane"
    static let secondPlane = "secondPlane"
    static let thirdPlane = "thirdPlane"
    
    static func prevName(imageName: String) -> String {
            switch imageName {
            case firstPlane:
                return thirdPlane
            case secondPlane:
                return firstPlane
            case thirdPlane:
                return secondPlane
            default:
                return firstPlane
            }
        }
    
    static func nextName(imageName: String) -> String {
            switch imageName {
            case firstPlane:
                return secondPlane
            case secondPlane:
                return thirdPlane
            case thirdPlane:
                return firstPlane
            default:
                return firstPlane
            }
        }

}

private extension String {
    static let titleNameLabel = "Name"
    static let titleShipImage = "Skin"
    static let titleSpeedLabel = "Speed"
    static let navigationBarTitle = "Options"
    static let incrementSpeedTitle = "+"
    static let decrementSpeedTitle = "-"
}
private extension CGFloat {
    static let multiplier05 = 0.5
    static let multiplier03 = 0.3
    static let termSpeed = 5.0
}

class OptionsViewController: UIViewController {

    //MARK: - IBOutlets
    private var titlePlayerNameLabel: UILabel = {
        let label = UILabel(text: .titleNameLabel, font: UIFont(name: Fonts.fontName, size: Fonts.fontSize20) ?? .systemFont(ofSize: Fonts.fontSize20), color: Colors.orangeColor )
        return label
    }()
    private var playerNameTextField: UITextField = {
        let textField = UITextField()
        textField.font =  UIFont(name: Fonts.fontName, size: Fonts.fontSize20) ?? .systemFont(ofSize: Fonts.fontSize20)
        textField.textColor = Colors.yellowColor
        textField.textAlignment = .center
        return textField
    }()
    private var titleShipImageName: UILabel = {
        let label = UILabel(text: .titleShipImage, font: UIFont(name: Fonts.fontName, size: Fonts.fontSize20) ?? .systemFont(ofSize: Fonts.fontSize20), color: Colors.orangeColor )
        return label
    }()
    private var shipImage: UIImageView = {
        let view = UIImageView()
        return view
    }()
    private var leftArrowShipImageButton: UIButton  = {
        let button = UIButton()
        button.setImage(UIImage(named: ImagesNames.leftArrowButton), for: .normal)
        return button
    }()
    private var rightArrowShipImageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImagesNames.rightArrowButton), for: .normal)
        return button
    }()
    private var titleSpeedGameLabel: UILabel = {
        let label = UILabel(text: .titleSpeedLabel, font: UIFont(name: Fonts.fontName, size: Fonts.fontSize20) ?? .systemFont(ofSize: Fonts.fontSize20), color: Colors.orangeColor )
        return label
    }()
    private var speedGameLabel: UILabel = {
        let label = UILabel(text: "0", font: UIFont(name: Fonts.fontName, size: Fonts.fontSize20) ?? .systemFont(ofSize: Fonts.fontSize20), color: Colors.yellowColor )
        label.textAlignment = .center
        return label
    }()
    private var incrementSpeedButton: UIButton = {
        let button = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Colors.yellowColor,
            .font: UIFont(name: Fonts.fontName, size: Fonts.fontSize25) ?? .systemFont(ofSize: Fonts.fontSize25)
        ]
        let attributedTitle = NSAttributedString(string: .incrementSpeedTitle, attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    private var decrementSpeedButton: UIButton = {
        let button = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Colors.yellowColor,
            .font: UIFont(name: Fonts.fontName, size: Fonts.fontSize25) ?? .systemFont(ofSize: Fonts.fontSize25)
        ]
        let attributedTitle = NSAttributedString(string: .decrementSpeedTitle, attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    //MARK: - lets/vars
    private var navigationBar: CustomNavigationBar!
    private var playerName = "" {
        didSet {
            playerNameTextField.text = playerName
        }
    }
    private var speed = 0.0 {
        didSet {
            speedGameLabel.text = "\(speed)"
        }
    }
    private var planeImageName  = "" {
        didSet {
            shipImage.image = UIImage(named: planeImageName)
        }
    }
    let model = UserDataModel.shared
    
    //MARK: - Lificycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  Colors.purpleColor
        addSubviews()
        setUpUI()
       addTargets()
        playerName = model.playerName
        speed = model.speed
        planeImageName = model.shipImageName
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        navigationBar = CustomNavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: .offset100), title: .navigationBarTitle)
        view.addSubview(navigationBar)
        navigationBar.delegate = self
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        model.setSpeed(speed: speed)
        model.setPalyerName(playerName: playerName)
        model.setShipImageName(shipImageName: planeImageName)
        model.saveData()
    }
    //MARK: - flow funcs
    private func addTargets() {
        leftArrowShipImageButton.addTarget(self, action: #selector(leftArrowShipImageButtonTouched), for: .touchUpInside)
        rightArrowShipImageButton.addTarget(self, action: #selector(rightArrowShipImageButtonTouched), for: .touchUpInside)
        incrementSpeedButton.addTarget(self, action: #selector(incrementSpeedButtonTouched), for: .touchUpInside)
        decrementSpeedButton.addTarget(self, action: #selector(decrementSpeedButtonTouched), for: .touchUpInside)
        playerNameTextField.addTarget(self, action: #selector(playerNameTextFieldEditingDidEnd), for: .editingDidEnd)
    }
    private func addSubviews() {
        view.addSubview(titleShipImageName)
        view.addSubview(titleSpeedGameLabel)
        view.addSubview(titlePlayerNameLabel)
        view.addSubview(incrementSpeedButton)
        view.addSubview(decrementSpeedButton)
        view.addSubview(speedGameLabel)
        view.addSubview(shipImage)
        view.addSubview(leftArrowShipImageButton)
        view.addSubview(rightArrowShipImageButton)
        view.addSubview(playerNameTextField)
    }
    private func setUpUI() {
        titleShipImageName.translatesAutoresizingMaskIntoConstraints = false
        titleSpeedGameLabel.translatesAutoresizingMaskIntoConstraints = false
        titlePlayerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        incrementSpeedButton.translatesAutoresizingMaskIntoConstraints = false
        decrementSpeedButton.translatesAutoresizingMaskIntoConstraints = false
        speedGameLabel.translatesAutoresizingMaskIntoConstraints = false
        shipImage.translatesAutoresizingMaskIntoConstraints = false
        leftArrowShipImageButton.translatesAutoresizingMaskIntoConstraints = false
        rightArrowShipImageButton.translatesAutoresizingMaskIntoConstraints = false
        playerNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titlePlayerNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titlePlayerNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: .offset240)
        ])
        NSLayoutConstraint.activate([
            playerNameTextField.topAnchor.constraint(equalTo: titlePlayerNameLabel.bottomAnchor, constant: .offset24),
            playerNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playerNameTextField.widthAnchor.constraint(equalToConstant: .offset240),
            playerNameTextField.heightAnchor.constraint(equalTo: playerNameTextField.widthAnchor, multiplier: .multiplier03)
        ])
        NSLayoutConstraint.activate([
            titleSpeedGameLabel.topAnchor.constraint(equalTo: playerNameTextField.bottomAnchor, constant: .offset24),
            titleSpeedGameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            speedGameLabel.topAnchor.constraint(equalTo: titleSpeedGameLabel.bottomAnchor, constant: .offset24),
            speedGameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            speedGameLabel.widthAnchor.constraint(equalToConstant: .offset100),
            speedGameLabel.heightAnchor.constraint(equalTo: speedGameLabel.widthAnchor, multiplier: .multiplier05)
        ])
        NSLayoutConstraint.activate([
            incrementSpeedButton.centerYAnchor.constraint(equalTo: speedGameLabel.centerYAnchor),
            incrementSpeedButton.leftAnchor.constraint(equalTo: speedGameLabel.rightAnchor, constant: .offset24),
            incrementSpeedButton.widthAnchor.constraint(equalToConstant: .offset100),
            incrementSpeedButton.heightAnchor.constraint(equalTo: incrementSpeedButton.widthAnchor, multiplier: .multiplier05)
        ])
        NSLayoutConstraint.activate([
            decrementSpeedButton.centerYAnchor.constraint(equalTo: speedGameLabel.centerYAnchor),
            decrementSpeedButton.rightAnchor.constraint(equalTo: speedGameLabel.leftAnchor, constant: -.offset24),
            decrementSpeedButton.widthAnchor.constraint(equalToConstant: .offset100),
            decrementSpeedButton.heightAnchor.constraint(equalTo: decrementSpeedButton.widthAnchor, multiplier: .multiplier05)
        ])
        NSLayoutConstraint.activate([
            titleShipImageName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleShipImageName.topAnchor.constraint(equalTo: speedGameLabel.bottomAnchor, constant: .offset24)
        ])
        NSLayoutConstraint.activate([
            shipImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shipImage.topAnchor.constraint(equalTo: titleShipImageName.bottomAnchor, constant: .offset24),
            shipImage.widthAnchor.constraint(equalToConstant: .offset100),
            shipImage.heightAnchor.constraint(equalTo: shipImage.widthAnchor, multiplier: 1)
        ])
        NSLayoutConstraint.activate([
            rightArrowShipImageButton.centerYAnchor.constraint(equalTo: shipImage.centerYAnchor),
            rightArrowShipImageButton.leftAnchor.constraint(equalTo: shipImage.rightAnchor, constant: .offset24),
            rightArrowShipImageButton.widthAnchor.constraint(equalToConstant: 50),
            rightArrowShipImageButton.heightAnchor.constraint(equalTo: rightArrowShipImageButton.widthAnchor, multiplier: 1)
        ])
        NSLayoutConstraint.activate([
            leftArrowShipImageButton.centerYAnchor.constraint(equalTo: shipImage.centerYAnchor),
            leftArrowShipImageButton.rightAnchor.constraint(equalTo: shipImage.leftAnchor, constant: -.offset24),
            leftArrowShipImageButton.widthAnchor.constraint(equalToConstant: 50),
            leftArrowShipImageButton.heightAnchor.constraint(equalTo: leftArrowShipImageButton.widthAnchor, multiplier: 1)
        ])
        
    }

    @objc private func leftArrowShipImageButtonTouched(sender: UIButton){
        planeImageName = PlaneNamesStruct.prevName(imageName: planeImageName)
    }
    @objc private func rightArrowShipImageButtonTouched(sender: UIButton){
        planeImageName = PlaneNamesStruct.nextName(imageName: planeImageName)
    }
    @objc private func incrementSpeedButtonTouched(sender: UIButton){
        speed += CGFloat.termSpeed
    }
    @objc private func decrementSpeedButtonTouched(sender: UIButton){
        if speed > CGFloat.termSpeed {
            speed -= CGFloat.termSpeed
        }
    }
    @objc private func playerNameTextFieldEditingDidEnd(sender: UITextField){
        if sender.hasText {
            playerName = sender.text ?? "Error"
        }
    }

}
//MARK: - CustomNavigationBarDelegate
extension OptionsViewController: CustomNavigationBarDelegate {
    func leftBarButtonTouched() {
        self.navigationController?.popViewController(animated: true)
    }
}
