#!/usr/bin/env bash
set -euo pipefail

GO_LATEST=$(curl -sSL https://go.dev/VERSION?m=text | head -n1)
GO_URL="https://go.dev/dl/${GO_LATEST}.linux-amd64.tar.gz"

echo "Latest Go version: $GO_LATEST"
echo "Download URL: $GO_URL"

sudo rm -rf /usr/local/go

curl -sSL "$GO_URL" -o /tmp/go.tar.gz
sudo tar -C /usr/local -xzf /tmp/go.tar.gz
rm /tmp/go.tar.gz

GO_ENV='
# Golang environment setup
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
'
if ! grep -q 'Golang environment setup' ~/.profile; then
  echo "$GO_ENV" >> ~/.profile
fi

export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

echo "Go installation complete!"
go version
