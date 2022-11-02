# eucalypto.net

This version is build with Hugo:

```bash
hugo v0.104.3-58b824581360148f2d91f5cc83f69bd22c1aa331 darwin/amd64 BuildDate=2022-10-04T14:25:23Z VendorInfo=gohugoio
```

https://github.com/gohugoio/hugo/releases/tag/v0.104.3

I've copied the hugo executable into the root directory of this project, but excluded it from git. You should be able to
download and run the version above. :)

After cloning, you need to load the theme as a submodule.

```bash
git submodule init
git submodule update
```

I've forked the theme so that there won't be any unexpected changes for me: https://github.com/eucalypto/beautifulhugo  

Add Parsa theme as submodule:

```bash
/eucalypto.net$ git submodule add git@github.com:eucalypto/parsa-hugo.git themes/parsa-hugo
```


## Deployment
### Local preparations

I can publish the generated html pages from ./public/ into a git repository that I set up at my hoster. For that I need a separate branch named `public`.

Since hugo generates the files into the folder `public`, I can use git worktree to check out the branch into this folder:
```bash
git worktree add public/ public
```

I'm not using git to deploy the site, but it's still good to have the actual "artefact" also versioned here in git. :)

### Actual Deployment
#### Via FTP
I'm using Filezilla and I've created an extra ftp account how-to-human-ftp that I'm using for the credentials. In Filezilla, I've set up the "Explicit FTP over TLS" option, to make the FTP secure. Then I simply have to copy everything from `/public/*` to `/*` on the ftp side.

#### Not via git
My hosting provider allows me to create a git repository that I can push changes to. But it uses the credentials of the single webmaster account. I would like to use separate credentials. So I.m using the FTP solution above. 