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
      sha256 "b328acfa63748660398489785087014533112c1f67f799a859b1e87a680dce4d"

      def install
        bin.install "redis-dumper"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/appit-online/redis-dumper/releases/download/v1.0.0/redis-dumper_1.0.0_macOS-64bit.tar.gz"
      sha256 "2ecdb57abed6b6cef86743baf0aead9735e44d9e16a56e8fd9ba3f68e1bebe36"

      def install
        bin.install "redis-dumper"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/appit-online/redis-dumper/releases/download/v1.0.0/redis-dumper_1.0.0_Linux-ARM64.tar.gz"
      sha256 "2564bcf5c7f9309862bc41015f9703a6b02c459d7543bb58fade5490beb351a1"

      def install
        bin.install "redis-dumper"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/appit-online/redis-dumper/releases/download/v1.0.0/redis-dumper_1.0.0_Linux-64bit.tar.gz"
      sha256 "e7d046f17e662b2e8018f204f29f2106734d0dcd6746894c88b4418b1daf483b"

      def install
        bin.install "redis-dumper"
      end
    end
  end
end