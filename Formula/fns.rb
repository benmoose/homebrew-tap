class Fns < Formula
  desc "Collection of useful Zsh functions"
  homepage "https://github.com/benmoose/homebrew-tap"
  url "https://github.com/benmoose/homebrew-tap/archive/refs/tags/v0.0.9.tar.gz"
  sha256 "09f31b2e0484c5ba63c55a055dce001a17b91ece7767b356231ec7999fd675eb"
  license "GPL-3.0-or-later"
  head "https://github.com/benmoose/homebrew-tap.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+){2})$/i)
  end

  def install
    prefix.install_metafiles

    pkgshare.install "src/fns/env.zsh", "src/fns/init.zsh", "src/fns/data"
    prefix.install_symlink pkgshare/"init.zsh"

    zsh_function.install Dir["src/fns/functions/*.zsh", "src/fns/functions/private/*.zsh"]
      .to_h { |path| [path, path.delete_suffix(".zsh").split("/").last] }
  end

  def caveats
    <<~EOS
      To autoload functions, add this to your profile:
        source #{opt_prefix}/init.zsh
    EOS
  end

  test do
    expect(formula.pkgshare).to be_a_directory
    expect(formula.zsh_function).to be_a_directory
  end
end
