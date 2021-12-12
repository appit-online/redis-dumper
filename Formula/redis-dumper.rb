# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class RedisDumper < Formula
  desc "CLI for export/import of redis keys to another redis instance, deletion of keys and dummy key generation."
  homepage "https://github.com/appit-online/redis-dumper"
  version "1.0.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/appit-online/redis-dumper/releases/download/v1.0.0/redis-dumper_1.0.0_macOS-ARM64.tar.gz"
      sha256 "9b4cce4c1bb071d2d1cae92a2d776fecb517f0faf8d0f17a630e591c4455dbd8"

      def install
        bin.install "redis-dumper"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/appit-online/redis-dumper/releases/download/v1.0.0/redis-dumper_1.0.0_macOS-64bit.tar.gz"
      sha256 "440fde8ca1623c4a3f651888d16abba0a8317946577190c8c5e68cb36ef0ac24"

      def install
        bin.install "redis-dumper"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/appit-online/redis-dumper/releases/download/v1.0.0/redis-dumper_1.0.0_Linux-ARM64.tar.gz"
      sha256 "b68ee545daa88fae45cfde9c402443763eb471f2826203cc9d45bb44a690b2fe"

      def install
        bin.install "redis-dumper"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/appit-online/redis-dumper/releases/download/v1.0.0/redis-dumper_1.0.0_Linux-64bit.tar.gz"
      sha256 "eb3f62cdb5542074f06859717c4fc0ae2e2182ff8e592d8425c560e1807b1689"

      def install
        bin.install "redis-dumper"
      end
    end
  end
end
