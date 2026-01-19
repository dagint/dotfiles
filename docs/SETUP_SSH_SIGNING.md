# Setting Up Git Commit Signing

This guide explains how to set up commit signing for Git using SSH keys or GPG (including YubiKey support), which is useful in DevPod and other development environments.

## Quick Decision Guide

**Do you have a YubiKey?**
- ✅ **Yes** → Use **GPG signing with YubiKey** (see YubiKey section below) - Most secure option
- ❌ **No** → Continue with SSH signing

**For SSH signing, use a separate key or existing one?**
- ✅ **Separate key** (Recommended) - Better security, independent revocation
- ⚠️ **Existing key** - Simpler but less secure isolation

## Prerequisites

- Git 2.34 or later (check with `git --version`)
- An SSH key pair (or generate a new one)
- Access to your Git hosting service (GitHub, GitLab, etc.)
- For YubiKey: YubiKey 5 series and GPG setup

## Step 1: Generate or Identify Your SSH Key

### Option A: Generate a New SSH Key (Recommended)

```bash
# Generate a new Ed25519 key (recommended)
ssh-keygen -t ed25519 -C "your_email@example.com" -f ~/.ssh/id_ed25519_signing

# Or generate RSA key (if Ed25519 not supported)
ssh-keygen -t rsa -b 4096 -C "your_email@example.com" -f ~/.ssh/id_rsa_signing
```

**Important**: Use a strong passphrase to protect your private key.

### Option B: Use Existing SSH Key

If you already have an SSH key you want to use for signing:

```bash
# List your SSH keys
ls -la ~/.ssh/

# Common key names:
# - id_ed25519 / id_ed25519.pub
# - id_rsa / id_rsa.pub
```

## Step 2: Add Public Key to Git Hosting Service

### For GitHub:

1. Copy your public key:
   ```bash
   cat ~/.ssh/id_ed25519_signing.pub
   # or
   cat ~/.ssh/id_ed25519.pub
   ```

2. Go to GitHub → Settings → SSH and GPG keys
3. Click "New SSH key"
4. **Important**: Select "Signing Key" as the key type (not "Authentication Key")
5. Paste your public key
6. Give it a descriptive title (e.g., "DevPod Signing Key")
7. Click "Add SSH key"

### For GitLab:

1. Copy your public key (same as above)
2. Go to GitLab → Preferences → SSH Keys
3. Paste the key in the "Key" field
4. **Important**: Check the "Use this key for signing" checkbox
5. Add a title and click "Add key"

## Step 3: Configure Git to Use SSH Signing

### Option A: Configure Globally (Recommended for DevPod)

Edit your `~/.gitconfig` or use git config commands:

```bash
# Set signing format to SSH
git config --global gpg.format ssh

# Set the path to your public key (not the private key!)
git config --global user.signingKey ~/.ssh/id_ed25519_signing.pub

# Enable commit signing
git config --global commit.gpgsign true
```

### Option B: Configure in This Dotfiles Repository

The `git/gitconfig` file has commented-out configuration. Uncomment and set:

```ini
[gpg]
    format = ssh
[user]
    signingKey = ~/.ssh/id_ed25519_signing.pub
[commit]
    gpgsign = true
```

**Note**: The `signingKey` should point to your **public key** (`.pub` file), not the private key.

## Step 4: Verify Setup

### Test Commit Signing

```bash
# Create a test commit
echo "test" > test.txt
git add test.txt
git commit -m "Test signed commit"
git rm test.txt
git commit -m "Remove test file"
```

### Verify Signature

```bash
# Check if commit is signed
git log --show-signature -1

# You should see something like:
# Good "git" signature for ...
```

### Check Git Configuration

```bash
# Verify your signing configuration
git config --global --get gpg.format
git config --global --get user.signingKey
git config --global --get commit.gpgsign
```

## Step 5: Configure DevPod

When DevPod asks for "SSH key for git commit signing", provide the **path to your public key**:

```
~/.ssh/id_ed25519_signing.pub
```

Or if using your default key:

```
~/.ssh/id_ed25519.pub
```

**Important**: Always provide the path to the **public key** (`.pub` file), never the private key.

## Troubleshooting

### "No such file or directory" Error

- Verify the key path is correct: `ls -la ~/.ssh/id_ed25519_signing.pub`
- Use absolute path if relative path doesn't work: `/home/user/.ssh/id_ed25519_signing.pub`

### "Permission denied" Error

