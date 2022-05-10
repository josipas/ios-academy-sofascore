import UIKit

class GitHubFollowerDetailsVC: UIViewController {
    private let profileContainer = CustomContainer(title: "Github Profile", color: .purple, rightTitle: "Public Gists", leftTitle: "Public Repos")
    private let followersContainer = CustomContainer(title: "Get Followers", color: .blue, rightTitle: "Following", leftTitle: "Followers")
    private let profileImage = UIImageView()
    private let loginLabel = UILabel()
    private let nameLabel = UILabel()
    private let locationLabel = UILabel()
    private let jobDescription = UILabel()
    private let activityIndicatorView = UIActivityIndicatorView(style: .large)

    private var follower: BasicFollower?
    private var profileUrl: String?

    init(follower: BasicFollower) {
        super.init(nibName: nil, bundle: nil)

        self.follower = follower
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        view.backgroundColor = .white

        getData()
        addSubviews()
        styleViews()
        addConstraints()
    }

    private func addSubviews() {
        view.addSubview(profileContainer)
        view.addSubview(followersContainer)
        view.addSubview(profileImage)
        view.addSubview(loginLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationLabel)
        view.addSubview(jobDescription)
        view.addSubview(activityIndicatorView)
    }

    private func styleViews() {
        profileContainer.delegate = self
        followersContainer.delegate = self

        profileImage.layer.cornerRadius = 10
        profileImage.clipsToBounds = true

        loginLabel.font = .systemFont(ofSize: 20, weight: .bold)

        nameLabel.font = .systemFont(ofSize: 16)
        nameLabel.tintColor = .lightGray

        locationLabel.font = .systemFont(ofSize: 16)
        locationLabel.tintColor = .lightGray

        jobDescription.font = .systemFont(ofSize: 16)
        jobDescription.tintColor = .lightGray
        jobDescription.numberOfLines = 0
    }

    private func addConstraints() {
        profileImage.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.height.width.equalTo(100)
            $0.top.equalToSuperview().inset(50)
        }

        loginLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.leading.equalTo(profileImage.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(loginLabel.snp.bottom).offset(10)
            $0.leading.equalTo(profileImage.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }

        locationLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(10)
            $0.leading.equalTo(profileImage.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }

        jobDescription.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.top.equalTo(profileImage.snp.bottom).offset(20)
        }

        profileContainer.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.top.equalTo(jobDescription.snp.bottom).offset(20)
        }

        followersContainer.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.top.equalTo(profileContainer.snp.bottom).offset(20)
        }

        activityIndicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private func pushGitHubFollowersVC(follower: BasicFollower) {
        let followersVC = GitHubFollowersVC(followersUrl: follower.followersUrl, title: follower.login)
        navigationController?.pushViewController(followersVC, animated: true)
    }

    private func getData() {
        activityIndicatorView.startAnimating()

        guard let login = follower?.login else { return }

        NetworkManager.shared.getFollowerDetails(for: login) { [weak self] result in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
            }

            switch result {
            case .success(let follower):
                print(follower)

                self.profileUrl = follower.profileUrl

                DispatchQueue.main.async {
                    self.profileContainer.rightDownLabel.text = String(follower.publicRepos)
                    self.profileContainer.leftDownLabel.text = String(follower.publicGists)
                    self.followersContainer.rightDownLabel.text = String(follower.following)
                    self.followersContainer.leftDownLabel.text = String(follower.followers)
                    self.profileImage.load(imageUrl: follower.avatarUrl)
                    self.loginLabel.text = follower.login
                    self.nameLabel.text = follower.name
                    self.locationLabel.text = follower.location ?? "Unknown location"
                    let company = follower.company ?? "Unknown company"
                    let bio = follower.bio ?? "Employee"
                    self.jobDescription.text = bio + " @ " + company
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension GitHubFollowerDetailsVC: CustomContainerDelegate {
    func didTapCustomButton(container: CustomContainer) {
        if container == profileContainer {
            guard let profileUrl = profileUrl else { return }
            if let url = URL(string: profileUrl) {
                UIApplication.shared.open(url)
            }
        } else {
            guard let follower = follower else { return }
            self.pushGitHubFollowersVC(follower: follower)
        }
    }
}
