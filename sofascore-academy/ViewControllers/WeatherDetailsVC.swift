import UIKit
import Foundation

class WeatherDetailsVC: UIViewController {
    private let cityLabel = UILabel()
    private let woeidLabel = UILabel()

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
        view.addSubview(woeidLabel)
    }

    private func styleViews() {
        cityLabel.text = city
        woeidLabel.textAlignment = .center

        guard let woeid = woeid else { return }
        woeidLabel.text = String(woeid)
    }

    private func addConstraints() {
        cityLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        woeidLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(cityLabel.snp.bottom).offset(10)
        }
    }
}
