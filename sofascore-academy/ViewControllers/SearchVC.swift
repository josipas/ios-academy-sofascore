import UIKit

class SearchVC: UIViewController {
    private var imageView: CustomImageView!
    private var inputTextField: CustomTextField!

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
    }

    private func addSubviews() {
        view.addSubview(imageView)
        view.addSubview(inputTextField)
    }

    private func configureViews()  {
        styleViews()
        addConstraints()
    }

    private func styleViews() {

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
    }
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("tapped return")
        return true
    }
}
