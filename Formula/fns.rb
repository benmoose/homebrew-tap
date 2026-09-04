class Fns < Formula
  desc "Collection of useful Zsh functions"
  homepage "https://github.com/benmoose/homebrew-tap"
  url "https://github.com/benmoose/homebrew-tap/archive/refs/tags/v0.0.1.tar.gz"
  sha256 "ed3bac531725f4573297cdef29cd89f2f1fa032f4102d473591b65cda7704287"
  license "GPL-3.0-or-later"
  head "https://github.com/benmoose/homebrew-tap.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+){2})$/i)
  end

  def install
    prefix.install_metafiles
    pkgshare.install "src/fns/*.zsh"
    pkgshare.install "src/fns/data"


    zsh_function.install Pathname.glob("src/fns/functions/**/*.zsh").to_h do |path|
      return [path, path.basename.sub_ext('')]
    end
  end

  def caveats
    <<~EOS
      To autoload functions, add this to your profile:
        source #{opt_pkgshare}/init.zsh
    EOS
  end

  test do
    expect(formula.pkgshare).to be_a_directory
  end
end
