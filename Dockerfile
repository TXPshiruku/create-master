# ベースイメージとしてMinicondaを使用
FROM continuumio/miniconda3

# 作業ディレクトリを設定
WORKDIR /app

# environment.yml をコンテナにコピーして、conda環境を構築
COPY environment.yml .
RUN conda env create -f environment.yml

# conda環境を有効化
SHELL ["conda", "run", "-n", "project_env", "/bin/bash", "-c"]

# 必要に応じて、pipで追加のパッケージをインストール（例：pipでしかインストールできないパッケージ）
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 環境変数を設定し、conda環境をデフォルトで使うようにする
ENV PATH /opt/conda/envs/project_env/bin:$PATH

# デフォルトのコマンドを設定しない（任意のコマンドで実行可能）
CMD ["bash"]