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

    echo "Download URL: $download_url"
    echo "Installation directory: $install_dir"
    echo "CLI jar location: $output_file"

    # Create installation directory
    mkdir -p "$install_dir"

    echo -e "\nDownloading ArchGuard CLI v$version..."
    if curl -L -o "$output_file" "$download_url"; then
        echo "Download completed successfully!"

        # Create executable script
        local wrapper_script="$install_dir/archguard"
        echo "Creating wrapper script: $wrapper_script"

        cat > "$wrapper_script" << EOL
#!/bin/bash
java -jar $output_file "\$@"
EOL

        chmod +x "$wrapper_script"

        # Add to PATH if not already added
        SHELL_RC="$HOME/.$(basename $SHELL)rc"
        if ! grep -q "$install_dir" "$SHELL_RC" 2>/dev/null; then
            echo "export PATH=\"\$PATH:$install_dir\"" >> "$SHELL_RC"
            echo "Added ArchGuard to PATH in $SHELL_RC"
            echo "Please restart your terminal or run: source $SHELL_RC"
        fi

        echo -e "\nInstallation Summary:"
        echo "======================"
        echo "JAR Location: $output_file"
        echo "Wrapper Script: $wrapper_script"
        echo "Shell Configuration: $SHELL_RC"
        echo "Version: $version"
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
