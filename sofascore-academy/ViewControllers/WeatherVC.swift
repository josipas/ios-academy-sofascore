import UIKit
import Foundation

class WeatherVC: UIViewController {
    private var inputTextField = CustomTextField(color: .systemGray)
    private var customButton = CustomButton(title: "Get city", color: .systemGray)

    private var city: City?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        buildViews()
    }

    private func buildViews() {
        createViews()
        addSubviews()
        addConstraints()
    }

    private func createViews() {
        customButton.delegate = self
    }

    private func addSubviews() {
        view.addSubview(inputTextField)
        view.addSubview(customButton)
    }

    private func addConstraints() {
        inputTextField.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalTo(200)
        }

        customButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(inputTextField.snp.bottom).offset(50)
        }
    }

    private func presentWeatherDeatilsVC(city: String, woeid: Int) {
        let weatherVC = WeatherDetailsVC(city: city, woeid: woeid)
        inputTextField.text = ""
        navigationController?.present(weatherVC, animated: true)
    }
}

extension WeatherVC: CustomButtonDelegate {
    func didTapCustomButton() {
        let input = inputTextField.text ?? ""
        NetworkManager.shared.getWoeid(for: input) { [weak self] result in
            switch result {
            case .success(let city):
                self?.city = city[0]
            case .failure(let error):
                print(error)
            }
        }

        guard let city = self.city else {
            return
        }

        self.presentWeatherDeatilsVC(city: city.title, woeid: city.woeid)
    }
}
