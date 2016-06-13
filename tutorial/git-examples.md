# ブランチ戦略に即した実践的なGitの使い方の例

間違ってたらごめん(´；ω；｀)その場合は[Wataru Hirota](https://github.com/tarohi24)大先生が優しく教えてくれます．
また，こっそり本ドキュメントも修正します．

## 新機能を追加する場合

1. developブランチからnew-featureブランチを派生させる．

        $ git checkout -b new-feature develop

1. new-featureブランチで新機能をしこしこ作る．

1. 新機能が完成したらdevelopブランチにrebaseするが，その前にリモートリポジトリから最新のdevelopブランチを取り込む．

        $ git checkout develop
        $ git fetch origin develop
        $ git merge origin/develop

1. new-featureブランチをdevelopブランチにrebaseする．

        $ git checkout new-feature
        $ git rebase develop

1. developブランチからnew-featureブランチをマージし，new-featureブランチを削除して完了

        $ git checkout develop
        $ git merge new-feature
        $ git branch -d new-feature
