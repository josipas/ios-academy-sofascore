import UIKit

class TableViewVC: UITableViewController {
    private var checked: [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        styleViews()
    }

    private func addSubviews() {
        self.tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "ChecklistItem")
    }

    private func styleViews()  {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        self.navigationController?.navigationBar.standardAppearance = appearance

        view.backgroundColor = .white
    }

    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 100
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "ChecklistItem",
                for: indexPath) as? CustomTableViewCell
        else {
            fatalError()
        }

        if checked.contains(where: { $0 == indexPath.row}) {
            cell.accessoryType = .checkmark
        }

        if indexPath.row % 5 == 0 {
            cell.set(labelText: "Walk the dog")
        } else if indexPath.row % 5 == 1 {
            cell.set(labelText: "Brush the teeth")
        } else if indexPath.row % 5 == 2 {
            cell.set(labelText: "Learn iOS development")
        } else if indexPath.row % 5 == 3 {
            cell.set(labelText: "Soccer practice")
        } else if indexPath.row % 5 == 4 {
            cell.set(labelText: "Eat ice cream")
        }

        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .none {
                cell.accessoryType = .checkmark
                checked.append(indexPath.row)
            } else {
                cell.accessoryType = .none
                checked.removeAll {
                    $0 == indexPath.row
                }
            }
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }
}

