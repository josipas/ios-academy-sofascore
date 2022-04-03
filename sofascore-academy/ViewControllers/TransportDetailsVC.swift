import UIKit

class TransportDetailsVC: UIViewController {
    private var collectionView: UICollectionView!
    private var titleLabel = UILabel()
    private var detailsButton = CustomButton(title: "More", color: .systemPink)
    private var detailsText = UITextView()

    private let cellIdentifier = "cellId"

    private var transport: Transport?

    init(transport: Transport) {
        super.init(nibName: nil, bundle: nil)
        self.transport = transport
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        buildViews()
    }

    private func buildViews() {
        createSubviews()
        addSubviews()
        configureViews()
    }

    private func configureViews() {
        styleViews()
        addConstraints()
    }

    private func createSubviews() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical

        collectionView = UICollectionView(frame:
                                            CGRect(
                                                x: 0,
                                                y: 0,
                                                width: (view.bounds.width),
                                                height: 350),
                                          collectionViewLayout: flowLayout)
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self

        detailsButton.delegate = self

        detailsText.isHidden = true
    }

    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        view.addSubview(detailsButton)
        view.addSubview(detailsText)
    }

    private func styleViews() {
        guard let transport = transport else { return }

        titleLabel.text = transport.description
        titleLabel.textColor = .systemPink

        detailsText.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        detailsText.backgroundColor = .systemGray
        detailsText.textColor = .white
        detailsText.font = .systemFont(ofSize: 14)
        detailsText.layer.cornerRadius = 8
        detailsText.clipsToBounds = true
    }

    private func addConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(collectionView.snp.bottom)
        }

        detailsButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-40)
            $0.top.equalTo(titleLabel.snp.bottom)
        }

        detailsText.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-40)
            $0.height.equalTo(200)
            $0.top.equalTo(detailsButton.snp.bottom).offset(5)
        }
    }
}

extension TransportDetailsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        9
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                                      for: indexPath) as! CustomCell
        if let transport = transport {
            cell.configure(transport: transport)
        }
        return cell
    }
}

extension TransportDetailsVC: UICollectionViewDelegate {
}

extension TransportDetailsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}

extension TransportDetailsVC: CustomButtonDelegate {
    func didTapCustomButton() {
        switch detailsText.isHidden {
        case true:
            detailsText.isHidden = false
            detailsButton.setTitle("Less", for: .normal)
        case false:
            detailsText.isHidden = true
            detailsButton.setTitle("More", for: .normal)
        }
    }
}
