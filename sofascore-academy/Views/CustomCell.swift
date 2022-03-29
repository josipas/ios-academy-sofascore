import UIKit

class CustomCell: UICollectionViewCell {
    private var imageView: CustomImageView!

    override init(frame: CGRect) {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(transport: Transport) {
        createSubviews(transport: transport)
        addSubviews()
        addConstraints()
    }

    private func createSubviews(transport: Transport) {
        imageView = CustomImageView(transport: transport, color: .systemPink)
    }

    private func addSubviews() {
        addSubview(imageView)
    }

    private func addConstraints() {
        imageView.snp.makeConstraints { make in
            make.trailing.leading.top.bottom.equalToSuperview()
        }
    }
}
