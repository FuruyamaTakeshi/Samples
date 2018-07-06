import UIKit
import PlaygroundSupport

class ViewController: UITableViewController {
    
    enum Section: Int, CaseIterable {
        case animals = 0
        case foods
        case forecast
        
        enum Row {
            case dog, cat
            case apple, banana, orange
            case health
            
            var title: String {
                switch self {
                case .dog:
                    return "Dog"
                case .cat:
                    return "Cat"
                case .apple:
                    return "Apple"
                case .banana:
                    return "Banana"
                case .orange:
                    return "Orange"
                case .health:
                    return "Health"
                }
            }
        }
        
        var headerTitle: String {
            switch self {
            case .animals:
                return "動物たち"
            case .foods:
                return "食べ物たち"
            case .forecast:
                return "健康"
            }
        }
        
        var height: CGFloat {
            switch self {
            case .forecast:
                return 88
            default:
                return 44
            }
        }
        
        var rows: [Row] {
            switch self {
            case .animals:
                return [Row.cat, Row.dog]
            case .foods:
                return [Row.apple, Row.banana, Row.orange]
            case .forecast:
                return [Row.health]
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Section(rawValue: section)?.rows.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // いきなり switch case せずに guard を使って早期リターンする場合の書き方
        // 以降の処理が複雑になる場合はネストが深くならないのでこっちのほうがいいかも
        guard let s = Section(rawValue: indexPath.section) else {
            // クラッシュする
            return tableView.dequeueReusableCell(withIdentifier: "Undefined Section", for: indexPath as IndexPath)
        }
        
        let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath as IndexPath)
        cell.textLabel?.text = s.rows[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Section(rawValue: indexPath.section)?.height ?? 44.0
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Section(rawValue: section)?.headerTitle ?? "Undefined"
    }

}

let vc = ViewController(style: .grouped)
PlaygroundPage.current.liveView = vc.view

