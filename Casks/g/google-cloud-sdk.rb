cask "google-cloud-sdk" do
  arch arm: "arm", intel: "x86_64"

  version "496.0.0"
  sha256 arm:   "6e6329be814e62e30d3876e6c77736b60caa0e3224c706142985abf855d5c67e",
         intel: "86c3e2114332f811df8f9ceec80231b70670c7a1ddee6d7c2cd7e4cf8939fb17"

  url "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-#{version}-darwin-#{arch}.tar.gz"
  name "Google Cloud SDK"
  desc "Set of tools to manage resources and applications hosted on Google Cloud"
  homepage "https://cloud.google.com/sdk/"

  livecheck do
    url "https://cloud.google.com/sdk/docs/install-sdk"
    regex(/latest\s*gcloud\s*CLI\s*version\s*\(v?(\d+(?:\.\d+)+)\)/i)
  end

  auto_updates true
  depends_on formula: "python@3.12"

  google_cloud_sdk_root = "#{HOMEBREW_PREFIX}/share/google-cloud-sdk"

  installer script: {
    executable: "google-cloud-sdk/install.sh",
    args:       [
      "--quiet",
      "--usage-reporting", "false",
      "--bash-completion", "false",
      "--path-update", "false",
      "--rc-path", "false",
      "--install-python", "false"
    ],
  }
  binary "google-cloud-sdk/bin/bq"
  binary "google-cloud-sdk/bin/docker-credential-gcloud"
  binary "google-cloud-sdk/bin/gcloud"
  binary "google-cloud-sdk/bin/git-credential-gcloud.sh", target: "git-credential-gcloud"
  binary "google-cloud-sdk/bin/gsutil"
  binary "google-cloud-sdk/completion.bash.inc",
         target: "#{HOMEBREW_PREFIX}/etc/bash_completion.d/google-cloud-sdk"
  binary "google-cloud-sdk/completion.zsh.inc",
         target: "#{HOMEBREW_PREFIX}/share/zsh/site-functions/_google_cloud_sdk"

  preflight do
    FileUtils.cp_r staged_path/"google-cloud-sdk/.", google_cloud_sdk_root, remove_destination: true
    FileUtils.rm_r(staged_path/"google-cloud-sdk")
    FileUtils.ln_s google_cloud_sdk_root, (staged_path/"google-cloud-sdk")
  end

  postflight do
    # HACK: Allow existing shell profiles to work by linking the current version to the `latest` directory.
    unless (latest_path = staged_path.dirname/"latest").directory?
      FileUtils.ln_s staged_path, latest_path, force: true
    end
  end

  uninstall delete: staged_path.dirname/"latest"

  zap trash: [
    "#{google_cloud_sdk_root}.staging",
    google_cloud_sdk_root,
  ]
end
