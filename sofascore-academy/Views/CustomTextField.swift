import UIKit
import SnapKit

class CustomTextField: UITextField {
    private var color: UIColor?

    init(color: UIColor) {
        super.init(frame: .zero)
        self.color = color
        configureViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureViews()  {
        guard let color = color else { return }
        backgroundColor = .white
        textColor = color
        layer.cornerRadius = 20
        clipsToBounds = true
        textAlignment = .center
        placeholder = "Search transport..."
    }
}
