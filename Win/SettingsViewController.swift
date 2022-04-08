//
//  SettingsViewController.swift
//  Win
//
//  Created by Alisher on 08.04.2022.
//

import UIKit

struct User: Hashable {
  let id = UUID()
  var title: String
  var emailAddres: String
}

extension User {
  static var data = [
    User(title: "From", emailAddres: "from@example.com"),
    User(title: "To", emailAddres: "to@example.com")
  ]
}

final class SettingsViewController: UIViewController, UITextFieldDelegate {
  
  typealias TableDataSource = UITableViewDiffableDataSource<Section, User>
  let users: [User] = User.data
  enum Section: Int {
    case emails
    case about
    
    var header: String {
      switch self {
      case .emails: return "Receivers"
      case .about: return "About"
      }
    }
  }
  
  lazy var datasource: TableDataSource = {
    let datasource = TableDataSource(tableView: tableView, cellProvider: { (tableView, indexPath, model) -> UITableViewCell? in
      let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
      cell.textLabel?.text = model.title
      let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
      textField.returnKeyType = .done
      textField.delegate = self
      textField.text = model.emailAddres
      cell.accessoryView = textField
      return cell
    })
    
    return datasource
  }()
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    tableView.backgroundColor = .clear
    tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemGray5
    
    view.addSubview(tableView)
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
    navigationController?.navigationBar.tintColor = UIColor.label
    applySnapshot()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.setNavigationBarHidden(true, animated: true)
  }
  
  func applySnapshot() {
    var snapshot = datasource.snapshot()
    snapshot.appendSections([.emails, .about])
    snapshot.appendItems(users, toSection: .emails)
    datasource.apply(snapshot, animatingDifferences: false)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
  }

  // user presses return key

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      return true
  }
}

final class TableViewCell: UITableViewCell {
  static var identifier = "dataCell"
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func commonInit() {
    backgroundColor = .systemGray4
  }
}
