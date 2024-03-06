cask "qupath" do
  arch arm: "arm64", intel: "x64"

  version "0.5.1"
  sha256 arm:   "83388e2bfb945b12e82492eafa7f07129bef1e3f7b06e438b9755e318506710d",
         intel: "a4421d62e2537ea0c5622840baaeec3d4ce3077524baf5d104efa4b8d759813f"

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

  pkg "QuPath-v#{version}-Mac-#{arch}.pkg"

  uninstall pkgutil: "qupath"
end
