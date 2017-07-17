//  PresentModalViewController.swift
//  PresentationControl
//
//  Created by 古山健司 on 2017/07/17.
//  Copyright © 2017年 古山健司. All rights reserved.
//

import UIKit

enum ActionStyle {
    case `default`, cancel
}

class AlertAction: UIButton {
    
    private var handler: ((AlertAction) -> Void)?
    private var style: ActionStyle = ActionStyle.default
    fileprivate var parent: UIViewController?
    
    init(title: String, frame: CGRect, style: ActionStyle, handler: @escaping (AlertAction) -> Void) {
        let newFrame = CGRect(x: frame.midX, y: frame.maxY - 22, width: frame.width, height: 44)
        super.init(frame: newFrame)
        self.handler = handler
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        self.setTitle(title, for: .normal)
        switch style {
        case .cancel:
            self.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
            self.backgroundColor = #colorLiteral(red: 0.7233663201, green: 0.7233663201, blue: 0.7233663201, alpha: 1)
            self.layer.borderColor = UIColor(red: 0.74, green: 0.77, blue: 0.79, alpha: 1.00).cgColor
        default:
            self.setTitleColor(.white, for: .normal)
            self.backgroundColor = UIColor(red: 0.31, green: 0.57, blue: 0.87, alpha: 1.00)
            self.layer.borderColor = UIColor(red: 0.17, green: 0.38, blue: 0.64, alpha: 1.00).cgColor
        }
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.1
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    // MARK: - Action
    @objc private func buttonTapped(_ sender: AlertAction) {
        self.parent?.dismiss(animated: true, completion: {
            self.handler?(sender)
        })
    }
}

class PresentModalViewController: UIViewController {
    // stackView
    fileprivate let buttonsStackView: UIStackView = {
        let sv = UIStackView()
//        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        sv.spacing = 22
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonsStackView.frame = CGRect(x: 40, y: 256, width: self.view.frame.width / 2, height: 44)
        self.view.addSubview(buttonsStackView)
        let frame = self.view.bounds
        let action1 = AlertAction(title: "OK", frame: frame, style: .default) { _ in
            print("### OK ####")
        }
        let action2 = AlertAction(title: "cancel", frame: frame, style: .cancel) { _ in
            print("cancel")
        }
        addAction(action: action1)
        addAction(action: action2)
    }
    //
    func addAction(action: AlertAction) {
        action.parent = self
        buttonsStackView.addArrangedSubview(action)
    }

}
// MARK: - UITableViewDataSource
extension PresentModalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}
