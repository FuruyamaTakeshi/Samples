//
//  DetailViewController.swift
//  SettingSample
//
//  Created by 古山健司 on 2017/08/27.
//  Copyright © 2017年 古山健司. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var type: KaradaType!
    
    var viewModel: ResourceDataViewModel?
    private let disposeBag = DisposeBag()

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewModel = ResourceDataViewModel(type: type)
        configureView()
        
        viewModel?.resourcesVariable.asDriver()
            .drive(onNext: { [weak self] ResoureData in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: NSDate? {
        didSet {
            // Update the view.
            configureView()
        }
    }

}

extension DetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.resourceCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        let isEnable = viewModel?.isEnabled(at: indexPath)
        let name = viewModel?.proviedersName(at: indexPath)
        let color: UIColor = isEnable! ? .blue : .red
        
        cell.textLabel?.textColor = color
        cell.textLabel?.text = name
        if (viewModel?.isTokenValid(at: indexPath))! {
            cell.detailTextLabel?.text = "有効"
        } else {
            cell.detailTextLabel?.text = "無効"
        }
        return cell
    }
}

extension DetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.updateData(at: indexPath)
    }
}

