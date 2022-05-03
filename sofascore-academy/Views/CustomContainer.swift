import UIKit

class CustomContainer: UIView {
    var rightUpLabel = UILabel()
    var rightDownLabel = UILabel()
    var leftUpLabel = UILabel()
    var leftDownLabel = UILabel()
    private var button: CustomButton!

    private var color: UIColor?
    private var title: String?
    private var rightTitle: String?
    private var leftTitle: String?

    init(title: String, color: UIColor, rightTitle: String, leftTitle: String) {
        super.init(frame: .zero)

        self.color = color
        self.title = title
        self.rightTitle = rightTitle
        self.leftTitle = leftTitle

        createViews()
        addSubviews()
        styleViews()
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createViews()  {
        guard
            let color = color,
            let title = title
        else { return }

        button = CustomButton(title: title, color: color)
    }

    private func addSubviews()  {
        addSubview(rightUpLabel)
        addSubview(rightDownLabel)
        addSubview(leftUpLabel)
        addSubview(leftDownLabel)
        addSubview(button)
    }

    private func styleViews()  {
        backgroundColor = UIColor(hex: "#D3D3D3")
        layer.cornerRadius = 10
        clipsToBounds = true

        guard
            let rightTitle = rightTitle,
            let leftTitle = leftTitle
        else { return }

        rightUpLabel.text = rightTitle
        leftUpLabel.text = leftTitle
    }

    private func addConstraints()  {
        leftUpLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(20)
        }

        leftDownLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(30)
            $0.top.equalTo(leftUpLabel.snp.bottom).offset(10)
        }

        rightUpLabel.snp.makeConstraints {
            $0.trailing.top.equalToSuperview().inset(20)
        }

        rightDownLabel.snp.makeConstraints {
            $0.trailing.equalTo(rightUpLabel.snp.centerX).offset(-5)
            $0.top.equalTo(leftUpLabel.snp.bottom).offset(10)
        }

        button.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
            $0.top.equalTo(rightDownLabel.snp.bottom).offset(15)
        }
    }
}
