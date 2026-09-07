class Fns < Formula
  desc "Collection of useful Zsh functions"
  homepage "https://github.com/benmoose/homebrew-tap"
  url "https://github.com/benmoose/homebrew-tap/archive/refs/tags/v0.0.2.tar.gz"
  sha256 "e97312108291f7f1af642775be2e87a02b44e62320fd3799868de5a4bf9eaa20"
  license "GPL-3.0-or-later"
  head "https://github.com/benmoose/homebrew-tap.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+){2})$/i)
  end

  def install
    prefix.install_metafiles
    pkgshare.install "src/fns/env.zsh", "src/fns/init.zsh"
    pkgshare.install "src/fns/data"

    zsh_function.install Dir["src/fns/functions/*.zsh"].to_h { |path|
      [path, path.delete_suffix(".zsh").split("/").last]
    }
    zsh_function.install Dir["src/fns/functions/private/*.zsh"].to_h { |path|
      [path, path.delete_suffix(".zsh").split("/").last]
    }
  end

  def caveats
    <<~EOS
      To autoload functions, add this to your profile:
        source #{opt_prefix}/#{name}.zsh
    EOS
  end

  test do
    expect(formula.pkgshare).to be_a_directory
    expect(formula.zsh_function).to be_a_directory
  end
end
