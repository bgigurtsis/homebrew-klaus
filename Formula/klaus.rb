# Homebrew formula for Klaus
#
# To use this formula, create a tap repo (homebrew-klaus) containing this file
# at Formula/klaus.rb, then:
#
#   brew tap <your-github-user>/klaus
#   brew install klaus
#
# Before publishing, update the `url` to point to a tagged release tarball and
# regenerate the sha256 with:
#
#   shasum -a 256 Klaus-0.1.0.tar.gz

class Klaus < Formula
  desc "Voice-powered research assistant for physical books and papers"
  homepage "https://github.com/bgigurtsis/Klaus"
  url "https://github.com/bgigurtsis/Klaus/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "eed08abaf0c103e1606ea2300609853ddb4f367f099f3435db2548cb54a7f65a"
  license "MIT"

  depends_on "python@3.12"
  depends_on "portaudio"

  def install
    python3 = Formula["python@3.12"].opt_bin/"python3.12"
    system python3, "-m", "venv", libexec
    system libexec/"bin/pip", "install", buildpath
    bin.install_symlink libexec/"bin/klaus"
  end

  def caveats
    <<~EOS
      Klaus needs Accessibility permission for global hotkeys.
      Grant it in: System Settings > Privacy & Security > Accessibility

      On first launch, a setup wizard will walk you through API key
      configuration, camera selection, and voice model download.

      Run `klaus` to start.
    EOS
  end

  test do
    assert_match "usage", shell_output("#{bin}/klaus --help 2>&1", 2)
  end
end
