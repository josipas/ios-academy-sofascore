import UIKit

protocol CustomAlertDelegate: CustomButtonDelegate {
    func didTapButtonInAlert()
}

class CustomAlertView: UIView {
    public var delegate: CustomAlertDelegate?

    private var alertTitle: String?
    private var alertMessage: String?
    private var buttonTitle: String?

    private var alertTitleLabel: UILabel!
    private var alertMessageLabel: UILabel!
    private var button: CustomButton!

    init(alertTitle: String, alertMessage: String, buttonTitle: String) {
        super.init(frame: .zero)
        self.alertTitle = alertTitle
        self.alertMessage = alertMessage
        self.buttonTitle = buttonTitle
        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func buildViews() {
        createViews()
        addSubviews()
        configureViews()
    }

    private func createViews() {
        guard let buttonTitle = buttonTitle else { return }

        alertTitleLabel = UILabel()
        alertMessageLabel = UILabel()
        button = CustomButton(title: buttonTitle, color: .purple)
    }

    private func addSubviews() {
        addSubview(alertTitleLabel)
        addSubview(alertMessageLabel)
        addSubview(button)
    }

    private func configureViews()  {
        styleViews()
        addActions()
        addConstraints()
    }

    private func styleViews() {
        backgroundColor = .black
        layer.cornerRadius = 20
        clipsToBounds = true

        alertTitleLabel.text = alertTitle
        alertTitleLabel.font = .boldSystemFont(ofSize: 16)
        alertTitleLabel.textColor = .white
        alertTitleLabel.numberOfLines = 0
        alertTitleLabel.textAlignment = .center

        alertMessageLabel.text = alertMessage
        alertMessageLabel.font = .systemFont(ofSize: 14)
        alertMessageLabel.textColor = .systemGray
        alertMessageLabel.numberOfLines = 0
        alertMessageLabel.textAlignment = .center
    }

    private func addActions() {
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    private func addConstraints() {
        alertTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
        }

        alertMessageLabel.snp.makeConstraints {
            $0.top.equalTo(alertTitleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
        }

        button.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-20)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
        }
    }

    @objc func didTapButton() {
        self.delegate?.didTapButtonInAlert()
    }
}
