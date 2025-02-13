#!/bin/sh

echo "Setting up your Mac..."

# Check for Oh My Zsh and install if we don't have it
if test ! $(which omz); then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -sw $HOME/.dotfiles/.zshrc $HOME/.zshrc

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle

# Create a projects directories
mkdir $HOME/Code

# Prompt the user for input with a default value of 'core'
read -p "Enter the installation type (core/full) [core]: " install_type

# Set the default value to 'core' if no input is provided
install_type=${install_type:-core}

# Use the input in the rest of the script
if [ "$install_type" = "core" ]; then
    echo "Core installation selected."
    
    # Install core dependencies
    brew bundle --file ./core/Brewfile
    # Symlink the Mackup config file to the home directory
    ln -sw $HOME/.dotfiles/core/.mackup.cfg $HOME/.mackup.cfg
    # Clone Github repositories
    ./core/clone.sh
elif [ "$install_type" = "full" ]; then
    echo "Full installation selected."
    
    # Install all dependencies
    brew bundle --file ./core/Brewfile
    brew bundle --file ./personal/Brewfile
    # Symlink the Mackup config file to the home directory
    ln -sw $HOME/.dotfiles/personal/.mackup.cfg $HOME/.mackup.cfg
    # Clone Github repositories
    ./personal/clone.sh
else
    echo "Invalid option. Please enter 'core' or 'full'."
    exit 1
fi

# Setup the docker preferences
mkdir -p ~/.docker/cli-plugins
ln -sfn $(brew --prefix)/opt/docker-compose/bin/docker-compose ~/.docker/cli-plugins/docker-compose
ln -sfn $(brew --prefix)/opt/docker-buildx/bin/docker-buildx ~/.docker/cli-plugins/docker-buildx

# Set macOS preferences - we will run this last because this will reload the shell
source ./.macos