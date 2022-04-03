import UIKit

protocol CustomButtonDelegate {
    func didTapCustomButton()
}

class CustomButton: UIButton {
    public var delegate: CustomButtonDelegate?
    private var title: String?
    private var color: UIColor?

    init(title: String, color: UIColor) {
        super.init(frame: .zero)
        self.title = title
        self.color = color
        configureViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureViews()  {
        styleViews()
        addActions()
        addConstraints()
    }

    private func addActions() {
        addTarget(self, action: #selector(didTapCustomButton), for: .touchUpInside)
    }

    private func styleViews() {
        setTitle(title, for: .normal)
        backgroundColor = color
        tintColor = .white
        layer.cornerRadius = 10
        clipsToBounds = true
    }

    private func addConstraints() {
        self.snp.makeConstraints {
            $0.height.equalTo(50)
        }
    }

    @objc func didTapCustomButton() {
        self.delegate?.didTapCustomButton()
    }
}
