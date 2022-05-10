import UIKit

class GitHubVC: UIViewController {
    private let inputTextField = CustomTextField(color: .systemGray)
    private let customButton = CustomButton(title: "Get follower", color: .systemGray)

    private var follower: Follower?

    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }

    private func buildViews() {
        styleViews()
        addSubviews()
        addConstraints()
    }

    private func styleViews() {
        view.backgroundColor = .lightGray
        customButton.delegate = self
    }

    private func addSubviews() {
        view.addSubview(inputTextField)
        view.addSubview(customButton)
    }

    private func addConstraints() {
        inputTextField.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalTo(200)
        }

        customButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(inputTextField.snp.bottom).offset(50)
        }
    }

    private func pushGitHubFollowersVC(follower: Follower) {
        let followersVC = GitHubFollowersVC(followersUrl: follower.followersUrl, title: follower.login)
        inputTextField.text = ""
        navigationController?.pushViewController(followersVC, animated: true)
    }
}

extension GitHubVC: CustomButtonDelegate {
    func didTapCustomButton() {
        guard let input = inputTextField.text else { return }
        NetworkManager.shared.getFollowerDetails(for: input) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let follower):
                print(follower)
                DispatchQueue.main.async {
                    self.pushGitHubFollowersVC(follower: follower)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
