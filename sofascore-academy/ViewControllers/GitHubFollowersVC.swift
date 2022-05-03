import UIKit

class GitHubFollowersVC: UIViewController {
    private var followersUrl: String?
    private var profileTitle: String?
    private var followers: [BasicFollower]?

    private var label = UILabel()
    private var collectionView: UICollectionView!

    init(followersUrl: String, title: String) {
        super.init(nibName: nil, bundle: nil)

        self.followersUrl = followersUrl
        self.profileTitle = title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(followersUrl)

        getData()
        configureCollectionView()
        styleViews()
        addSubviews()
        addConstraints()
    }

    private func getData() {
        guard let followersUrl = followersUrl else {
            return
        }

        NetworkManager.shared.getFollowers(for: followersUrl) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let followers):
                print(followers)
                self.followers = followers
            case .failure(let error):
                print(error)
            }
        }
    }

    private func styleViews() {
        view.backgroundColor = .white
        label.text = profileTitle
    }

    private func addSubviews() {
        view.addSubview(collectionView)
        view.addSubview(label)
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
}

extension GitHubFollowersVC: UICollectionViewDelegate {

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

