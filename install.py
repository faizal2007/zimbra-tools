import os
import requests
from clint.textui import colored
from tqdm import tqdm
from pathlib import Path

pwd=os.getcwd()
zimbra = os.path.join(pwd, "zimbra.tar.bz2")
source_zimbra = Path(zimbra)
url = 'https://files.zimbra.com/downloads/8.8.15_GA/zcs-8.8.15_GA_3869.RHEL7_64.20190918004220.tgz'

def download_zimbra(url, zimbra):
    r = requests.get(url, stream=True)
    total_size = int(r.headers.get('content-length'))
    block_size = 1024 #1 Kibibyte
    t=tqdm(desc="Downloading Zimbra ... ", total=total_size, unit='iB', unit_scale=True)

    with open(zimbra, 'wb') as f:
        for chunk in r.iter_content(block_size):
            if chunk:
                t.update(len(chunk))
                f.write(chunk)
    t.close()    

if(source_zimbra.exists()):
    print("Source folder available, Remove to re-download.")
else:
    download_zimbra(url, zimbra)
