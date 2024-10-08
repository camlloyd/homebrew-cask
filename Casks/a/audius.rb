cask "audius" do
  arch arm: "-arm64"

  on_arm do
    version "1.5.96"
    sha256 "66491d38bc9ffc45a06e4a7a94ba3c2feedc7f13a81dc6c487aa83e3ab0c4aae"

    livecheck do
      url "https://download.audius.co/latest-mac.yml"
      strategy :electron_builder
    end
  end
  on_intel do
    version "1.5.66"
    sha256 "ed894a7eca86e9e858454f125c69b39ff2a8f8a5d27f637aa444caba7bfa4855"

    livecheck do
      skip "Legacy version"
    end
  end

  url "https://download.audius.co/Audius-#{version}#{arch}.dmg"
  name "Audius"
  desc "Music streaming and sharing platform"
  homepage "https://audius.co/"

  auto_updates true
  depends_on macos: ">= :catalina"

  app "Audius.app"

  zap trash: [
    "~/Library/Application Support/Audius",
    "~/Library/Application Support/Caches/audius-client-updater",
    "~/Library/Logs/Audius",
    "~/Library/Saved Application State/co.audius.app.savedState",
  ]
end
