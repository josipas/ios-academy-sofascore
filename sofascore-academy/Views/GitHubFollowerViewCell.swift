import UIKit
import SnapKit

class GitHubFollowerViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: GitHubFollowerViewCell.self)

    private var label = UILabel()
    private var imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        styleViews()
        addSubviews()
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(login: String, url: String) {
        label.text = login
        imageView.load(imageUrl: url)
    }

    private func styleViews() {
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
    }

    private func addSubviews() {
        addSubview(imageView)
        addSubview(label)
    }

    private func addConstraints() {
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(20)
        }

        imageView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalTo(label.snp.top)
        }

    }
}