#/usr/bin/python

'''
@author: r1d1
@date: march 2019
@description:  This script is made to fetch automatically files from thingiverse
'''


import argparse
import json
import time
import os
import requests
from tqdm import tqdm
import numpy as np

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Fetch required models from thingiverse")

    parser.add_argument("--output", "-o", help="output folder", default="./")
    parser.add_argument("--file", "-n", help="source file for models", default=None)
    args = parser.parse_args()
    
    print(args)

    things_data = json.load(open(args.file,'r'))
    count = 0
    
    #for th in things_data['files_thingiverse']:
    max_count = len(things_data['files_thingiverse'])
    file_range = np.arange(0, max_count)
    print(str(max_count)+' files to download:')
    for th in things_data['files_thingiverse']:
        print('- '+th['name'])

    for i in tqdm(file_range):
        th = things_data['files_thingiverse'][i]
        thing_name = th['name']
        file_id = th['url'].replace('https://www.thingiverse.com/thing:', '')
        #link = th['url'].replace('thing:','download:')
        link = os.path.join(th['url'], 'zip')
        __, ext = os.path.splitext(link)
        #print(link)
        output_file = "{}{}.zip".format(thing_name, ext.lower())
        #print(output_file)
        #if organize:
        #    output_file = os.path.join(str(thing_id), output_file)
        output_file = os.path.join(args.output, output_file)
        
        # generate proper link
        # Actual download request:
        sleep_time = 1.0;
        r = None;

        while r is None or r.status_code != 200:
            #print("Downloading {}".format(output_file));
            r = requests.get(link, stream=True);
            if r.status_code == 200:
                with open(output_file, 'wb') as fout:
                    for chunk in r.iter_content(chunk_size=1024):
                        if chunk:
                            fout.write(chunk);
                            count += 1
            else:
                time.sleep(sleep_time);
                sleep_time += 2.0;
                if sleep_time > 600:
                    print("cannot download {}".format(link));
                    break;
        time.sleep(0.1)
