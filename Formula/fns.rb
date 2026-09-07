class Fns < Formula
  desc "Collection of useful Zsh functions"
  homepage "https://github.com/benmoose/homebrew-tap"
  url "https://github.com/benmoose/homebrew-tap/archive/refs/tags/v0.0.3.tar.gz"
  sha256 "efc5c8000976af9bdebb1b1dd0d60146d8a940c3702022f5d2a44510a1acb0f0"
  license "GPL-3.0-or-later"
  head "https://github.com/benmoose/homebrew-tap.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+){2})$/i)
  end

  def install
    prefix.install_metafiles

    pkgshare.install "src/fns/env.zsh", "src/fns/init.zsh", "src/fns/data"
    prefix.install_symlink pkgshare/"init.zsh" => "#{name}-init"

    zsh_function.install Dir["src/fns/functions/*.zsh", "src/fns/functions/private/*.zsh"].to_h { |path|
      [path, path.delete_suffix(".zsh").split("/").last]
    }
  end

  def caveats
    <<~EOS
      To autoload functions, add this to your profile:
        source #{opt_prefix}/#{name}-init
    EOS
  end

  test do
    expect(formula.pkgshare).to be_a_directory
    expect(formula.zsh_function).to be_a_directory
  end
end
