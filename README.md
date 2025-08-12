# Python Template Repository ガイド

このドキュメントは、Pythonテンプレートレポジトリを使用して新しいプロジェクトを作成し、環境を構築するための手順を示しています。

## Dockerのインストール

Dockerについての説明は[こちら](https://github.com/TXP-MDD/github-tutorial/blob/main/docs/docker_command.md)を参照してください。

## Pythonテンプレートからの新規プロジェクト作成手順

1. **新しいレポジトリの作成**

   GitHub上で新しいレポジトリを作成します。使用する言語がPythonであるならば、この`python-template`を使用します。Rの場合は`r-template`を使用してください。

   このページの右上にある`Use this template`ボタンを押して作成します。`include all branches`は選択しないでください。名前は[命名規則](https://github.com/TXP-MDD/github-tutorial/blob/main/docs/repository_rules.md)に従ってください。

2. **リポジトリをクローンする**

   作成したレポジトリをローカルにクローンします。

   ```bash
   git clone https://github.com/TXP-MDD/<your-repository-name>
   cd your-repository-name
   ```

3. **Dockerイメージをビルドする**

   環境を統一するためにDockerイメージをビルドします。これはプロジェクトの依存関係を正しく管理し、異なる環境で同じ結果を得るためです。

   ```bash
   docker build -t <your-repository-name> .
   ```

4. jupyterサーバーを立ち上げる

   Pythonの場合、4まで進んだうえで、ターミナルで以下のコマンドを実行します。するとコンテナに入れます。

   <Macの場合>

   ```bash
   docker run -it -v "$(pwd)":/app -p 8888:8888 <your-repository-name> 
   ```

   <Windows(コマンドプロンプト)の場合>

   ```bash
   docker run -it -v "C:\path\to\your\app:/app" -p 8888:8888 <your-repository-name>

   # C:\path\to\your\appを適切なものに変えましょう
   # 例　github-tutorialというレポジトリが、\Users\junichiroshibata\TXP medical\mdd\フォルダの直下にあるとき
   docker run -it -v "C:\Users\junichiroshibata\TXP medical\mdd\github-tutorial:/app" -p 8888:8888 github-tutorial
   ```

   <Windows(Powershell)の場合>

   ```bash
   docker run -it -v "${PWD}:/app" -p 8888:8888 <your-repository-name>
   ```

   次に、コンテナ内部で、先ほど構成したpythonの環境をacvite化します。

   ```bash
   # (base): からterminalが始まっているはず。
   # ちなみに`project_env`はenvironment.ymlのnameに一致する。ymlファイルを変えたら以下のcodeも対応する名前に変える
   conda activate project_env
   ```

5. VS CodeでDockerコンテナに接続する

   次に、VS Codeでこのコンテナに接続します。

   1. VS Codeを開き、左下の緑色のアイコン（Remote Explorer）をクリックします。
   2. メニューから「実行中のコンテナにアタッチ」を選択します。
   3. リストから起動中のコンテナを選択します。

   これで、VS Codeは起動中のDockerコンテナ内で動作するようになります。

6. ディレクトリを開く

   まず、VS Codeでipynbなどが入っているディレクトリを開きましょう。`フォルダを開く`を押してください。
   `/app/`ディレクトリの下に全てのファイルがあるため、そのディレクトリを開けばOKです。

7. 初回のみ：拡張機能のインストール

   そのコンテナを初めて開くときだけ、画像のようにVS codeの拡張機能のインストール画面から、コンテナ内部（あなたのローカルPCではないので新規でインストールが必要）にPythonとJupyterの拡張機能をインストールしてください。次回以降、同じコンテナを開く場合は拡張機能の必要はありません。

8. Jupyter Notebookを開いてカーネルを指定

   VS CodeでJupyter Notebookを開き、Dockerで構築したPythonのバージョンを指定します。

   1. VS Codeで作業したい`.ipynb`ファイルを開きます。
   2. 画面右上の`カーネルの選択（select kernel）`から、Dockerで構築した`Python 3.10.8`を開きます。これで、病院と同じ環境で解析出来ます。
   3. いつも通りipynbファイルを自由に編集、解析してください。

9. ブラウザでJupyter Labを使用したいとき

   コンテナ内でJupyter Labが起動しているため、ブラウザからアクセスすることも可能です。以下の手順でアクセスできます。
   4まで終了したタイミングで以下のコマンドをterminalで打ち、コンテナのログを確認し、Jupyter LabのURLを取得します。

   <Macの場合>

   ```bash
   docker run -it -v "$(pwd)":/app -p 8888:8888 <your-repository-name> 
   conda activate project_env
   jupyter lab --ip=0.0.0.0 --no-browser --allow-root
   ```

   <Windows(コマンドプロンプト)の場合>

   ```bash
   docker run -it -v "C:\path\to\your\app:/app" -p 8888:8888 <your-repository-name> 
   conda activate project_env
   jupyter lab --ip=0.0.0.0 --no-browser --allow-root

   # C:\path\to\your\appを適切なものに変えましょう
   # 例　github-tutorialというレポジトリが、\Users\junichiroshibata\TXP medical\mdd\フォルダの直下にあるとき
   docker run -it -v "C:\Users\junichiroshibata\TXP medical\mdd\github-tutorial:/app" -p 8888:8888 github-tutorial
   conda activate project_env
   jupyter lab --ip=0.0.0.0 --no-browser --allow-root
   ```

   <Windows(Powershell)の場合>

   ```bash
   docker run -it -v "${PWD}:/app" -p 8888:8888 <your-repository-name>
   conda activate project_env
   jupyter lab --ip=0.0.0.0 --no-browser --allow-root
   ```

   - Terminalのログに表示されるURLをコピーして、ブラウザに貼り付けます。（例: `http://127.0.0.1:8888/lab?token=...`）

   これで、ブラウザでもJupyter Labが使用可能になり、ノートブックの作成や編集ができます。これらの手順で、VS CodeおよびブラウザからDocker環境内でJupyterを使用することができます。

10. **コードの作成とプッシュ**

   `srcフォルダに必要なコードを作成し、実装します。また、この`README.md`を削除して、[README_template.md](./README_template.md)を編集し、新たに`README.md`として保存してください。すべてのコードが完成したら、リポジトリにプッシュします。

   ```bash
   git add .
   git commit -m "Initial commit"
   git push origin main
   ````

11. **必要なモジュールの追加**

   追加のPythonパッケージが必要な場合は、`environment.yml` に追記してください。もしpipでしかインストールできないパッケージがある場合は`requirements.txt` に記載してください。両方に記載するとconflictするのでやめてください。

   ```yaml
   # environment.yml に追加
   dependencies:
     - some-new-conda-package
   ```

   ```txt
   # requirements.txt に追加
   some-new-package==1.0.0
   ```

## Dockerfileの概要

テンプレートのDockerfileは、Condaを使用してPython環境を構築します。病院内のPython環境がCondaだからです。このファイルはプロジェクトの依存関係を管理し、一貫した実行環境を提供します。pipでの管理は推奨しません。

### Dockerfileの修正について

プロジェクトの要件に応じて、以下のようにDockerfileを修正してください。

- 必要なパッケージを`environment.yml`に追加します。以下のコマンドを使っても構いません。

### 環境を変更した場合（パッケージ追加など）

```bash
# <your_project_name> はレポジトリ名、<environment.yaml> は環境設定ファイルを指します
(/path/to/your_project_directory) $ conda create -n <your_environment_name> -f <your_env_file.yaml>

# パッケージを追加する
(<your_environment_name>) $ conda install <package_name>

# 環境を変更した場合（パッケージ追加など）
(/path/to/your_project_directory) $ conda env export | grep -v "^prefix: " > <your_env_file.yaml>

# 仮想環境に入る
$ conda activate <your_environment_name>

# 仮想環境から出る
$ conda deactivate
```

## パッケージ管理のポイント

- **`environment.yml`**: 主要なパッケージとそのバージョンを管理します。Anaconda環境を使用する場合は、こちらでパッケージを指定します。
- **`requirements.txt`**: `conda` ではインストールできないパッケージを補完的に管理します。これには `pip` でのみインストール可能なパッケージを記載します。
- **重複インストールに注意**: 同じパッケージを `conda` と `pip` の両方でインストールしないよう注意してください。これにより、環境の競合や依存関係の問題を回避できます。
