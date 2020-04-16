# Executable

echo "Type in your first and last name (no accent or special characters - e.g. 'ç'): "
read full_name

echo "Type in your email address (the one used for your GitHub account): "
read email

git config --global user.email $email
git config --global user.name $full_name

ssh-keygen -t rsa -b 4096 -C $email

# alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'

echo "Now, go to Github.com to paste the Public key"

# The rest of my fun git aliases
# Moved to zshrc.conf