import UIKit
import SnapKit

enum Transport: CaseIterable {
    case airplane
    case car
    case tram
    case bicycle

    var text: String {
        switch self {
        case .airplane:
            return "airplane.circle"
        case .car:
            return "car.circle"
        case .tram:
            return "tram.circle"
        case .bicycle:
            return "bicycle.circle"
        }
    }

    var description: String {
        switch self {
        case .airplane:
            return "Airplane"
        case .car:
            return "Car"
        case .tram:
            return "Tram"
        case .bicycle:
            return "Bicycle"
        }
    }
}

class CustomImageView: UIView {
    private var transport: Transport?
    private var color: UIColor?

    private var imageView: UIImageView!

    init(transport: Transport, color: UIColor) {
        super.init(frame: .zero)
        self.transport = transport
        self.color = color
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
        guard let transport = transport else { return }

        imageView = UIImageView(image: UIImage(systemName: transport.text))
    }

    private func addSubviews() {
        self.addSubview(imageView)
    }

    private func configureViews()  {
        styleViews()
        addConstraints()
    }

    private func styleViews() {
        guard let color = color else { return }

        imageView.tintColor = color
        backgroundColor = UIColor(cgColor: color.cgColor).withAlphaComponent(0.5)

        layer.cornerRadius = 20
        clipsToBounds = true
    }

    private func addConstraints() {
        imageView.snp.makeConstraints {
            $0.height.width.equalTo(50)
            $0.center.equalToSuperview()
        }
    }
}
