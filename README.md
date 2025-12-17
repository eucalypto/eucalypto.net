# eucalypto.net

## Setup after clone

After a git clone, run 

```bash
bash setup-submodules.sh
```

to setup the git submodules for the public generated files and the parsa theme.

## Hugo Version
This blog is built with Hugo:

```bash
hugo version
hugo v0.152.2+extended+withdeploy darwin/arm64 BuildDate=2025-10-24T15:31:49Z VendorInfo=brew
```

I started simply installing Hugo with brew. Previously I used to download the binary, but not anymore.

## Local Development

To start local development, run:

```bash
hugo serve
```

This will build the website in `public/` and create a local server at http://localhost:1313/ and host the generated website.

## Deployment

Once you're satisfied with the locally served result of hugo, you need to run it again to generate the static files again for public hosting:

```bash
hugo build
```

Then go to public/ folder.
Since we've set up the public files as a git submodule, you can commit and push your changes to the submodule with 

```bash
git commit -a
git push
```

This will push the generated static site files to 
https://github.com/eucalypto/public.eucalypto.net

This GitHub repository is set up so that it executes a git hook on push that triggers the hoster to fetch the current state and host the files.

So I can deploy the site simply by pushing to this GitHub repo. The webhook then triggers the netcup's git clone to pull the changes and deploy them to the web server.


## Images workflow

I'm designing the images in a Google presentation:

https://docs.google.com/presentation/d/1ew8Yqg29Gq6ejbp59h3ontfCvc-BSmxdmNN6m8CVHMA

I can download the whole thing or individual slides as jpg or png. But the filesizes are larger than necessary.

To convert them to webp use

```sh
cwebp Instagram-post.png -o Instagram-post.webp
```

I installed cwebp via `brew install webp`
