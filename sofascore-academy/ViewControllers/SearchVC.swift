import UIKit

class SearchVC: UIViewController {
    private var imageView: CustomImageView!
    private var inputTextField: CustomTextField!
    private var customButton: CustomButton!

    private let alert = CustomAlertView(alertTitle: "Empty transport name", alertMessage: "Please enter transport name 🚗🚎✈️", buttonTitle: "OK")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        alert.delegate = self
        buildViews()
    }

    private func buildViews() {
        createViews()
        addSubviews()
        configureViews()
    }

    private func createViews() {
        imageView = CustomImageView(transport: .bicycle, color: .white)
        inputTextField = CustomTextField(color: .purple)
        inputTextField.delegate = self
        customButton = CustomButton(title: "Button", color: .systemGray)
        customButton.delegate = self
    }

    private func addSubviews() {
        view.addSubview(imageView)
        view.addSubview(inputTextField)
        view.addSubview(customButton)
        view.addSubview(alert)
    }

    private func configureViews()  {
        styleViews()
        addConstraints()
    }

    private func styleViews() {
        alert.isHidden = true
    }

    private func addConstraints() {
        imageView.snp.makeConstraints {
            $0.height.width.equalTo(100)
            $0.top.equalToSuperview().offset(200)
            $0.centerX.equalToSuperview()
        }

        inputTextField.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(40)
            $0.height.equalTo(50)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
        }

        alert.snp.makeConstraints {
            $0.height.width.equalTo(200)
            $0.center.equalToSuperview()
        }

        customButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(inputTextField.snp.bottom).offset(50)
        }
    }

    private func presentTransportVC() {
        guard let
                transportName = inputTextField.text,
              !transportName.isEmpty
        else {
            self.tabBarController?.tabBar.isUserInteractionEnabled = false
            inputTextField.isEnabled = false
            alert.isHidden = false
            return
        }
        let transportVC = TransportDetailsVC()
        transportVC.title = inputTextField.text
        inputTextField.text = ""
        navigationController?.present(transportVC, animated: true)
    }
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        presentTransportVC()
        return true
    }
}

extension SearchVC: CustomAlertDelegate {
    func didTapButtonInAlert() {
        self.tabBarController?.tabBar.isUserInteractionEnabled = true
        inputTextField.isEnabled = true
        alert.isHidden = true
    }

    func didTapCustomButton() {
        inputTextField.text = Transport.allCases.randomElement()?.description
    }
}
