import os
import requests
import tarfile
#from clint.textui import colored
from tqdm import tqdm
from pathlib import Path
from tabulate import tabulate

pwd=os.getcwd()
zimbra = os.path.join(pwd, "zimbra.tgz")
src = os.path.join(pwd, "src")

compressed_zimbra = Path(zimbra)
ext_src = Path(src)

url = 'https://files.zimbra.com/downloads/8.8.15_GA/zcs-8.8.15_GA_3869.RHEL7_64.20190918004220.tgz'

def download_zimbra(url, zimbra):
    """
    Download Source Code
    """
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

def decompress(tar_file, path, members=None):
    """
    Extracts `tar_file` and puts the `members` to `path`.
    If members is None, all members on `tar_file` will be extracted.
    """
    tar = tarfile.open(tar_file, mode="r:gz")
    if members is None:
        members = tar.getmembers()
    # with progress bar
    # set the progress bar
    progress = tqdm(members)
    for member in progress:
        tar.extract(member, path=path)
        # set the progress description of the progress bar
        progress.set_description(f"Extracting {member.name}")
    # or use this
    # tar.extractall(members=members, path=path)
    # close the file
    tar.close()

"""
Display message in box
"""

zimbra_msg = """
Zimbra ./src/ folder are available continue with installation if no installation occur
"""

table = [[zimbra_msg]]
display_msg = tabulate(table, tablefmt='grid')

if compressed_zimbra.exists() == False and ext_src.exists() == False:
    download_zimbra(url, zimbra)
    decompress("zimbra.tgz", "src")
    compressed_zimbra.unlink()  
elif compressed_zimbra.exists() and ext_src.exists() == False: 
        decompress("zimbra.tgz", "src")
        compressed_zimbra.unlink()
else:
    print(display_msg)
