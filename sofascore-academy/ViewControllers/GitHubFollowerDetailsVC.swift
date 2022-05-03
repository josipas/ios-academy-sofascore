import UIKit

class GitHubFollowerDetailsVC: UIViewController {
    private var profileContainer = CustomContainer(title: "Github Profile", color: .purple, rightTitle: "Public Gists", leftTitle: "Public Repos")
    private var followersContainer = CustomContainer(title: "Get Followers", color: .blue, rightTitle: "Following", leftTitle: "Followers")
    private var profileImage = UIImageView()
    private var loginLabel = UILabel()
    private var nameLabel = UILabel()
    private var locationLabel = UILabel()
    private var jobDescription = UILabel()

    private var profileUrl: String?

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
    }

    private func styleViews() {
        profileContainer.delegate = self

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
    }

    private func getData() {
        NetworkManager.shared.getFollowerDetails(for: "mozilla") { [weak self] result in
            guard let self = self else { return }

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
                    self.jobDescription.text = follower.bio + " @ " + company
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension GitHubFollowerDetailsVC: CustomContainerDelegate {
    func didTapCustomButton() {
        guard let profileUrl = profileUrl else { return }
        if let url = URL(string: profileUrl) {
            UIApplication.shared.open(url)
        }
    }
}
