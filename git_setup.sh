# Executable

echo "Type in your first and last name (no accent or special characters - e.g. 'ç'): "
read full_name

echo "GitHub: Type in your email address: "
read email_github

echo "Gitee: Type in your email address: "
read email_gitee

echo "GitLab: Type in your email address : "
read email_gitlab


git config --global user.email $email_github
git config --global user.name $full_name

ssh-keygen -t rsa -b 4096 -C $email_github -f ~/.ssh/id_rsa
ssh-keygen -t rsa -b 4096 -C $email_gitee -f ~/.ssh/gitee_id_rsa
ssh-keygen -t rsa -b 4096 -C $email_gitlab -f ~/.ssh/gitlab_id_rsa

# alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"
echo '=> Public key is'
cat ~/.ssh/id_rsa
echo "Now, go to Github.com to paste the Public key"
echo " "
cat ~/.ssh/gitee_id_rsa
echo "Now, go to Gitee.com to paste the Public key"
echo " "
cat ~/.ssh/gitlab_id_rsa
echo "Now, go to GitLab.com to paste the Public key"

touch ~/.ssh/config
cat>~/.ssh/config<<EOF
# github
Host github.com
HostName github.com
PreferredAuthentications publickey
IdentityFile ~/.ssh/id_rsa
# gitee
Host gitee.com
HostName gitee.com
PreferredAuthentications publickey
IdentityFile ~/.ssh/gitee_id_rsa
# gitlab
Host git.emnets.org
HostName git.emnets.org
PreferredAuthentications publickey
IdentityFile ~/.ssh/gitlab_id_rsa
EOF