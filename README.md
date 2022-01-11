# d2l RecSys Chapter For Korean


## Quick-Start

Clone the repository

```{shell}
git clone https://github.com/pyy0715/d2l_RecSys_for_Korean.git
cd d2l_RecSys_for_Korean
```

Build Docker-image from dockerfile(It takes about 5 minutes)
```{shell}
docker build -t yyeon/d2l_study:cu101 ./  
```

After the build, run docker container
```{shell}
bash Docker.sh

# if you use zsh, run the bellow command
zsh Docker.sh
```

This will open the Jupyter Notebook in your browser.
It will open to the address below because it has been port-forwarded to port `18888`.
