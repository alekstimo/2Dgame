//
//  RatingTableViewCell.swift
//  Aston2DGame
//
//  Created by Александра Тимонова on 24.09.2023.
//

//MARK: - Inputs
import UIKit

//MARK: - Constants
private extension CGFloat {
    static let alphaViewOpacity = 0.2
}

final class RatingTableViewCell: UITableViewCell {

    //MARK: - Identifier
    static var identifier: String {
        return String(describing: self)
    }
    
    //MARK: - IBOutlets
    private var userNameLabel: UILabel = {
        return UILabel(text: " ", font: UIFont(name: Fonts.fontName, size: Fonts.fontSize20) ?? .systemFont(ofSize: Fonts.fontSize20), color: Colors.yellowColor)
    }()
    private var recordLabel: UILabel = {
        return UILabel(text: " ", font: UIFont(name: Fonts.fontName, size: Fonts.fontSize20) ?? .systemFont(ofSize: Fonts.fontSize20), color: Colors.orangeColor)
    }()
    
    //MARK: - Lificycle funcs
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        userNameLabel.text = nil
        recordLabel.text = nil
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.backgroundColor = Colors.darkVioletColor.withAlphaComponent(.alphaViewOpacity)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Flow funcs
    func configureView(model: PlayerRecord) {
        userNameLabel.text = model.name
        recordLabel.text = String(model.record)
    }

}

//MARK: - Private extension
private extension RatingTableViewCell {
    func setUp() {
        self.addSubview(userNameLabel)
        self.addSubview(recordLabel)
        
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        recordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            userNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: .offset24)
        ])
        NSLayoutConstraint.activate([
            recordLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            recordLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -.offset24),
            recordLabel.leftAnchor.constraint(greaterThanOrEqualTo: userNameLabel.rightAnchor, constant: .offset10)
        ])
    }
}
