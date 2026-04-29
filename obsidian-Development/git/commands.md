# Git common commands

| Description                                          | Command                      | Informations                                                                       |
| ---------------------------------------------------- | ---------------------------- | ---------------------------------------------------------------------------------- |
| Undo commits and unstage all files                   | git reset --soft HEAD~1      | The number of commits can be changed, example: HEAD~23 (reset the last 23 commits) |
| Clean all local changes and not pushed remote server | git reset --hard origin/main | You must define your remote branch: origin/main; origin/developer; ...             |
| Clean all untracked files                            | git clean -f                 |                                                                                    |
| Clean all untreacked files and remove directories    | git clean -fd                |                                                                                    |
| Clean all untracked files and remove ignored files   | git clean -f -X              |                                                                                    |
