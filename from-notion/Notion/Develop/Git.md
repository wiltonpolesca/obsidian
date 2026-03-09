---

---
| Objetivo | Comando |
| --- | --- |
| Clean   all untracked files | git   clean -f |
| Clean   and remove directories | git   clean -fd |
| Clean   and remove ignored files | git   clean -f -X |
| Clean   and remove all ignored and non-ignored files | git   clean -f -x |
| Clean   all not pushed to a remote server | git   reset --hard origin/develop |
| Reset   the code to a specific commit | git   reset --hard <<commit ref>> |
| How to   apply path | [https://stackoverflow.com/questions/42800902/git-generate-patch-for-all-commits-in-a-branch](https://stackoverflow.com/questions/42800902/git-generate-patch-for-all-commits-in-a-branch) |
| File   Blame | git log   -p --[file name] |
| Undo a commit and unstaged all files> | git   reset --soft HEAD~1 |
| How to create a path | git diff develop [YOURBRANCH] > ./patchfile |
| How to apply a path | go to a branch where you want to apply the pathrun:  git apply <<patchfile>> |

Config

[user]

email = wiltonpolesca@gmail.com

Using path on git

[https://stackoverflow.com/questions/42800902/git-generate-patch-for-all-commits-in-a-branch](https://stackoverflow.com/questions/42800902/git-generate-patch-for-all-commits-in-a-branch)

diff3 => to help on conflicts

[https://blog.nilbus.com/take-the-pain-out-of-git-conflict-resolution-use-diff3/](https://blog.nilbus.com/take-the-pain-out-of-git-conflict-resolution-use-diff3/)