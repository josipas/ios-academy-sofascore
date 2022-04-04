import UIKit

class CustomTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ChecklistItem"

    private var label = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(labelText: String) {
        label.text = labelText
    }

    override func prepareForReuse() {
        accessoryType = .none
    }

    private func addConstraints() {
        addSubview(label)

        label.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.bottom.equalToSuperview().inset(10)
        }
    }
}
