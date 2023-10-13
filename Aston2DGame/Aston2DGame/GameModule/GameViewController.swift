//
//  GameViewController.swift
//  Aston2DGame
//
//  Created by Александара Тимонова on 05.09.2023.
//

//MARK: - Inputs
import UIKit

//MARK: - Constants
private extension CGFloat {
    static let multiplierWidth = 0.2
    static let countOfBackgroundViews = 2
    static let scoreForFlyby = 1
    static let exploreAnimationDelay = 0.1
    static let sizeOfBackgroundViews = 50.0
    static let alphaForBackground = 0.002
}


class GameViewController: UIViewController {

    //MARK: - IBOutlets
    private var exploreImage: UIImageView = {
        return UIImageView(image: UIImage(named: "explore1"))
    }()
    private var backgroundViews: [UIImageView] = {
        var views: [UIImageView] = []
        for _ in 0..<CGFloat.countOfBackgroundViews {
            let view = UIImageView()
            view.image = UIImage(named: ImagesNames.star)
            views.append(view)
        }
        return views
    }()
    private var backgroundViewColored: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.backgroundLightColor
        view.alpha = 0
        return view
    }()
    
    private var UFOView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: ImagesNames.meteor)
        return view
    }()
    
    private var planeView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private var moveLeftButton: UIButton = {
        return UIButton()
    }()
    
    private var moveRightButton: UIButton = {
        return UIButton()
    }()
    
    private var scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.fontName, size: Fonts.fontSize25)
        label.textColor = Colors.yellowColor
        return label
        
    }()
    
    var score: Int = 0 {
        didSet {
            scoreLabel.text = String(score)
        }
    }
    
    //MARK: - Lets/Vars
    private let model = UserDataModel.shared
    private let imageNames = ["explore1", "explore2", "explore3","explore4","explore5","explore6"]
    private var timer: Timer?
    var imageIndex = 0

    
    //MARK: - Lificycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.darkVioletColor
        score = 0
        addSubviews()
        setUpUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        positionUFO()
        navigationController?.navigationBar.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateUFO()
        animateBackground()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        model.saveData()
    }
    //MARK: - Flow funcs

    private func addSubviews() {
        view.addSubview(backgroundViewColored)
        for backgroundView in backgroundViews {
            view.addSubview(backgroundView)
        }
      
        view.addSubview(UFOView)
        view.addSubview(planeView)
        view.addSubview(moveLeftButton)
        view.addSubview(moveRightButton)
        view.addSubview(scoreLabel)
        
        moveRightButton.addTarget(self, action: #selector(rightButtonPressed), for: .touchUpInside)
    
        moveLeftButton.addTarget(self, action: #selector(leftButtonPressed), for: .touchUpInside)
        
        let leftLongPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(leftButtonPressed))
        leftLongPressGesture.minimumPressDuration = 0.1
        moveLeftButton.addGestureRecognizer(leftLongPressGesture)

        let rightLongPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(rightButtonPressed))
        rightLongPressGesture.minimumPressDuration = 0.1
        moveRightButton.addGestureRecognizer(rightLongPressGesture)

        
        exploreImage.image = UIImage(named: imageNames[0])
    }
   
    @objc func leftButtonPressed() {
        if planeView.frame.origin.x > .offset10 {
            planeView.frame.origin.x -= .offset10
        }
    }

    @objc func rightButtonPressed() {
        if planeView.frame.maxX < view.frame.maxX {
            planeView.frame.origin.x += .offset10
        }
    }
    @objc func updateImage() {
        if let image = UIImage(named: imageNames[imageIndex]) {
            exploreImage.image = image
            imageIndex += 1
            if imageIndex >= imageNames.count {
                timer?.invalidate()
                showAlert()
                
            }
        }
    }
   
}

