---
title: Git Tips
date: "2015-04-27T02:36:00Z"
type: "post"
image: "/posts/2015-04-27-git-tips/computer-tools.webp"
tags:
- git
- code
---


If you work with any kind of text files, a version control program is
your best friend. And Git is probably the best.

The easiest way to learn git is [tutorial](https://try.github.io). All other git commands you will learn by googling for them when in need.

If you want to share your code in an open source way, [Github](https://github.com/) is nowadays the top choice. They also helped with the tutorial above.


## Work on several branches simultaneously

In newer versions of git (2.5+), you can open a branch of your local repository
into a separate path without cloning the repo. [Stackoverflow](http://stackoverflow.com/questions/6270193/multiple-working-directories-with-git/30185564#30185564) knows more.

    git worktree add path/to/separate/folder [branch-name]

The only limitation is that you cannot check out the same branch twice. But now
you can work on several branches without having to switch between them. And,
since they all originate from one repository, you can push them with one
command.


## Compare all local branches with remote

If you use more than one branch in git, you may want to keep them also
backed up in a remote repository. And to keep track of all branches and
their relation to the remote ones, there are commands like

{{< highlight bash >}}
git fetch -v
git branch -v
{{< / highlight >}}

Linux users may be familiar with this flag `-v`, which stands for
`verbose`, for many programs. Also here, it makes git list all branches
and their status compared to remote.



## Change the url (path) of origin

With

{{< highlight bash >}}
git remote -v
{{< / highlight >}}

you can check what the current url (path) to your remotes are. Now to
[change](https://help.github.com/articles/changing-a-remote-s-url/)
(update) the url just use

{{< highlight bash >}}
git remote set-url origin https://new.git.repo.url
{{< / highlight >}}



## Make branch track remote branch

If you create a new branch locally and want to push it to origin, use

{{< highlight bash >}}
git push -u origin branch-name
{{< / highlight >}}

to push it and set the local branch to
[track](http://stackoverflow.com/questions/520650/make-an-existing-git-branch-track-a-remote-branch/2286030#2286030)
its remote copy.

If you forgot to do this, you can use

{{< highlight bash >}}
git branch -u origin/branch-name
{{< / highlight >}}

to start tracking after a push.


## Manage several remotes

### Checking out remote branches

Having several remotes as backup may be a good idea. Let's say you want to check
out a new (remote) branch. If you have several remotes, then doing

{{< highlight bash >}}
git fetch
git checkout branchname
{{< / highlight >}}

*doesn't* work. You need to do

{{< highlight bash >}}
git checkout -b branchname remote-name/branchname
{{< / highlight >}}

according to [stackoverflow](http://stackoverflow.com/questions/1783405/how-to-check-out-a-remote-git-branch).

### Push to several remotes

Now that we have several remotes, we want to keep them up to date. But pushing
each one separately is too much work!
[Stackoverflow](http://stackoverflow.com/questions/14290113/git-pushing-code-to-two-remotes)
suggests to create a new remote and add extra push urls:

{{< highlight bash >}}
git remote add all git://repo1.url
git remote set-url --add --push all git://repo2.url
{{< / highlight >}}

Unfortunately the last command overwrites the original url for pushing; so we
have to add it back with

{{< highlight bash >}}
git remote set-url --add --push all git://repo1.url
{{< / highlight >}}

Now, we can use the remote `all` as the new remote repository that our branches
track. `Push{nbsp}all` pushes to all repositories, but `pull` only fetches the
first repository.


## Recover lost files (discard changes)

The more I use git the more I love it! One of the nicest features of git is that
you can undo changes -- including deletion of files. I wanted to remove some
files and accidentally typed: `rm{nbsp}something{nbsp}\*`, whereas I wanted
`rm{nbsp}something*`. But of course bash didn't know that and merrily deleted
everything in my directory (except a folder).

But as always, git
[saves the day](http://stackoverflow.com/questions/52704/how-do-you-discard-unstaged-changes-in-git). With

{{< highlight bash >}}
git checkout -- /path/to/file
{{< / highlight >}}

you can discard any changes on this file. Including deletion.

If you want to do this for every file in the current directory, type:

{{< highlight bash >}}
git checkout -- .
{{< / highlight >}}

The dot is important.



## Copy (checkout) files from other branches

Sometimes you want to
http://nicolasgallagher.com/git-checkout-specific-files-from-another-branch/[fetch
some files] from another branch. But you don't want to check out the
whole branch; just copy some files from it.

Git can do this already:

{{< highlight bash >}}
git checkout other_branch -- path/to/files/
{{< / highlight >}}

Just use `--` with `git checkout` and it just fetches those files while
staying in the current branch. Sweet!



## Combine (squash) commits

If you want to
[combine](http://stackoverflow.com/questions/5189560/squash-my-last-x-commits-together-using-git/5201642#5201642)
the last few commits into one, you can use

{{< highlight bash >}}
git reset --soft HEAD~3
{{< / highlight >}}

to go back to the third commit before HEAD. With the `--soft` option,
you keep all files and changes from current working directory.

Now you can commit those changes with one commit!



## Extract Subtrees

If your project becomes large or if you are like me and have a git
repository for many things, you may want to extract a part of it and
keep the commits.

Git gives you a history of a certain file with

    git log -- special.file

But git can also
[extract](https://ariya.io/2014/07/extracting-parts-of-git-repository-and-keeping-the-history) the history of a sub-folder into a separate branch:

    git-subtree split --prefix=path/to/subfolder --branch=new-branch

But this works only with sub-folders. So my tips are

* keep separate stuff in separate folders
* split up large commits that change separate parts
