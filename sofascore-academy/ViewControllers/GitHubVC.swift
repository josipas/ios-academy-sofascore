import UIKit

class GitHubVC: UIViewController {
    private var profileContainer = CustomContainer(title: "Github Profile", color: .purple, rightTitle: "Public Gists", leftTitle: "Public Repos")
    private var followersContainer = CustomContainer(title: "Get Followers", color: .blue, rightTitle: "Following", leftTitle: "Followers")

    override func viewDidLoad() {
        view.backgroundColor = .white

        getData()
        addSubviews()
        addConstraints()
    }

    private func addSubviews() {
        view.addSubview(profileContainer)
        view.addSubview(followersContainer)
    }

    private func addConstraints() {
        profileContainer.snp.makeConstraints {
            $0.trailing.leading.top.equalToSuperview().inset(40)
        }

        followersContainer.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(40)
            $0.top.equalTo(profileContainer.snp.bottom).offset(20)
        }
    }

    private func getData() {
        NetworkManager.shared.getFollowers(for: "AntePrpic") { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let follower):
                print(follower)

                DispatchQueue.main.async {
                    self.profileContainer.rightDownLabel.text = String(follower.public_repos)
                    self.profileContainer.leftDownLabel.text = String(follower.public_gists)
                    self.followersContainer.rightDownLabel.text = String(follower.following)
                    self.followersContainer.leftDownLabel.text = String(follower.followers)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