//MARK: - Extensions
private extension GameViewController {
     func setUpUI() {
        let width = Int(view.frame.width * .multiplierWidth)
        let ufoFrame = CGRect(x: 0, y: 0, width: width, height: width * 2)
        UFOView.frame = ufoFrame
        planeView.image = UIImage(named: model.shipImageName)
        
        let planeFrame = CGRect(x: Int(view.frame.midX) - width / 2, y: Int(view.frame.maxY - .offset240), width: width, height: width)
        planeView.frame = planeFrame
        
        let backgroundFrames = CGRect(x: 0, y: 0, width: .sizeOfBackgroundViews, height: .sizeOfBackgroundViews)
        for backgroundView in backgroundViews {
            backgroundView.frame = backgroundFrames
            backgroundView.frame.origin.y = CGFloat.random(in: view.frame.minY...view.frame.maxY)
            backgroundView.frame.origin.x = CGFloat.random(in: view.frame.minX...view.frame.maxX - backgroundView.frame.width)
           
        }
        
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        moveLeftButton.translatesAutoresizingMaskIntoConstraints = false
        moveRightButton.translatesAutoresizingMaskIntoConstraints = false
         backgroundViewColored.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
            backgroundViewColored.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundViewColored.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundViewColored.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundViewColored.topAnchor.constraint(equalTo: view.topAnchor)
         ])
        NSLayoutConstraint.activate([
            moveLeftButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            moveLeftButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            moveLeftButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            moveLeftButton.heightAnchor.constraint(equalTo: moveLeftButton.widthAnchor, multiplier: 1)
        ])
        NSLayoutConstraint.activate([
            scoreLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: .offset24),
            scoreLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: .offset100)
        ])
        NSLayoutConstraint.activate([
            moveRightButton.rightAnchor.constraint(equalTo: view.rightAnchor),
            moveRightButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            moveRightButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            moveRightButton.heightAnchor.constraint(equalTo: moveRightButton.widthAnchor, multiplier: 1)
        ])
    }
     func positionUFO() {
        let position = Int.random(in: 0...4)
        let frame = CGRect(x: view.frame.minX  + (UFOView.frame.width * CGFloat(position)), y: .offset24, width: UFOView.frame.width, height: UFOView.frame.height)
        UFOView.frame = frame
    }
    
     func positionBackgroundViews(backgroundView: UIView){
        let frame = CGRect(x:CGFloat.random(in: view.frame.minX...view.frame.maxX - backgroundView.frame.width), y: 0, width: backgroundView.frame.width, height: backgroundView.frame.height)
        backgroundView.frame = frame
    }
     func animateBackground(){
        UIView.animate(withDuration: 0.1, animations: {
            for backgroundView in self.backgroundViews {
                backgroundView.frame.origin.y += self.model.speed
            }
        }, completion: { [weak self] (_) in
            guard let self = self else { return }
            if !self.planeIsCrashed() {
                for backgroundView in self.backgroundViews {
                    if self.planeCollectedStar(backgroundView) {
                        self.score += 5
                        self.positionBackgroundViews(backgroundView: backgroundView)
                    } else if backgroundView.frame.minY >= self.view.frame.maxY  {
                        self.positionBackgroundViews(backgroundView: backgroundView)
                    }
                }
                self.animateBackground()
            }
        })
    }
     func animateUFO() {
        UIView.animate(withDuration: 0.1, animations: {
            self.UFOView.frame.origin.y = self.UFOView.frame.origin.y + self.model.speed
        }, completion: { [weak self] (_) in
            guard let self = self else { return }
            if !self.planeIsCrashed() {
                if  self.UFOView.frame.minY  < self.view.frame.maxY {
                    self.animateUFO()
                } else {
                    self.score += CGFloat.scoreForFlyby
                    self.backgroundViewColored.alpha += .alphaForBackground
                    self.positionUFO()
                    self.animateUFO()
                }
            } else {
                self.explorePlane()
            }
        })
    }
    
     func showAlert() {
        model.addNewRecord(score: score)
        let customAlert = CustomAlertController()
        customAlert.delegate = self
        present(customAlert, animated: true, completion: nil)

    }
     func explorePlane() {
        planeView.addSubview(exploreImage)
        let exploreImageFrame = CGRect(x: 0, y: 0, width: planeView.frame.width, height: planeView.frame.width)
        exploreImage.frame = exploreImageFrame
        timer = Timer.scheduledTimer(timeInterval: CGFloat.exploreAnimationDelay, target: self, selector: #selector(updateImage), userInfo: nil, repeats: true)
        
    }
     func planeCollectedStar(_ backgroundView: UIView) -> Bool {
        if backgroundView.frame.maxY >= planeView.frame.minY && backgroundView.frame.minY <= planeView.frame.maxY {
            if backgroundView.frame.maxX >= planeView.frame.minX && backgroundView.frame.maxX <= planeView.frame.maxX {
                return true
            }
            if backgroundView.frame.minX <= planeView.frame.maxX && backgroundView.frame.minX >= planeView.frame.minX {
                return true
            }
        }
        return false
    }
     func planeIsCrashed() -> Bool {
        if UFOView.frame.maxY >= planeView.frame.minY && UFOView.frame.minY <= planeView.frame.maxY {
            if UFOView.frame.maxX >= planeView.frame.minX && UFOView.frame.maxX <= planeView.frame.maxX {
                return true
            }
            if UFOView.frame.minX <= planeView.frame.maxX && UFOView.frame.minX >= planeView.frame.minX {
                return true
            }
        }
        return false
    }
}

extension GameViewController: CustomAlertViewDelegate {
    func restartButtonTouched() {
        self.dismiss(animated: true)
        backgroundViewColored.alpha = 0
        score = 0
        exploreImage.removeFromSuperview()
        imageIndex = 0
        positionUFO()
        animateUFO()
        animateBackground()
    }
    
    func backToMenuButtonTouched() {
        self.dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
