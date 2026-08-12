class FnUtils < Formula
  desc "My custom CLI utility functions"
  homepage "https://github.com/benmoose/homebrew-cli-utils"
  url "https://github.com/benmoose/homebrew-cli-utils/archive/refs/tags/v0.0.43.tar.gz"
  sha256 "c00eb4c8698a044804dc885fea260770e784f066985ec1d6e9775adc9f7295b2"
  license "GPL-3.0"

  def install
    # (pkgshare/"functions").install Dir["src/private/*"]
    # (pkgshare/"functions").install Dir["src/public/*"]
    # pkgshare.install "src/init.sh"

    zsh_function.install Dir["src/private/*"]
    zsh_function.install Dir["src/public/*"]
    
    inreplace "src/fn-utils.sh", "$1", "#{zsh_function}"
    bin.install "src/fn-utils.sh" => "fn-utils"

    # (bin/"fn-utils").write_env_script share/"fn-utils.sh", [zsh_function]
    # (bin/"fn-utils2").write_env_script "src/fn-utils.sh", [zsh_function]
    # (bin/"fn-utils").write_env_script share/"fn-utils.sh", Dir[zsh_function/"*"].map {|fn| File.basename(fn)}, FN_DIR: zsh_function
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
