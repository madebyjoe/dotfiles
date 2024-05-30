# Add directories to the PATH and prevent to add the same directory multiple times upon shell reload.
add_to_path() {
  if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]]; then
    export PATH="$1:$PATH"
  fi
}

#Android Paths
export ANDROID_SDK=$HOME/Library/Android/sdk

add_to_path "$ANDROID_SDK/emulator"
add_to_path "$ANDROID_SDK/tools"
add_to_path "$HOME/Library/Android/sdk/platform-tools"
add_to_path "$HOME/Library/Android/sdk/tools"
add_to_path "$HOME/Library/Android/sdk/platform-tools/adb-sync"
add_to_path "$HOME/.rbenv/shims"
add_to_path "$HOME/.Duplicacy"