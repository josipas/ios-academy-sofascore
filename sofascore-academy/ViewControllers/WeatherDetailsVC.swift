import UIKit
import Foundation

class WeatherDetailsVC: UIViewController {
    private var cityLabel = UILabel()

    private var city: String?
    private var woeid: Int?

    init(city: String, woeid: Int) {
        super.init(nibName: nil, bundle: nil)
        self.city = city
        self.woeid = woeid
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        addViews()
        styleViews()
        addConstraints()
    }

    private func addViews() {
        view.addSubview(cityLabel)
    }

    private func styleViews() {
        cityLabel.text = city
    }

    private func addConstraints() {
        cityLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
