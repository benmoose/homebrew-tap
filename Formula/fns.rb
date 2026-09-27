class Fns < Formula
  desc "Collection of custom Zsh functions"
  homepage "https://github.com/benmoose/homebrew-tap"
  url "https://github.com/benmoose/homebrew-tap/archive/refs/tags/v0.0.11.tar.gz"
  sha256 "b8086dbd751f691382af8688e350779df7f78e4c98c91039b166a16640f82d1f"
  license "GPL-3.0-or-later"
  head "https://github.com/benmoose/homebrew-tap.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+){2})$/i)
  end

  def install
    prefix.install_metafiles

    pkgshare.install "src/env.zsh", "src/init.zsh", "src/data"
    prefix.install_symlink pkgshare/"init.zsh"

    zsh_function.install Dir["src/functions/*.zsh", "src/functions/private/*.zsh"]
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
