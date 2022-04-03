import UIKit

class CustomAlertView: UIViewController {
    private var alertTitle: String?
    private var alertMessage: String?
    private var buttonTitle: String?

    private var alertView = UIView()
    private var alertTitleLabel = UILabel()
    private var alertMessageLabel = UILabel()
    private var button: CustomButton!

    init(alertTitle: String, alertMessage: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
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

        button = CustomButton(title: buttonTitle, color: .purple)
    }

    private func addSubviews() {
        view.addSubview(alertView)
        alertView.addSubview(alertTitleLabel)
        alertView.addSubview(alertMessageLabel)
        alertView.addSubview(button)
    }

    private func configureViews()  {
        styleViews()
        addActions()
        addConstraints()
    }

    private func styleViews() {
        alertView.backgroundColor = .black
        alertView.layer.cornerRadius = 20
        alertView.clipsToBounds = true

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

    private func addConstraints() {
        alertView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(200)
            $0.trailing.leading.equalToSuperview().inset(40)
        }

        alertTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview().inset(10)
        }

        alertMessageLabel.snp.makeConstraints {
            $0.top.equalTo(alertTitleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
        }

        button.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-20)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
    }

    private func addActions() {
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    @objc func didTapButton() {
        self.dismiss(animated: true, completion: nil)
    }
}
