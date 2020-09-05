import os
import urllib.request

def main():
    url = 'https://raw.githubusercontent.com/bee-san/karis/master/karis.sh'

    urllib.request.urlretrieve(url, '/tmp/karis.sh')
    os.system("chmod +x /tmp/karis.sh")
    os.system("cd /tmp/ && ./karis.sh")