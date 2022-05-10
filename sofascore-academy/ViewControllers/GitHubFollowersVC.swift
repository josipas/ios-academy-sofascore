import UIKit

class GitHubFollowersVC: UIViewController {
    private enum Section { case main }
    private var followersUrl: String?
    private var login: String?
    private var followers: [BasicFollower]?
    private var dataSource: UICollectionViewDiffableDataSource<Section, BasicFollower>!

    private let label = UILabel()
    private var collectionView: UICollectionView!
    private let activityIndicatorView = UIActivityIndicatorView(style: .large)

    init(followersUrl: String, title: String) {
        super.init(nibName: nil, bundle: nil)

        self.followersUrl = followersUrl
        self.login = title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
        configureCollectionView()
        configureDataSource()
        styleViews()
        addSubviews()
        addConstraints()
    }

    private func getData() {
        activityIndicatorView.startAnimating()

        guard let followersUrl = followersUrl else {
            return
        }

        NetworkManager.shared.getFollowers(for: followersUrl) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let followers):
                print(followers)
                self.followers = followers
                self.updateData(followers)
                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private func styleViews() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        self.navigationController?.navigationBar.standardAppearance = appearance

        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: (#selector(addButtonTapped)))

        label.text = login
    }

    @objc func addButtonTapped() {
        guard let login = login else { return }

        NetworkManager.shared.getFollowerDetails(for: login) { [weak self] result in
            switch result {
            case .success(let follower):
                PersistenceManager.updateWith(favorite: follower, actionType: .add) { [weak self] error in
                    guard let self = self else { return }
                    guard error != nil else {
                        self.presentAlertOnMainThread(title: "Success", message: "User added to favorites", buttonTitle: "OK")
                        return
                    }
                    self.presentAlertOnMainThread(title: "Error", message: "Something went wrong", buttonTitle: "OK")
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private func presentAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
          let alertVC = CustomAlertView(alertTitle: title, alertMessage: message, buttonTitle: buttonTitle)
          alertVC.modalPresentationStyle = .overFullScreen
          alertVC.modalTransitionStyle = .crossDissolve
          self.present(alertVC, animated: true)
        }
    }

    private func addSubviews() {
        view.addSubview(collectionView)
        view.addSubview(label)
        view.addSubview(activityIndicatorView)
    }

    private func addConstraints() {
        label.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(40)
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }

        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(label.snp.bottom).offset(20)
        }

        activityIndicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 40
        layout.minimumInteritemSpacing = 10

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.register(GitHubFollowerViewCell.self, forCellWithReuseIdentifier: GitHubFollowerViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, BasicFollower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GitHubFollowerViewCell.reuseIdentifier, for: indexPath) as! GitHubFollowerViewCell

            cell.set(login: self.followers?[indexPath.row].login ?? "", url: self.followers?[indexPath.row].avatarUrl ?? "")

            return cell
        })
    }

    func updateData(_ followers: [BasicFollower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, BasicFollower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

extension GitHubFollowersVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let follower = followers?[indexPath.row] else { return }

        navigationController?.present(
            UINavigationController(rootViewController: GitHubFollowerDetailsVC(follower: follower)),
            animated: true)
    }
}

extension GitHubFollowersVC: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let collectionViewWidth = collectionView.frame.width
        let itemDimension = (collectionViewWidth - 2 * 20) / 3

        return CGSize(width: itemDimension, height: itemDimension + 20)
    }
}

extension GitHubFollowersVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let followers = self.followers else { return 0 }

        return followers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GitHubFollowerViewCell.reuseIdentifier, for: indexPath) as? GitHubFollowerViewCell
        else {
            fatalError()
        }

        guard let followers = self.followers else { return cell }

        cell.set(login: followers[indexPath.row].login, url: followers[indexPath.row].avatarUrl)

        return cell
    }
}
