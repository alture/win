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

final class SettingsViewController: UIViewController, UITextFieldDelegate {
  
  typealias TableDataSource = UITableViewDiffableDataSource<Section, User>
  var users: [User] = [
    User(title: "From", emailAddres: AppSettings.default.from ?? "example@apple.com"),
    User(title: "To", emailAddres: AppSettings.default.to ?? "example@google.com")
  ]
  enum Section: Int {
    case emails
    
    var header: String {
      switch self {
      case .emails: return "Receivers"
      }
    }
  }
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    tableView.backgroundColor = .clear
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "dataCell")
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  
  private lazy var saveButton: UIButton = {
    var config = UIButton.Configuration.bordered()
    config.title = "Save"
    config.titleAlignment = .center
    config.baseForegroundColor = UIColor.label
    config.baseBackgroundColor = .clear
    config.background.strokeColor = UIColor.label
    config.background.strokeWidth = 1.0
    let button = UIButton(configuration: config, primaryAction: UIAction() { _ in
      let appSettings = AppSettings.default
      appSettings.from = self.users[0].emailAddres
      appSettings.to = self.users[1].emailAddres
      self.navigationController?.popViewController(animated: true)
    })
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemGray5
    
    view.addSubview(tableView)
    view.addSubview(saveButton)
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.heightAnchor.constraint(equalToConstant: 250.0),
      
      saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0),
      saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0),
      saveButton.heightAnchor.constraint(equalToConstant: 44.0),
      saveButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16.0)
    ])
    
    navigationController?.navigationBar.tintColor = UIColor.label
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.setNavigationBarHidden(true, animated: true)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      return true
  }
  
  @objc func textFieldDidChange(_ textField: UITextField) {
    guard let email = textField.text else { return }
    users[textField.tag].emailAddres = email
  }
}

extension SettingsViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:  return 2
    default: return 0
    }
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    guard let enumSection = Section(rawValue: section) else { return nil }
    return enumSection.header
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
    let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
    textField.keyboardType = .emailAddress
    textField.returnKeyType = .done
    textField.delegate = self
    textField.tag = indexPath.row
    cell.accessoryView = textField
    let section = Section(rawValue: indexPath.section)
    let model: User
    switch section {
    case .emails:
      model = users[indexPath.row]
      cell.textLabel?.text = model.title
      textField.text = model.emailAddres
      textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    default:
      return cell
    }
    
    return cell
  }
}
