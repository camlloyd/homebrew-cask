cask "archipelago" do
  version "6.0.7"
  sha256 "abb84577b68a79aebd1c31b6dc6fbdf7bf2c4c6fe97e6cfbd78634388015a2af"

  url "https://github.com/npezza93/archipelago/releases/download/v#{version}/Archipelago.zip"
  name "Archipelago"
  desc "Terminal emulator built on web technology"
  homepage "https://github.com/npezza93/archipelago"

  depends_on macos: ">= :sonoma"

  app "Archipelago.app"

  zap trash: [
    "~/Library/Application Support/Archipelago",
    "~/Library/Caches/dev.archipelago",
    "~/Library/Caches/dev.archipelago.ShipIt",
    "~/Library/HTTPStorages/dev.archipelago",
    "~/Library/Preferences/dev.archipelago.plist",
    "~/Library/Saved Application State/dev.archipelago.savedState",
    "~/Library/WebKit/dev.archipelago",
  ]
end