- Check file permissions:
  ```bash
  chmod 600 ~/.ssh/id_ed25519_signing  # Private key
  chmod 644 ~/.ssh/id_ed25519_signing.pub  # Public key
  chmod 700 ~/.ssh  # Directory
  ```

### Commits Not Showing as Verified

- Verify the public key is added to GitHub/GitLab as a **signing key** (not authentication key)
- Check Git version: `git --version` (needs 2.34+)
- Verify configuration: `git config --list | grep -i sign`

### SSH Agent Issues

If using SSH agent forwarding in DevPod:

```bash
# Start SSH agent
eval "$(ssh-agent -s)"

# Add your key to the agent
ssh-add ~/.ssh/id_ed25519_signing
```

## Separate Key vs. Existing Key

### Recommended: Use a Separate Key

**Pros:**
- ✅ **Better security isolation** - If one key is compromised, the other remains safe
- ✅ **Independent revocation** - Can revoke signing without affecting authentication
- ✅ **Clear separation of concerns** - Authentication vs. signing have different risk profiles
- ✅ **Easier key rotation** - Can rotate signing keys independently

**Cons:**
- ❌ Slightly more setup (one extra key to manage)
- ❌ Need to add two keys to GitHub/GitLab (one for auth, one for signing)

### Using Existing Key

**Pros:**
- ✅ Simpler setup - One key for everything
- ✅ Less key management overhead

**Cons:**
- ❌ **Security risk** - If key is compromised, both auth and signing are affected
- ❌ **Harder to rotate** - Must update both authentication and signing simultaneously
- ❌ **Less granular control** - Can't revoke signing independently

**Recommendation**: For production or professional use, use a **separate signing key**. For personal projects or convenience, using an existing key is acceptable if you're comfortable with the trade-offs.

## Using YubiKey for Commit Signing

YubiKey can be used for commit signing, but the approach differs from SSH signing:

### Option 1: GPG Signing with YubiKey (Recommended for YubiKey)

YubiKey has excellent GPG support and is the most common approach:

**Advantages:**
- ✅ **Hardware security** - Private key never leaves the YubiKey
- ✅ **Portable** - Works across different machines
- ✅ **Well-supported** - Mature tooling and documentation
- ✅ **Physical security** - Requires physical touch to sign

**Setup:**
1. Configure GPG on YubiKey (if not already done)
2. Configure Git to use GPG:
   ```bash
   git config --global gpg.format gpg
   git config --global user.signingKey <YOUR_GPG_KEY_ID>
   git config --global commit.gpgsign true
   ```
3. Add GPG key to GitHub/GitLab

**Resources:**
- [YubiKey GPG Setup Guide](https://support.yubico.com/hc/en-us/articles/360013790259-Using-Your-YubiKey-with-Git)
- [GitHub: Adding GPG Key](https://docs.github.com/en/authentication/managing-commit-signature-verification/adding-a-gpg-key-to-your-github-account)

### Option 2: SSH Signing with YubiKey (Advanced)

SSH signing with YubiKey is possible but more complex:

**Requirements:**
- OpenSSH 8.2+ with FIDO2 support
- YubiKey 5 series with FIDO2
- More complex setup

**Advantages:**
- ✅ Hardware security
- ✅ Uses SSH keys (simpler if you already use SSH)

**Disadvantages:**
- ❌ More complex setup
- ❌ Less common, fewer resources
- ❌ Requires FIDO2 support

**Recommendation**: If you have a YubiKey, **use GPG signing** - it's the most mature and well-supported option for hardware-backed commit signing.

## Security Best Practices

1. **Use a dedicated signing key** - Separate from authentication keys (recommended)
2. **Consider hardware security** - YubiKey or other hardware tokens for production use
3. **Protect your private key** - Use a strong passphrase (if not using hardware token)
4. **Never share private keys** - Only share public keys
5. **Rotate keys periodically** - Update keys every 6-12 months
6. **Use Ed25519 keys** - More secure and faster than RSA
7. **Backup your keys** - Store backups securely (for software keys, not hardware tokens)

## Additional Resources

- [Git Documentation: Signing Commits](https://git-scm.com/book/en/v2/Git-Tools-Signing-Your-Work)
- [GitHub: Managing Commit Signature Verification](https://docs.github.com/en/authentication/managing-commit-signature-verification)
- [GitLab: Signing Commits with SSH Keys](https://docs.gitlab.com/ee/user/project/repository/gpg_signed_commits/#ssh-keys)
