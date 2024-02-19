cask "qupath" do
  unless (/darwin/ =~ RUBY_PLATFORM) != nil
    raise "This cask can only be installed on macOS"
  end
  arch arm: "arm64", intel: "x64"
  version "0.5.0"
  sha256 arm:   "e08fa1542298b7c7ef56acfeba10febc7c1c7dd2f3e11544a01723f100f99402",
         intel: "6d36907995ccfd54ce514ad7a7011f8f7988ce285923fff526d1d19a891cf5ad"

  language "en", default: true do
    "en_US"
  end

  url "https://github.com/qupath/qupath/releases/download/v#{version}/QuPath-v#{version}-Mac-#{arch}.pkg",
      verified: "github.com/qupath/qupath/"
  name "QuPath"
  desc "Bioimage analysis & digital pathology"
  homepage "https://qupath.github.io/"

  livecheck do
    url :url
  end

  auto_updates true

  pkg "QuPath-v#{version}-Mac-#{arch}.pkg"

  uninstall pkgutil: "qupath"
end
