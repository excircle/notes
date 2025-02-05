# How to Cherry Pick Commits In Git

If you have a branch that has multiple commits, and your intention is to only move one of those commits to main, this is what that would look like.

Take the commit log below. I created on Feb 4 that I wished to merge to 'main'

```bash
➜  kill-runner git:(cka) ✗ git log | head -15
commit 3f149906dc16f72c83ff910de1878483e594264d # I want to merge this into 'main'
Author: Alexander Kalaj <unixdisciple.us@gmail.com>
Date:   Tue Feb 4 15:53:20 2025 -0800

    Adding svc and rbac functions

commit d1ecaf5cd2646dd4fe618d7e2c9026b46f72bd92 # I DO NOT want to merge
Author: Alexander Kalaj <unixdisciple.us@gmail.com>
Date:   Mon Feb 3 16:16:36 2025 -0800

    Adding Q1-Q3
```

The sequence of events should be as follows:

| command | description | 
| - | - |
| `git checkout main` | Bring up your main branch |
| `git pull origin main` | Sync you main branch |
| `git cherry-pick $COMMIT-HASH` | Specify the git commit you wish to work with |
| `git push origin main` | Push changes to the main |

Here's the BASH commands showing this process:

```bash
➜  kill-runner git:(cka) ✗ git checkout main

M	cmd/stage.go
M	cmd/start.go
M	cmd/unstage.go
M	cmd/validate.go
Switched to branch 'main'
Your branch is up to date with 'origin/main'.

➜  kill-runner git:(main) ✗ git pull origin main

remote: Enumerating objects: 12, done.
remote: Counting objects: 100% (12/12), done.
remote: Compressing objects: 100% (7/7), done.
remote: Total 7 (delta 3), reused 0 (delta 0), pack-reused 0 (from 0)
Unpacking objects: 100% (7/7), 3.70 KiB | 420.00 KiB/s, done.
From https://github.com/excircle/kill-runner
 * branch            main       -> FETCH_HEAD
   0c5d851..97fdb06  main       -> origin/main
Updating 0c5d851..97fdb06
Fast-forward
 Q2/pod.yaml               | 13 -------------
 Q2/pod1-status-command.sh |  1 -
 pkg/cluster/deployment.go | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 pkg/cluster/pod.go        | 30 ++++++++++++++++++++++++++++++
 pkg/cluster/service.go    | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 156 insertions(+), 14 deletions(-)
 delete mode 100644 Q2/pod.yaml
 delete mode 100644 Q2/pod1-status-command.sh
 create mode 100644 pkg/cluster/deployment.go
 create mode 100644 pkg/cluster/service.go

➜  kill-runner git:(main) ✗ git cherry-pick 3f149906dc16f72c83ff910de1878483e594264d
[main d2b45ff] Adding svc and rbac functions
 Date: Tue Feb 4 15:53:20 2025 -0800
 1 file changed, 66 insertions(+)
 create mode 100644 pkg/cluster/svc-and-rbac.go
➜  kill-runner git:(main) ✗ git status
On branch main
Your branch is ahead of 'origin/main' by 1 commit.
  (use "git push" to publish your local commits)

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   cmd/stage.go
	modified:   cmd/start.go
	modified:   cmd/unstage.go
	modified:   cmd/validate.go

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	Q6/
	cmd/questions/q4.go
	cmd/questions/q5.go
	cmd/questions/q6.go

no changes added to commit (use "git add" and/or "git commit -a")

➜  kill-runner git:(main) ✗ git push origin main

Enumerating objects: 8, done.
Counting objects: 100% (8/8), done.
Delta compression using up to 11 threads
Compressing objects: 100% (5/5), done.
Writing objects: 100% (5/5), 989 bytes | 989.00 KiB/s, done.
Total 5 (delta 2), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To https://github.com/excircle/kill-runner.git

```

