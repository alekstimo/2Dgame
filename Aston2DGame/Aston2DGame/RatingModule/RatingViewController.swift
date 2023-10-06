//
//  RatingViewController.swift
//  Aston2DGame
//
//  Created by Алекснадра Тимонова on 24.09.2023.
//

//MARK: - Inputs
import UIKit

//MARK: - Constants
private extension String {
    static let titleName = "Rating"
}

class RatingViewController: UIViewController {
    
    //MARK: - IBOutlets
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        return tableView
    }()

    //MARK: - lets/vars
    private var model = UserDataModel.shared
    private var navigationBar: CustomNavigationBar!
    
    //MARK: - Lificycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.purpleColor
        addSubviews()
        setUpUI()
        setUpTableView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        navigationBar = CustomNavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: .offset100), title: .titleName)
        view.addSubview(navigationBar)
        navigationBar.delegate = self
    }
    //MARK: - Flow funcs
    func setUpTableView(){
        tableView.dataSource = self
        tableView.register(RatingTableViewCell.self, forCellReuseIdentifier: RatingTableViewCell.identifier)
    }
    func addSubviews() {
        view.addSubview(tableView)
    }
    func setUpUI() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor,constant: .offset240),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: - CustomNavigationBarDelegate
extension RatingViewController: CustomNavigationBarDelegate {
    func leftBarButtonTouched() {
        navigationController?.popViewController(animated: true)
    }
    
    
}

//MARK: - UITableViewDataSource
extension RatingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.playersRecords.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RatingTableViewCell.identifier, for: indexPath) as? RatingTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureView(model: model.playersRecords[indexPath.row])
        return cell
    }
    
    
    
}
