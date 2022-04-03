import UIKit

class TransportVC: UIViewController {
    private var imageView: CustomImageView!
    private var inputTextField: CustomTextField!
    private var customButton: CustomButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
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
        customButton = CustomButton(title: "Generate", color: .systemGray)
        customButton.delegate = self
    }

    private func addSubviews() {
        view.addSubview(imageView)
        view.addSubview(inputTextField)
        view.addSubview(customButton)
    }

    private func configureViews()  {
        addConstraints()
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

        customButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(inputTextField.snp.bottom).offset(50)
        }
    }

    private func presentTransportVC() {
        guard let transportName = inputTextField.text,
              !transportName.isEmpty,
              Transport.allCases.contains(where: { $0.description == transportName }),
              let transport = Transport.allCases.first(where: { $0.description == transportName })
        else {
            navigationController?.present(CustomAlertView(alertTitle: "Empty transport name", alertMessage: "Please enter transport name 🚗🚲🚎", buttonTitle: "OK"), animated: true)
            return
        }
        let transportVC = TransportDetailsVC(transport: transport)
        inputTextField.text = ""
        navigationController?.present(transportVC, animated: true)
    }
}

extension TransportVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        presentTransportVC()
        return true
    }
}

extension TransportVC: CustomButtonDelegate {
    func didTapCustomButton() {
        inputTextField.text = Transport.allCases.randomElement()?.description
    }
}
