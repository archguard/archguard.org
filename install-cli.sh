#!/bin/bash

# ArchGuard CLI Installer
# Usage: curl -fsSL archguard.org/install-cli.sh | bash

set -e

echo "ArchGuard CLI Installer"
echo "======================"

# Configuration
REPO_OWNER="archguard"
REPO_NAME="archguard"
CLI_NAME="scanner_cli"

# Function to get the latest release version
get_latest_version() {
    echo "Checking latest version..."
    LATEST_VERSION=$(curl --silent "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/releases/latest" |
        grep '"tag_name":' |
        sed -E 's/.*"v([^"]+)".*/\1/')

    if [ -z "$LATEST_VERSION" ]; then
        echo "Error: Could not fetch latest version information"
        exit 1
    fi

    echo "Latest version: $LATEST_VERSION"
}

# Function to download the CLI
download_cli() {
    local version=$1
    local download_url="https://github.com/$REPO_OWNER/$REPO_NAME/releases/download/v$version/${CLI_NAME}-${version}-all.jar"
    local install_dir="$HOME/.archguard"
    local output_file="$install_dir/${CLI_NAME}.jar"

    # Create installation directory
    mkdir -p "$install_dir"

    echo "Downloading ArchGuard CLI v$version..."
    if curl -L -o "$output_file" "$download_url"; then
        echo "Successfully downloaded to: $output_file"

        # Create executable script
        cat > "$install_dir/archguard" << EOL
#!/bin/bash
java -jar $output_file "\$@"
EOL

        chmod +x "$install_dir/archguard"

        # Add to PATH if not already added
        SHELL_RC="$HOME/.$(basename $SHELL)rc"
        if ! grep -q "$install_dir" "$SHELL_RC" 2>/dev/null; then
            echo "export PATH=\"\$PATH:$install_dir\"" >> "$SHELL_RC"
            echo "Added ArchGuard to PATH in $SHELL_RC"
            echo "Please restart your terminal or run: source $SHELL_RC"
        fi

        echo ""
        echo "Installation completed! 🎉"
        echo "Run 'archguard --help' to get started"
    else
        echo "Error: Failed to download CLI"
        exit 1
    fi
}

# Main installation process
get_latest_version
download_cli "$LATEST_VERSION"
