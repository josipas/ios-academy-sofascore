import UIKit

class TransportDetailsVC: UIViewController {
    private var collectionView: UICollectionView!
    private var titleLabel: UILabel!
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
                                                height: (view.bounds.height/2)),
                                          collectionViewLayout: flowLayout)

        titleLabel = UILabel()

        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
    }

    private func styleViews() {
        guard let transport = transport else { return }

        titleLabel.text = transport.description
        titleLabel.textColor = .systemPink
    }

    private func addConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(collectionView.snp.bottom)
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
