class FnUtils < Formula
  desc "My custom CLI utility functions"
  homepage "https://github.com/benmoose/homebrew-cli-utils"
  url "https://github.com/benmoose/homebrew-cli-utils/archive/refs/tags/v0.0.61.tar.gz"
  sha256 "de32545731b1a538c21e7bd68c689243ce422533a682cf68084acdeb1d135229"
  license "GPL-3.0"

  def install
    prefix.install_metafiles

    zsh_function.install Dir["src/private/*"]
    zsh_function.install Dir["src/public/*"]
    
    inreplace "src/fn-utils.sh", "$1", "#{zsh_function}"
    bin.install "src/fn-utils.sh" => "fn-utils"
  end

  def post_install
    system "fn-utils"
  end

  def caveat
    <<~EOS
      fn-utils installed!
      
      To use add this to your .zshrc:
        `source <(fn-utils)`

    EOS
  end

  # test do
  # `test do` will create, run in and delete a temporary directory.
  #
  # This test will fail and we won't accept that! For Homebrew/homebrew-core
  # this will need to be a test that verifies the functionality of the
  # software. Run the test with `brew test fn-utils`. Options passed
  # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
  #
  # The installed folder is not in the path, so use the entire path to any
  # executables being tested: `system bin/"program", "do", "something"`.
  # system "false"
  # end

  # def fn_names
  #   Dir[zsh_function/"*"].map {|fn| File.basename(fn)}
  # end
end
