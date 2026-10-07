[Generating a new SSH key and adding it to the ssh-agent - GitHub Docs](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
[Adding a new SSH key to your GitHub account - GitHub Docs](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)

```shell
ssh-keygen -t ed25519 -C "your_email@example.com"
```

```shell
$ eval "$(ssh-agent -s)"
> Agent pid 59566
```

```shell
ssh-add ~/.ssh/id_ed25519
```

```shell
$ cat ~/.ssh/id_ed25519.pub
# Then select and copy the contents of the id_ed25519.pub file
# displayed in the terminal to your clipboard
```

# IMPORTANTE

O nome da chave tem que ser **id_ed25519** para que o git reconheça automaticamente, caso contrário é necessário fixar o nome do arquivo no repositório:

git config --local core.sshCommand "ssh -i ~/.ssh/id_ed25519-<<custom-name>> n -o IdentitiesOnly=yes"

git pull --prune