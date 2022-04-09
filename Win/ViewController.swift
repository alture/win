//
//  ViewController.swift
//  Win
//
//  Created by Alisher on 08.04.2022.
//

import UIKit

class ViewController: UIViewController {
  
  private lazy var apiLabel: UILabel = {
    let label = UILabel()
    label.text = "Interface"
    label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var config: UIButton.Configuration = {
    var config = UIButton.Configuration.bordered()
    config.title = "Send message"
    config.titleAlignment = .center
    config.baseForegroundColor = UIColor.label
    config.baseBackgroundColor = .clear
    config.background.strokeColor = UIColor.label
    config.background.strokeWidth = 1.0
    return config
  }()
  
  private lazy var settingsButton: UIButton = {
    var settingsConfig = UIButton.Configuration.plain()
    settingsConfig.image = UIImage(systemName: "gearshape")
    settingsConfig.baseForegroundColor = UIColor.label
    let button = UIButton(configuration: settingsConfig, primaryAction: UIAction() { _ in
      print("Go to settings")
      let vc = SettingsViewController()
      self.navigationController?.pushViewController(vc, animated: true)
    })
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private lazy var clearButton: UIButton = {
    var config = UIButton.Configuration.plain()
    config.title = "Clear"
    config.titleAlignment = .center
    config.baseForegroundColor = UIColor.systemRed
    let button = UIButton(configuration: config, primaryAction: UIAction() { _ in
      print("Clear console")
      self.textView.text = ""
    })
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private lazy var textView: UITextView = {
    let textView = UITextView()
    textView.text = """
Date: Tue, 15 Mar 2022 11:28:10 +0600 (ALMT)
From: user@fornix.nb
To: user@fornix.nb
Subject: Windows Groups Changed
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Incident Detail
Incident ID: https://10.10.132.5/phoenix/html/incidents/3251549
Incident Time: Tue Mar 15 11:28:00 ALMT 2022
Event Severity: 7
Incident Count: 1
Incident Category: Change/UserAccount
Rule
Rule Name: Windows Groups Changed
Remediation:=20
Rule Description:=20
Incident Source
Hostname: ms.STAT.KZ
Source IP:=20
Incident Target
Incident Target: Host Name: ms.HACK.KZ
User: admin_jack
Domain: HACK
Target User Group: Sector14 Target Domain: STAT
Incident Title
Incident Title: Windows group Sector14 modified by admin_jack on ms.HACK.KZ Organization
Organization Name: Super
Raw Events
"""
    textView.layer.borderColor = UIColor.label.cgColor
    textView.layer.borderWidth = 1.0
    textView.layer.cornerRadius = 5.0
    textView.backgroundColor = .systemGray6
    textView.clipsToBounds = true
    textView.isEditable = false
    textView.isSelectable = true
    textView.translatesAutoresizingMaskIntoConstraints = false
    return textView
  }()
  
  private lazy var sendButton: UIButton = {
    let button = UIButton(configuration: config, primaryAction: UIAction() { _ in
      self.didTapButton()
    })
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.isNavigationBarHidden = true
    
  }
  
  func setupView() {
    view.backgroundColor = UIColor.systemGray5
    
    view.addSubview(apiLabel)
    view.addSubview(settingsButton)
    view.addSubview(textView)
    view.addSubview(sendButton)
    view.addSubview(clearButton)
    
    NSLayoutConstraint.activate([
      apiLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10.0),
      apiLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18.0),
      
      settingsButton.centerYAnchor.constraint(equalTo: apiLabel.centerYAnchor),
      settingsButton.leadingAnchor.constraint(greaterThanOrEqualTo: apiLabel.trailingAnchor, constant: 18.0),
      settingsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18.0),
      
      textView.topAnchor.constraint(equalTo: settingsButton.bottomAnchor, constant: 24.0),
      textView.leadingAnchor.constraint(equalTo: apiLabel.leadingAnchor),
      textView.trailingAnchor.constraint(equalTo: settingsButton.trailingAnchor),
      
      sendButton.heightAnchor.constraint(equalToConstant: 44.0),
      sendButton.leadingAnchor.constraint(equalTo: apiLabel.leadingAnchor),
      sendButton.trailingAnchor.constraint(equalTo: settingsButton.trailingAnchor),
      sendButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 24.0),
      
      clearButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      clearButton.topAnchor.constraint(equalTo: sendButton.bottomAnchor, constant: 18.0),
      clearButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12.0)
    ])
  }

  func didTapButton() {
    config.showsActivityIndicator = true
    config.title = ""
    self.sendButton.configuration = config
    
    let shared = UserDefaults.standard
    print(shared.string(forKey: "to"), shared.string(forKey: "from"))
  }

}

