import UIKit

class SearchVC: UIViewController {
    private var imageView: CustomImageView!

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
        imageView = CustomImageView(transport: .airplane, color: .white)
    }

    private func addSubviews() {
        self.view.addSubview(imageView)
    }

    private func configureViews()  {
        styleViews()
        addConstraints()
    }

    private func styleViews() {
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
    }

    private func addConstraints() {
        imageView.snp.makeConstraints {
            $0.height.width.equalTo(100)
            $0.top.equalToSuperview().offset(100)
            $0.centerX.equalToSuperview()
        }
    }
}
